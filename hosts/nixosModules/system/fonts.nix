{
  config,
  lib,
  myLib,
  pkgs,
  ...
}: {
  options = {
    fonts.enable = myLib.mkTrueOption "enable fonts module";
  };

  config = lib.mkIf config.fonts.enable {
    fonts = {
      fontconfig = {
        enable = true;
        defaultFonts = {
          serif = ["Atkinson Hyperlegible Next"];
          sansSerif = ["Atkinson Hyperlegible Next"];
          monospace = ["Atkinson Hyperlegible Next"];
        };
      };
    };

    fonts.packages = [
      pkgs.nerd-fonts.commit-mono
      pkgs.nerd-fonts.symbols-only
      pkgs.atkinson-hyperlegible-next
      pkgs.material-symbols
      pkgs.font-awesome
    ];
  };
}
