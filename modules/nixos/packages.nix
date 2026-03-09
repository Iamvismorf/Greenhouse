{sources, ...}: {
  modules.nixos.packages = {
    pkgs,
    lib,
    config,
    ...
  }: let
    npins =
      if (config.nixos.packages.npins.buildFromSrc)
      then (pkgs.callPackage (sources.npins + "/npins.nix") {})
      else pkgs.npins;
  in {
    options = {
      nixos.packages.npins.buildFromSrc = lib.mkOption {
        type = lib.types.bool;
        default = false;
      };
    };
    config = {
      programs.direnv = {
        enable = true;
        loadInNixShell = true;
        nix-direnv.enable = true;
        enableFishIntegration = true;
      };

      environment.systemPackages =
        [
          npins
        ]
        ++ builtins.attrValues {
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
            ;
        };
    };
  };
}
