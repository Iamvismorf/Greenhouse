#todo: put metadata into constant pattern module. This module imports the constant module
{
  self,
  inputs,
  utils,
  sources,
  ...
}: let
  username = "vsmrf";
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
        "video"
        "render"
        "libvrtd"
        "nixos"
      ];
      shell = pkgs.fish;

      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICVWvTh6JAnprGTPdNA4CLOI5xRc3VPVVobelYuTWj/j vix@Daffodil"
      ];
    };
    programs.fish.enable = true;
    programs.gpu-screen-recorder.enable = true;

    hjem.users.${username} = {
      clobberFiles = true;
      packages = import ./_packages.nix {inherit inputs pkgs sources config;};
      xdg.config.files = with config.hjem.metadata.vsmrf; {
        "fuzzel/fuzzel.ini".source = fuzzel.fuzzelIni;
        "nixpkgs".source = nixpkgs null;
        "mpv/mpv.conf".source = mpv.mpvConf;
        "ghostty".source = utils.mkStoreSymlink (ghostty null);
        "fastfetch".source = fastfetch null;
        "git".source = git null;
        "fish/config.fish".source = utils.mkStoreSymlink fish.configFish;
        "fish/functions".source = utils.mkStoreSymlink (fish.functions null);
        "swappy/config".source = swappy.config;
        "bottom".source = utils.mkStoreSymlink (bottom null);
      };
    };
  };
}
