{
  pkgs,
  sources,
  ...
}: let
  home = import sources.hjem {};
in {
  hjem = {
    linker = home.packages.smfh;
  };
}
