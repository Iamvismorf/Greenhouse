{
  stdenv,
  pkgs,
}:
stdenv.mkDerivation {
  pname = "vixmonitor";
  version = "1.0";
  src = ./.;
  buildInputs = [
    pkgs.qt6.qtbase
    pkgs.qt6.qtdeclarative
    pkgs.rocmPackages.amdsmi
  ];
  nativeBuildInputs = [
    pkgs.cmake
    pkgs.kdePackages.wrapQtAppsHook
  ];
}
