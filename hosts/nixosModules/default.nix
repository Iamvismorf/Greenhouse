{myLib, ...}: {
  imports = myLib.importDir {
    dir = ./.;
    eF = ["opentablet.nix"];
    subdir = true;
  };
}
