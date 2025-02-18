{
  description = "Development environment with Bun";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    bun-canary-src = {
      url = "https://raw.githubusercontent.com/VV01T3K/nix-container/refs/heads/nix-bun-cannary/bun-canary.nix";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, flake-utils, bun-canary-src }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        bun-canary = pkgs.callPackage (builtins.readFile bun-canary-src) {};
      in
      with pkgs; {
        devShells.default = mkShell {
          buildInputs = with pkgs; [
            bun-canary
            # Add other dependencies here
          ];

          shellHook = ''
            export BUN_VERSION="$(bun --version)"
            echo "Using Bun version: $BUN_VERSION"
          '';
        };
      });
}