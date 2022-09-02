{ pkgs
, stdenv
, fetchFromGitHub
, gcc-arm-embedded
, ...
}:

with pkgs;

stdenv.mkDerivation {
  name = "saturn-v";
  src = fetchFromGitHub {
    owner = "greatscottgadgets";
    repo = "saturn-v";
    rev = "42c50d4cb645c071dd77c8ad34cc9b9496e7f86e";
    sha256 = "1z6jp18hdqy6k11pr6amrz2dnq2fw0dlwdb14isaxvdadhif31xh";
  };
  buildInputs = [ gcc-arm-embedded ];
  installPhase = ''
    mkdir -p $out
    cp bootloader.{bin,elf,hex} $out
  '';
  dontFixup = true;
}
