{inputs, ...}: {
  modules.nixos.nixosPackages = {
    pkgs,
    lib,
    config,
    ...
  }: {
    programs.direnv = {
      enable = true;
      loadInNixShell = true;
      nix-direnv.enable = true;
      enableFishIntegration = true;
    };

    environment.systemPackages = builtins.attrValues {
      inherit
        (pkgs)
        git
        just
        yazi
        neovim
        nh
        wl-clipboard
        cliphist
        libnotify
        firefox
        cachix
        ;
    };
  };
}
