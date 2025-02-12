{ pkgs ? import <nixpkgs> {} }:

let
  bun-canary = pkgs.callPackage ./bun-canary.nix {};
in
pkgs.mkShell {
  buildInputs = [
    bun-canary
    # Add other dependencies here
  ];

  shellHook = ''
    export BUN_VERSION="$(bun --version)"
    echo "Using Bun version: $BUN_VERSION"
  '';
}