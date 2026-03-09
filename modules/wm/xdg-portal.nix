{
  modules.wm._ = {pkgs, ...}: {
    xdg.portal = {
      enable = true;
      configPackages = [
        pkgs.kdePackages.xdg-desktop-portal-kde
        # pkgs.xdg-desktop-portal-gtk
      ];
      extraPortals = [
        pkgs.kdePackages.xdg-desktop-portal-kde
        pkgs.xdg-desktop-portal-gtk
        #no need for hyprland because is enabled by programs.hyprland
      ];
    };
  };
}
