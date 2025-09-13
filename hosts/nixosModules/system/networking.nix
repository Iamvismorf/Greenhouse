{ lib, config, myLib, ... }:
{
  options = {
    networking.enable = myLib.mkTrueOption "enable networking module";
  };
  config = lib.mkIf config.networking.enable {
    # Pick only one of the below networking options.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    networking.networkmanager.enable = true;
    networking.firewall.enable = true;
    # Enable the OpenSSH daemon.
    # services.openssh.enable = true;

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
  };
}
