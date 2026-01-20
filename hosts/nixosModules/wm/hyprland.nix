{
  myLib,
  config,
  lib,
  sources,
  pkgs,
  ...
}: let
  hyprland = (myLib.flakeToNix {src = sources.hyprland;}).defaultNix;
in {
  options = {
    hyprland.enable = myLib.mkTrueOption "enable hyprland module";
  };
  config = lib.mkIf config.hyprland.enable {
    programs.hyprland = {
      enable = true;
      withUWSM = true;
      package = hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage = hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };

    xdg.portal = {
      config.hyprland = {
        default = [
          "hyprland"
          # "kde"
          "gtk"
        ];
      };
      configPackages = [
        # pkgs.kdePackages.xdg-desktop-portal-kde
        pkgs.xdg-desktop-portal-gtk
      ];
      extraPortals = [
        pkgs.kdePackages.xdg-desktop-portal-kde
        pkgs.xdg-desktop-portal-gtk
        #no need for hyprland because is enabled by programs.hyprland
      ];
    };

    environment.systemPackages = [
      pkgs.kdePackages.qtwayland
      pkgs.libsForQt5.qt5.qtwayland
      pkgs.hyprpolkitagent
      # pkgs.kdePackages.qt6ct
    ];
  };
}
