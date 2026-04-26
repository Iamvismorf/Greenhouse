{
  self,
  inputs,
  ...
}: {
  modules.wm.hyprland = {
    pkgs,
    lib,
    config,
    ...
  }: {
    imports = [self.modules.wm._];

    options = {
      wm.hyprland.enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
      };
      wm.hyprland.buildFromSrc = lib.mkOption {
        type = lib.types.bool;
        default = false;
      };
    };

    config = lib.mkIf (config.wm.hyprland.enable) {
      programs.hyprland =
        {
          enable = true;
          withUWSM = false;
        }
        // lib.optionalAttrs (config.wm.hyprland.buildFromSrc) {
          package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
          portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
        };

      xdg.portal = {
        config.hyprland = {
          default = [
            "hyprland"
            "kde"
          ];
        };
      };

      #polkit
      environment.systemPackages = [
        pkgs.kdePackages.qtwayland
        pkgs.libsForQt5.qt5.qtwayland
        pkgs.hyprpolkitagent
        pkgs.hyprshutdown

        pkgs.kitty
      ];
    };
  };
}
