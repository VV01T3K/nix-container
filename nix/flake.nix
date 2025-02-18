{
  description = "Development environment with Bun";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        bun-canary = pkgs.callPackage ./bun-canary.nix {};
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