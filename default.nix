{
  pkgs ? import <nixpkgs> { },
}:

pkgs.stdenv.mkDerivation rec {
  pname = "juvix";
  version = "0.6.8";

  src = pkgs.fetchurl {
    url = "https://github.com/anoma/juvix/releases/download/v${version}/juvix-linux-x86_64.tar.gz";
    sha256 = "LEZdB+9/+Xnf/W+1zkF014WZZmfADcU38O5Yz4v8k2w=";
  };

  nativeBuildInputs = [
    pkgs.autoPatchelfHook
  ];

  buildInputs = [
    pkgs.glibc
    pkgs.gcc-unwrapped
    pkgs.zlib
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

  meta = with pkgs.lib; {
    description = "Juvix - a high-level programming language for writing efficient formal proofs and programs";
    homepage = "https://github.com/anoma/juvix";
    license = licenses.gpl3Only;
    platforms = [ "x86_64-linux" ];
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
  };
}