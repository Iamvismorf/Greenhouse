{
  sources,
  lib,
  fl-compat,
  ...
}:
# let
#   nix-hw = (fl-compat {
#     src = sources.nixos-hardware;
#     }).defaultNix;
# in
{

  imports = [
    # nix-hw.nixosModules.lenovo-thinkpad-x260
    (sources.nixos-hardware + "/lenovo/thinkpad/x260")
  ];

}
