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
  vsmrf.enable = true;

  networking.hostName = "Amaryllis"; # Define your hostname.
  system.stateVersion = "25.05";
}
