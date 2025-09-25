{myLib, ...}: {
  imports = myLib.importDir {
    dir = ./.;
    subdir = true;
    eF = ["theme.nix"];
  };
}
