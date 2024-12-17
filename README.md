# Juvix Nix Package

This repository contains the Nix package definition for [Juvix](https://github.com/anoma/juvix), a dependently-typed programming language for writing efficient formal proofs and programs.

## Installation

### Using Flakes (recommended)

Add to your `flake.nix`:

```nix
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    juvix-nix.url = "github:taryune/juvix-nix";
  };

  outputs = { self, nixpkgs, juvix-nix, ... }: {
    # For NixOS system configuration
    nixosConfigurations.your-hostname = nixpkgs.lib.nixosSystem {
      modules = [
        {
          nixpkgs.overlays = [
            juvix-nix.overlays.default
          ];
        }
      ];
    };

    # Or for home-manager
    homeConfigurations.your-username = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      modules = [
        {
          nixpkgs.overlays = [
            juvix-nix.overlays.default
          ];
          home.packages = [ pkgs.juvix ];
        }
      ];
    };
  };
}
```

## Development

### With Flakes

Build the package:
```bash
nix build
```

Enter development shell:
```bash
nix develop
```

### Without Flakes

Build the package:
```bash
nix-build
```

Enter development shell:
```bash
nix-shell
```

## License

This Nix package definition is released under the MIT License. Juvix itself is licensed under GPL-3.0.
