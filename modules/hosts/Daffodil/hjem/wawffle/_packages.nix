{
  pkgs,
  sources,
  ...
}: let
  vixvim = (import sources.mnw).lib.wrap {inherit pkgs sources;} ./_config/neovim;
  yazi = pkgs.callPackage ./_config/yazi {};
in
  builtins.attrValues {
    inherit (pkgs) swww waypaper waybar;
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

    vixvim.devMode
    yazi
  ]
