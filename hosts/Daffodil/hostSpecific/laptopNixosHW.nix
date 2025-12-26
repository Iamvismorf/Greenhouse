{
  sources,
  lib,
  ...
}: {
  imports = [
    # nix-hw.nixosModules.lenovo-thinkpad-x260
    (sources.nixos-hardware + "/lenovo/thinkpad/x260")
  ];
}
