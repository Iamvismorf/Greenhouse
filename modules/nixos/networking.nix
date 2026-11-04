{
  modules.nixos.networking = {pkgs, ...}: {
    networking.networkmanager = {
      enable = true;
    };

    networking.firewall.enable = true;

    systemd.network.wait-online.enable = false;

    services.openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        PermitRootLogin = "no";
      };
    };

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
  };
}
