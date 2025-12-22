{
  pkgs,
  config,
  lib,
  myLib,
  ...
}: {
  options = {
    settings.enable = myLib.mkTrueOption "enable nix settings module";
  };

  config = lib.mkIf config.settings.enable {
    nix.settings.experimental-features = ["nix-command" "flakes"];
  };
}
