{
  modules.nixos.env = {pkgs, ...}: {
    environment.variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      SUDO_EDITOR = "nvim";
    };

    environment.etc = {
      "nixos/nixpkgs".source = builtins.storePath pkgs.path;
      "/xdg/menus/applications.menu".text = builtins.readFile "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu"; #dolphin fix
    };
  };
}
