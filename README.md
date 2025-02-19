# Bun Canary Nix Package

This repository contains a Nix package for the Bun JavaScript runtime (canary version).

## Usage

You can use this package in several ways:


### As a flake input (recommended)

Add to your `flake.nix`:

```nix
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    bun-canary = {
      url = "github:VV01T3K/nix-container/nix-bun-canary";
      inputs = {
        flake-utils.follows = "flake-utils";
        nixpkgs.follows = "nixpkgs";
      };
    };
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
          ];
        };
      }
    );
```
### With `nix run`

```bash
nix run github:VV01T3K/nix-container/nix-bun-canary --no-write-lock-file
```

### With `nix shell`

```bash
nix shell github:VV01T3K/nix-container/nix-bun-canary --no-write-lock-file
```

## Supported Platforms

- x86_64-linux
- aarch64-linux
- x86_64-darwin
- aarch64-darwin