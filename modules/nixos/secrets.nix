{inputs, ...}: {
  modules.nixos.secrets = {
    imports = [
      inputs.sops-nix.nixosModules.sops
    ];
  };
}
