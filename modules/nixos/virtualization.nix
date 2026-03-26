{
  modules.nixos.virtualization = {pkgs, ...}: {
    programs.virt-manager.enable = true;
    virtualisation.libvirtd = {
      enable = true;
      spiceUSBRedirection.enable = true;
      qemu = {
        runAsRoot = true;
        swtpm = true;
        vhostUserPackages = [pkgs.virtiofsd]; # access to host folders
      };
    };
    services.spice-vdagentd.enable = true;
  };
}
