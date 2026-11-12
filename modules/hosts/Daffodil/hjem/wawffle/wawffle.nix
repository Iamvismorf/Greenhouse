{
  inputs,
  utils,
  ...
}: let
  username = "vix";
in {
  modules.hjem.${username} = {
    pkgs,
    config,
    ...
  }: {
    theming = {
      inherit username;
      enable = true;
      qt = {
        colorScheme = config.hjem.metadata.vsmrf.theme.BreezeDarkColors;
        iconTheme = "Papirus-Dark";
      };
    };
    users.users.${username} = {
      isNormalUser = true;
      extraGroups = [
        "networkmanager"
        "input"
        "wheel"
        "nixos"
      ];
      shell = pkgs.fish;

      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFdestaaKngezOmIGRUVpc6KcaZ2A4CKD/paK2vfB47d vsmrf@Amaryllis"
      ];
    };
    programs.fish.enable = true;

    hjem.users.${username} = {
      clobberFiles = true;

      xdg.config.files = with config.hjem.metadata.vsmrf; {
        "fuzzel/fuzzel.ini".source = config.hjem.metadata.vsmrf.fuzzel.fuzzelIni;
        "ghostty".source = utils.mkStoreSymlink (config.hjem.metadata.vsmrf.ghostty null);
        "fastfetch".source = fastfetch null;
        "git".source = git null;
        "fish/config.fish".source = utils.mkStoreSymlink fish.configFish;
        "fish/functions".source = utils.mkStoreSymlink (fish.functions null);
        "swappy/config".source = swappy.config;
        "bottom".source = bottom null;
      };
      packages = import ./_packages.nix {inherit config inputs pkgs;}; #todo: solve this params passing
    };
  };
}
