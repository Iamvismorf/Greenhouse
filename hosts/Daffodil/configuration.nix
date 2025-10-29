{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./hostSpecific
  ];

  networking.hostName = "Daffodil"; # Define your hostname.
  # imperative dolpin setup run rm -f .cache/kcoca* kbuildsycoca6
  environment.etc."xdg/menus/applications.menu".source = "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";

  steam.enable = false;
  vix.enable = true;
  vsmrf.enable = false;
  environment.systemPackages = [
    pkgs.networkmanagerapplet
    #todo: rebuild and see if these are needed
    # pkgs.kdePackages.kservice
    # pkgs.kdePackages.baloo
    # pkgs.kdePackages.baloo-widgets
    # pkgs.kdePackages.dolphin-plugins
  ];

  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  system.stateVersion = "24.11";
}
