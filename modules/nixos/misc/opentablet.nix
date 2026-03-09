{
  modules.nixos.misc_opentablet = {
    hardware.opentabletdriver = {
      enable = true;
      daemon.enable = true;
    };
  };
}
