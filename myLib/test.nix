let
  sources = import ../npins;
  lib = import "${sources.nixpkgs}/lib";
  inherit
    (builtins)
    filter
    baseNameOf
    elem
    readFile
    readDir
    stringLength
    pathExists
    ;
  inherit
    (lib)
    pipe
    mapAttrsToList
    hasSuffix
    mapAttrs'
    nameValuePair
    filterAttrs
    ;
in {
  importDir = {
    dir,
    eF ? [],
    subdir ? false,
  }:
  # mapAttrsToList (n: _: (dir + "/${n}"))
  # (
  #   filterAttrs (n: v: v == "regular" && !(elem n eF) && hasSuffix ".nix" n) (readDir dir)
  # );
    pipe dir [
      readDir
      (mapAttrs' (
        n: v:
          if (v == "directory" && subdir)
          then nameValuePair (n + "/default.nix") "regular"
          else nameValuePair n v
      ))
      (filterAttrs (n: v: v == "regular" && !(elem n (eF ++ ["default.nix"])) && hasSuffix ".nix" n))
      (mapAttrsToList (n: _: (dir + "/${n}")))
      (filter (i: (pathExists i) && (stringLength (readFile i) > 0)))
    ];
}
