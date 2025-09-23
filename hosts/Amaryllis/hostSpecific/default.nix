{myLib, ...}: {
  imports = myLib.importDir {
    dir = ./.;
    eF = ["default.nix" "bootloader.nix"];
  };
}
