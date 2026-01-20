{stdenv}:
stdenv.mkDerivation rec {
  name = "program-${version}";
  version = "1.0";

  src = ./.;

  nativeBuildInputs = [];
  buildInputs = [];

  buildPhase = ''
    gcc program.c -o myprogram
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp myprogram $out/bin
  '';
}
