{
  pkgs,
  config,
  lib,
  myLib,
  sources,
  ...
}: {
  options = {
    systemPackages.enable = myLib.mkTrueOption "enable systemPackages module";
  };

  config = lib.mkIf config.systemPackages.enable {
    environment.systemPackages = builtins.attrValues {
      inherit
        (pkgs)
        tree
        git
        yazi
        neovim
        firefox
        kitty
        nh
        wl-clipboard
        glib
        brightnessctl
        libnotify
        npins
        ;
    };
  };
}
