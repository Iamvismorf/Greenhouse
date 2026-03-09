{
  modules.hosts.Daffodil = {pkgs, ...}: {
    environment.systemPackages = [
      pkgs.brightnessctl
      pkgs.networkmanagerapplet
    ];
  };
}
