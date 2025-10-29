{
  config,
  lib,
  myLib,
  pkgs,
  ...
}: {
  options = {
    font.enable = myLib.mkTrueOption "enable font module";
  };

  config = lib.mkIf config.font.enable {
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
      pkgs.font-awesome
    ];
  };
}
