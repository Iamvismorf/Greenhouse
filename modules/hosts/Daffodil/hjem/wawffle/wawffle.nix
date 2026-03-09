{sources, ...}: let
  username = "wawffle";
in {
  modules.hjem.${username} = {pkgs, ...}: {
    users.users.${username} = {
      isNormalUser = true;
      extraGroups = [
        "networkmanager"
        "input"
        "wheel"
      ];
      shell = pkgs.fish;
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
      };
      packages = import ./_packages.nix {inherit sources pkgs;};
    };
  };
}
