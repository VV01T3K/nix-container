{ lib
, stdenvNoCC
, fetchurl
, autoPatchelfHook
, unzip
, installShellFiles
, makeWrapper
, openssl
, writeShellScript
, curl
, jq
, common-updater-scripts
, darwin
}:

stdenvNoCC.mkDerivation rec {
  version = "canary";
  pname = "bun";

  src = passthru.sources.${stdenvNoCC.hostPlatform.system} or (throw "Unsupported system: ${stdenvNoCC.hostPlatform.system}");

  sourceRoot = {
    aarch64-darwin = "bun-darwin-aarch64";
    x86_64-darwin = "bun-darwin-x64";
    aarch64-linux = "bun-linux-aarch64";
    x86_64-linux = "bun-linux-x64";
  }.${stdenvNoCC.hostPlatform.system} or (throw "Unsupported system: ${stdenvNoCC.hostPlatform.system}");

  strictDeps = true;
  nativeBuildInputs = [ unzip installShellFiles makeWrapper ] ++ lib.optionals stdenvNoCC.hostPlatform.isLinux [ autoPatchelfHook ];
  buildInputs = [ openssl ];

  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    runHook preInstall

    install -Dm 755 ./bun $out/bin/bun
    ln -s $out/bin/bun $out/bin/bunx-canary

    runHook postInstall
  '';

  postPhases = [ "postPatchelf"];
  postPatchelf =
    lib.optionalString stdenvNoCC.hostPlatform.isDarwin ''
      wrapProgram $out/bin/bun \
        --prefix DYLD_LIBRARY_PATH : ${lib.makeLibraryPath [ darwin.ICU ]}
    ''
    + lib.optionalString
      (
        stdenvNoCC.buildPlatform.canExecute stdenvNoCC.hostPlatform
        && !(stdenvNoCC.hostPlatform.isDarwin && stdenvNoCC.hostPlatform.isx86_64)
      )
      ''
        completions_dir=$(mktemp -d)

        SHELL="bash" $out/bin/bun completions $completions_dir
        SHELL="zsh" $out/bin/bun completions $completions_dir
        SHELL="fish" $out/bin/bun completions $completions_dir

        installShellCompletion --name bun \
          --bash $completions_dir/bun.completion.bash \
          --zsh $completions_dir/_bun \
          --fish $completions_dir/bun.fish
      '';

  passthru = {
    sources = {
      "aarch64-darwin" = fetchurl {
        url = "https://github.com/oven-sh/bun/releases/download/canary/bun-darwin-aarch64.zip";
        hash = null;
      };
      "aarch64-linux" = fetchurl {
        url = "https://github.com/oven-sh/bun/releases/download/canary/bun-linux-aarch64.zip";
        hash = null;
      };
      "x86_64-darwin" = fetchurl {
        url = "https://github.com/oven-sh/bun/releases/download/canary/bun-darwin-x64.zip";
        hash = null;
      };
      "x86_64-linux" = fetchurl {
        url = "https://github.com/oven-sh/bun/releases/download/canary/bun-linux-x64.zip";
        hash = null;
      };
    };
    updateScript = writeShellScript "update-bun" ''
      set -o errexit
      export PATH="${lib.makeBinPath [ curl jq common-updater-scripts ]}"
      # Since canary is a moving target, this script may not work as-is
      LATEST_COMMIT=$(curl --silent https://api.github.com/repos/oven-sh/bun/commits/canary | jq -r '.sha')
      for platform in ${lib.escapeShellArgs meta.platforms}; do
        update-source-version "bun" "$LATEST_COMMIT" --source-key="sources.$platform" --version-key=version
      done
    '';
  };
  meta = with lib; {
    homepage = "https://bun.sh";
    changelog = "https://bun.sh/blog/bun-v${version}";
    description = "Incredibly fast JavaScript runtime, bundler, transpiler and package manager – all in one (canary version)";
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
    longDescription = ''
      All in one fast & easy-to-use tool. Instead of 1,000 node_modules for development, you only need bun.
      This is the canary version, which includes the latest features and updates but may be less stable.
    '';
    license = with licenses; [ mit lgpl21Only ];
    mainProgram = "bun";
    maintainers = with maintainers; [ no_name ];
    platforms = builtins.attrNames passthru.sources;
    broken = stdenvNoCC.hostPlatform.isMusl;
    hydraPlatforms = lib.lists.remove "x86_64-darwin" lib.platforms.all;
  };
}