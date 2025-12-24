{
  config,
  lib,
  myLib,
  ...
}: {
  options = {
    garbAge.enable = myLib.mkTrueOption "enable garbage module";
  };
  config = lib.mkIf config.garbAge.enable {
    nix.optimise.automatic = true;
    nix.settings.auto-optimise-store = true;
    nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };
}
