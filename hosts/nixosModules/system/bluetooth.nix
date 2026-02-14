{
  config,
  lib,
  myLib,
  ...
}: {
  options = {
    bluetooth.enable = myLib.mkTrueOption "enable bluetooth module";
  };
  config = lib.mkIf config.bluetooth.enable {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Experimental = true;
          FastConnectable = false;
          KernelExperimental = true;
        };
        Policy = {
          AutoEnable = false;
        };
      };
    };
  };
}
