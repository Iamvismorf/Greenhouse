{
  pkgs,
  config,
  lib,
  myLib,
  ...
}: {
  options = {
    misc.enable = myLib.mkTrueOption "enable misc module";
  };
  config = lib.mkIf config.misc.enable {
    # for mounting phone
    services.gvfs.enable = true;
    qt.enable = true;
    environment.etc."/xdg/menus/applications.menu".text = builtins.readFile "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";
  };
}
