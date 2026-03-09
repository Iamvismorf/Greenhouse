{}: {
  imports = [
    ./hardware-configuration.nix
    ./hostSpecific
  ];
  vsmrf.enable = true;

  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  networking.hostName = "Amaryllis";
  system.stateVersion = "25.05";
}
