{
  config,
  lib,
  myLib,
  ...
}: {
  options = {
    misc.enable = myLib.mkTrueOption "enable misc module";
  };
  config = lib.mkIf config.misc.enable {
    # for mounting phone
    services.gvfs.enable = true;
    qt.enable = true;
  };
}
