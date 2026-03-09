{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./hostSpecific
  ];

  networking.hostName = "Daffodil"; # Define your hostname.

  steam.enable = false;
  vix.enable = true;
  niri.enable = false;

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
