{self, ...}: let
  hostname = "Daffodil";
in {
  modules.hosts.${hostname} = {
    imports = [
      self.modules.nixos.trash
      self.modules.nixos.audio
      self.modules.nixos.bluetooth
      self.modules.nixos.bootloader
      self.modules.nixos.env
      self.modules.nixos.fonts
      self.modules.nixos.locale
      self.modules.nixos.networking
      self.modules.nixos.nix
      self.modules.nixos.packages
      self.modules.nixos.misc

      self.modules.wm._
      self.modules.wm.hyprland
      self.modules.wm.niri

      self.modules.hjem._
      self.modules.hjem.wawffle

      ./+hardware.nix
    ];

    networking.hostName = hostname;
    system.stateVersion = "24.11";
  };
}
