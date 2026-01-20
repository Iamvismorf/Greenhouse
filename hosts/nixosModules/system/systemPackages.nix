{
  pkgs,
  sources,
  ...
}: let
  mango = import "${sources.mangowc}/nix/default.nix";
in {
  environment.systemPackages =
    [
      (pkgs.callPackage mango {})
      (pkgs.callPackage (sources.npins + "/npins.nix") {})
    ]
    ++ builtins.attrValues {
      inherit
        (pkgs)
        tree
        git
        yazi
        neovim
        firefox
        kitty
        nh
        wl-clipboard
        cliphist
        brightnessctl
        libnotify
        grim
        slurp
        swappy
        imagemagick
        # direnv
        ;
    };
}
