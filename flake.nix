{
  description = "Development environment with Bun";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    bun-canary.url = "github:VV01T3K/nix-container/nix-bun-canary";
  };

  outputs = { self, nixpkgs, flake-utils, bun-canary }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        bun = bun-canary.packages.${system}.default;
      in
      with pkgs; {
        devShells.default = mkShell {
          buildInputs = [
            bun
            lolcat
            # Add other dependencies here
          ];

          shellHook = ''
            export BUN_VERSION="$(bun --version)"
            echo "Using Bun version: $BUN_VERSION" | lolcat
            echo test
          '';
        };
      }
    );
}