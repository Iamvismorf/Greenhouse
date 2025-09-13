# pipewire
{
  config,
  lib,
  myLib,
  ...
}:
{
  options = {
    audio.enable = myLib.mkTrueOption "enable audio module";
  };
  config = lib.mkIf config.audio.enable {
    services.playerctld.enable = true;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      wireplumber.enable = true;
      pulse.enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
    };
  };
}
