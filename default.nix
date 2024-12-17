{
  lib,
  stdenv,
  fetchurl,
  autoPatchelfHook,
  wasmer,
  wasi-sdk ? null,
  llvmPackages_14,
}:
stdenv.mkDerivation rec {
  pname = "juvix";
  version = "0.6.8";
  src = fetchurl {
    url = "https://github.com/anoma/juvix/releases/download/v${version}/juvix-linux-x86_64.tar.gz";
    sha256 = "sha256-LEZdB+9/+Xnf/W+1zkF014WZZmfADcU38O5Yz4v8k2w=";
  };
  nativeBuildInputs = [
    autoPatchelfHook
    llvmPackages_14.clang
    llvmPackages_14.lld
  ];
  buildInputs = [
    wasmer
    llvmPackages_14.libclang
  ];

  dontStrip = true;

  unpackPhase = ''
    runHook preUnpack
    mkdir -p source
    cd source
    tar xf $src
    runHook postUnpack
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    cp juvix $out/bin/
    chmod +x $out/bin/juvix
    runHook postInstall
  '';

  preFixup = lib.optionalString (wasi-sdk != null) ''
    # Set WASI paths in the binary wrapper
    wrapProgram $out/bin/juvix \
      --set WASI_SYSROOT_PATH ${wasi-sdk}/share/wasi-sdk/wasi-sysroot \
      --set CLANG_WASI_LIB_PATH ${wasi-sdk}/share/wasi-sdk/lib \
      --prefix PATH : ${llvmPackages_14.lld}/bin
  '';

  meta = with lib; {
    description = "Juvix - a high-level programming language for writing efficient formal proofs and programs";
    homepage = "https://github.com/anoma/juvix";
    license = licenses.gpl3Only;
    platforms = [ "x86_64-linux" ];
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
  };
}
