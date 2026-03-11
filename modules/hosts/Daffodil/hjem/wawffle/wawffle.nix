{
  self,
  sources,
  ...
}: let
  username = "vix";
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
      ];
      shell = pkgs.fish;

      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFdestaaKngezOmIGRUVpc6KcaZ2A4CKD/paK2vfB47d vsmrf@Amaryllis"
      ];
    };
    programs.fish.enable = true;

    hjem.users.${username} = {
      clobberFiles = true;

      xdg.config.files = {
        "fuzzel/fuzzel.ini".source = ./_config/fuzzel/fuzzel.ini;
        "ghostty".source = ./_config/ghostty;
        "fastfetch".source = ./_config/fastfetch;
        "git".source = ./_config/git;
        "fish/config.fish".source = ./_config/fish/config.fish;
        "fish/functions".source = ./_config/fish/functions;
        "swappy/config".source = ./_config/swappy/config;
        "bottom".source = ./_config/bottom;
      };
      packages = import ./_packages.nix {inherit sources pkgs;};
    };
  };
}
