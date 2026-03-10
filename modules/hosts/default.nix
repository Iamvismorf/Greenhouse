{
  self,
  sources,
  lib,
  ...
}: let
  nixosSystem = import "${sources.nixpkgs}/nixos/lib/eval-config.nix";

  mkHost = hostname:
    nixosSystem {
      modules = [self.modules.hosts.${hostname}];
    };

  hosts = builtins.attrNames self.modules.hosts;
in {
  nC = lib.genAttrs hosts mkHost;
}
