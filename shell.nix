let
  pkgs = import <nixpkgs> { };
  juvix = pkgs.callPackage ./default.nix { };
  wasi-sdk = pkgs.callPackage ./wasi-sdk.nix { };
in
pkgs.mkShell {
  buildInputs = [
    juvix
    pkgs.wasmer
    pkgs.llvmPackages_14.clang
    pkgs.llvmPackages_14.libclang
    pkgs.llvmPackages_14.lld
  ];

  shellHook = ''
    echo "Juvix development shell"

    # Set up environment variables
    export WASI_SYSROOT_PATH="${wasi-sdk}/share/wasi-sdk/wasi-sysroot"
    export CLANG_WASI_LIB_PATH="${wasi-sdk}/share/wasi-sdk/lib"
    export PATH="${pkgs.llvmPackages_14.lld}/bin:$PATH"
    echo "Juvix version: $(juvix --version)"
  '';
}
