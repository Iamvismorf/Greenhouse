{
  config,
  lib,
  myLib,
  pkgs,
  ...
}:

# gamemoderun %command%
# mangohud %command%
# gamescope %command%
# prepend in general launch options
{

  options = {
    steam.enable = myLib.mkTrueOption "enable steam";
  };
  config = lib.mkIf config.steam.enable {

    environment.systemPackages = [
      pkgs.mangohud # monitor
      pkgs.protonup
    ];

    programs.gamemode.enable = true;
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
      gamescopeSession.enable = true;
    };
  };
}
