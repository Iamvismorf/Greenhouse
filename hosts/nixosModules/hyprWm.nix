{
  myLib,
  config,
  lib,
  fl-compat,
  sources,
  pkgs,
  ...
}: let
  hyprland =
    (fl-compat {
      src = sources.hyprland;
    }).defaultNix;
in {
  options = {
    hyprWm.enable = myLib.mkTrueOption "enable hyprWm module";
  };
  config = lib.mkIf config.hyprWm.enable {
    programs.uwsm = {
      enable = true;
      waylandCompositors = {
        hyprland = {
          prettyName = "Hyprland";
          binPath = "/run/current-system/sw/bin/Hyprland";
        };
      };
    };
    programs.hyprland = {
      enable = true;
      withUWSM = true;
      package = hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage = hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };

    xdg.portal = {
      enable = true;
      config = {
        hyprland = {
          default = [
            "hyprland"
            "kde"
          ];
        };
      };
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
      pkgs.kdePackages.qt6ct
    ];
  };
}
