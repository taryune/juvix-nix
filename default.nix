{
  lib,
  stdenv,
  fetchurl,
  autoPatchelfHook,
  glibc,
  gcc-unwrapped,
  zlib,
}:

stdenv.mkDerivation rec {
  pname = "juvix";
  version = "0.6.8";

  src = fetchurl {
    url = "https://github.com/anoma/juvix/releases/download/v${version}/juvix-linux-x86_64.tar.gz";
    sha256 = "LEZdB+9/+Xnf/W+1zkF014WZZmfADcU38O5Yz4v8k2w=";
  };

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  buildInputs = [
    glibc
    gcc-unwrapped
    zlib
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

  meta = with lib; {
    description = "Juvix - a high-level programming language for writing efficient formal proofs and programs";
    homepage = "https://github.com/anoma/juvix";
    license = licenses.gpl3Only;
    platforms = [ "x86_64-linux" ];
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
  };
}
