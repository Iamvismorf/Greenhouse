# Bootloader.
{config, lib, myLib, ... }:
{
  options = {
    bootloader.enable = myLib.mkTrueOption "enable bootloader module";

  };

  config = lib.mkIf config.bootloader.enable{
    boot.loader = {
      timeout = null;
      # efi.efiSysMountPoint = "/boot/efi";
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
        # configurationLimit = 3; # depends on machine mb

      };
    };
  };
}
