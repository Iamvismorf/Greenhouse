{
  pkgs,
  inputs,
}: let
  mnw = inputs.mnw.lib.wrap {inherit pkgs inputs;} ./_config/neovim;
  yazi = pkgs.callPackage ./_config/yazi {};
in
  builtins.attrValues {
    inherit (pkgs) awww waypaper waybar;
    inherit (pkgs) ghostty viewnior mpv firefox fuzzel git;
    inherit (pkgs) bottom fastfetch eza bat tree;
    inherit (pkgs) jq fd fzf ripgrep ouch wtype socat resvg hyprshot;

    inherit (pkgs.kdePackages) dolphin ark qtsvg breeze;
  }
  ++ [
    (pkgs.vesktop.overrideAttrs (oldAttrs: {
      desktopItems =
        map (
          item:
            item.override {icon = "discord";}
        )
        oldAttrs.desktopItems;
    }))

    mnw.devMode
    yazi
  ]
