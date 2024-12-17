let
  pkgs = import <nixpkgs> { };
  juvix = pkgs.callPackage ./default.nix { };
in
pkgs.mkShell {
  buildInputs = [
    juvix
  ];

  shellHook = ''
    echo "Juvix development shell"
    echo "Juvix version: $(juvix --version)"
  '';
}
