{
  pkgs ? import <nixpkgs> { },
}:

pkgs.stdenv.mkDerivation {
  pname = "wasi-sdk";
  version = "16.0";

  srcs = [
    (pkgs.fetchurl {
      url = "https://github.com/WebAssembly/wasi-sdk/releases/download/wasi-sdk-16/wasi-sysroot-16.0.tar.gz";
      sha256 = "sha256-uL/A1JQMkbySBqIxajyT4B4gPGoaxxv6Wiqlx08yfuc=";
    })
    (pkgs.fetchurl {
      url = "https://github.com/WebAssembly/wasi-sdk/releases/download/wasi-sdk-16/libclang_rt.builtins-wasm32-wasi-16.0.tar.gz";
      sha256 = "sha256-hqiO2AukLVgfITm/3PGm3r7sVY4zee+F5pKXV5x1gkE="; # Update this hash
    })
  ];

  sourceRoot = ".";

  unpackPhase = ''
    for src in $srcs; do
      tar xf $src
    done
  '';

  installPhase = ''
    mkdir -p $out/share/wasi-sdk
    mv * $out/share/wasi-sdk/
  '';

  meta = with pkgs.lib; {
    description = "WASI SDK with sysroot and builtins";
    platforms = platforms.linux;
  };
}
