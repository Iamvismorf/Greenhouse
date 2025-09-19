{myLib, ...}: {
  imports = myLib.importDir {
    dir = ./.;
  };
  qt.enable = true;
  # services.xserver.xkb = {
  #   layout = "us";
  #   variant = "";
  # };
}
