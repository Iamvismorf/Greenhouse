{
  modules.nixos.udisks = {
    services.udisks2 = {
      enable = true;
      mountOnMedia = true;
    };
  };
}
