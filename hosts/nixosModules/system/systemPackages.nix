{
  pkgs,
  sources,
  myLib,
  ...
}: let
  mango = import "${sources.mangowc}/nix/default.nix";
in {
  environment.systemPackages =
    [
      (pkgs.callPackage mango {})
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
        npins
        grim
        slurp
        swappy
        imagemagick
        # direnv
        ;
    };
}
