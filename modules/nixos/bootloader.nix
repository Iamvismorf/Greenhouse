{
  modules.nixos.bootloader = {
    boot.loader = {
      timeout = null;
      # efi.efiSysMountPoint = "/boot/efi";
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
        # configurationLimit = 3;
      };
    };
  };
}
