{
  modules.nixos.virtualisation = {pkgs, ...}: {
    programs.virt-manager.enable = true;
    virtualisation.spiceUSBRedirection.enable = true;
    virtualisation.libvirtd = {
      enable = true;
      qemu = {
        runAsRoot = true;
        swtpm.enable = true;
        vhostUserPackages = [pkgs.virtiofsd]; # access to host folders
      };
    };
    services.spice-vdagentd.enable = true;
  };
}
