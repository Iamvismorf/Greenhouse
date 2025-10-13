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

  steam.enable = false;
  vix.enable = true;
  vsmrf.enable = false;
  environment.systemPackages = [
    pkgs.networkmanagerapplet
  ];

  # environment.variables = {
  #   EDITOR = "nvim";
  #   VISUAL = "nvim";
  # };

  system.stateVersion = "24.11";
}
