{
  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.xz";
    mnw.url = "github:gerg-l/mnw";
  };
  outputs = {
    self,
    nixpkgs,
    mnw,
    ...
  }: let
    systems = ["x86_64-linux"];
    eachSystem = fn: nixpkgs.lib.genAttrs systems fn;
  in {
    packages = eachSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      default = self.packages.${system}.nvim;

      nvim = mnw.lib.wrap {inherit pkgs;} ./default.nix;
    });
  };
}
