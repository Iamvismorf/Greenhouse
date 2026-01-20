{myLib, ...}: {
  imports = myLib.importDir {
    dir = ./.;
    eF = ["opentablet.nix" "hyprland.nix"];
    subdir = true;
  };
}
