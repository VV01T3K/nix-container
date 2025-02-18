{
  description = "Bun Canary Nix Package";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        packages = {
          bun-canary = pkgs.callPackage ./packages/bun-canary.nix { };
          default = self.packages.${system}.bun-canary;
        };
      }
    );
}