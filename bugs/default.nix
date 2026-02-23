{myLib, ...}: {
  imports = myLib.importDir {
    dir = ./.;
    subdir = true;
    eF = ["_theme.nix"];
  };
}
