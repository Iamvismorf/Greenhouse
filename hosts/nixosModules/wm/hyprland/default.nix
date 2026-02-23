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
    hyprland.enable = myLib.mkEnabledByDefault null;
    hyprland.buildFromFlakes = myLib.mkEnabledByDefault "whether to build Hyprland from source ";
  };
  config = lib.mkIf config.hyprland.enable {
    programs.hyprland =
      {
        enable = true;
        withUWSM = false;
      }
      // lib.optionalAttrs (config.hyprland.buildFromFlakes) {
        package = hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
        portalPackage = hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
      };

    xdg.portal = {
      config.hyprland = {
        default = [
          "hyprland"
          "kde"
        ];
      };
    };

    environment.systemPackages =
      [
        pkgs.kdePackages.qtwayland
        pkgs.libsForQt5.qt5.qtwayland
        pkgs.hyprpolkitagent
        # pkgs.kdePackages.qt6ct
      ]
      ++ [
        pkgs.kitty
      ];
  };
}
