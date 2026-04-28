{
  self,
  inputs,
  lib,
  ...
}: let
  nixosSystem = import "${inputs.nixpkgs}/nixos/lib/eval-config.nix";

  mkHost = hostname:
    nixosSystem {
      modules = [self.modules.hosts.${hostname}];
    };

  hosts = builtins.attrNames self.modules.hosts;
in {
  nC = lib.genAttrs hosts mkHost;
}
