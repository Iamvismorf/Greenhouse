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
  vix.enable = false;

  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  networking.hostName = "Amaryllis";
  system.stateVersion = "25.05";
}
