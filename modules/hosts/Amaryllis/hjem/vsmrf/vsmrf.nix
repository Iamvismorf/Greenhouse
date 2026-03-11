{
  self,
  sources,
  utils,
  ...
}: let
  username = "vsmrf";
in {
  modules.hjem.${username} = {pkgs, ...}: {
    imports = [
      self.modules.hjem.theming
    ];
    theming = {
      inherit username;
      enable = true;
      qt.colorScheme = ./_config/theme/BreezeDark.colors;
    };
    users.users.${username} = {
      isNormalUser = true;
      extraGroups = [
        "networkmanager"
        "input"
        "wheel"
        "video"
        "render"
      ];
      shell = pkgs.fish;

      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICVWvTh6JAnprGTPdNA4CLOI5xRc3VPVVobelYuTWj/j vix@Daffodil"
      ];
    };
    programs.fish.enable = true;

    hjem.users.${username} = {
      clobberFiles = true;
      packages = import ./_packages.nix {inherit sources pkgs utils;};
      xdg.config.files = {
        "fuzzel/fuzzel.ini".source = ./_config/fuzzel/fuzzel.ini;
        "nixpkgs".source = ./_config/nixpkgs;
        "mpv/mpv.conf".source = ./_config/mpv/mpv.conf;
        "ghostty".source = ./_config/ghostty;
        "fastfetch".source = ./_config/fastfetch;
        "git".source = ./_config/git;
        "fish/config.fish".source = ./_config/fish/config.fish;
        "fish/functions".source = ./_config/fish/functions;
        "swappy/config".source = ./_config/swappy/config;
        "bottom".source = ./_config/bottom;
      };
    };
  };
}
