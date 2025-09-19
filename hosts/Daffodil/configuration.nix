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
  # required for mounting mobile phones
  services.gvfs.enable = true;

  # environment.variables = {
  #   EDITOR = "nvim";
  #   VISUAL = "nvim";
  # };

  system.stateVersion = "24.11";
}
