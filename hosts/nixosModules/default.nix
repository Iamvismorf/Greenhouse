{myLib, ...}: {
  imports = myLib.importDir {
    dir = ./.;
    eF = ["opentablet.nix" "test/default.nix"];
    subdir = true;
  };
}
