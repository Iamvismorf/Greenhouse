{
  self,
  sources,
  utils,
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
  # nC = utils.genAttrs hosts mkHost;
  nC = lib.genAttrs hosts mkHost;
}
