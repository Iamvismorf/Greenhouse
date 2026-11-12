### Try without installing
```
nix run github:Iamvismorf/nvim-flakey
```
### Installation
```nix
#flake.nix
{
  inputs.nvim-flakey = {
    url = "github:Iamvismorf/nvim-flakey";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  #...
}
```
```nix
#packages.nix
{pkgs, inputs, ...}: {
  #...
  environment.systemPackages = [
    inputs.nvim-flakey.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
```
Optionally override `neovim` attribute to use nightly:
```nix
inputs.nvim-flakey.packages.${pkgs.stdenv.hostPlatform.system}.default.override {
    neovim = inputs.neovim-nightly.packages.${pkgs.stdenv.hostPlatform.system}.default;
}
```
