# Juvix Nix Package

This repository contains the Nix package definition for [Juvix](https://github.com/anoma/juvix), a dependently-typed programming language for writing efficient formal proofs and programs.

## Usage

### Using with `nix-shell`

```bash
nix-shell
```

### Installing with NixOS

Add to your `configuration.nix`:
```nix
{
  nixpkgs.overlays = [
    (self: super: {
      juvix = self.callPackage (builtins.fetchGit {
        url = "https://github.com/taryune/juvix-nix.git";
        ref = "main";
      }) {};
    })
  ];
}
```

### Installing with home-manager

Add to your home-manager configuration:
```nix
{
  nixpkgs.overlays = [
    (self: super: {
      juvix = self.callPackage (builtins.fetchGit {
        url = "https://github.com/taryune/juvix-nix.git";
        ref = "main";
      }) {};
    })
  ];

  home.packages = [ pkgs.juvix ];
}
```

## Development

To build the package:
```bash
nix-build
```

To enter development shell:
```bash
nix-shell
```

## License

This Nix package definition is released under the MIT License. Juvix itself is licensed under GPL-3.0.
