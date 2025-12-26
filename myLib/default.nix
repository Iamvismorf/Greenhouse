let
  sources = import ../npins;
  lixFlake-compat = import sources.flake-compat;
  lib = import "${sources.nixpkgs}/lib";
  inherit
    (builtins)
    filter
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
  inherit (lib.filesystem) listFilesRecursive;
in {
  # wrapper to lib.genAttrs so I don't need to import lib in the root default.nix
  genAttrs = list: fn: lib.genAttrs list fn;

  mkTrueOption = desc:
    lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = desc;
    };

  # filepaths in eF should be relative to dir
  # imports all files in directory recursively and ignore empty files
  importDirRecursive = {
    dir,
    eF ? [(dir + "/default.nix")],
  }:
    pipe dir [
      listFilesRecursive
      (filter (i: (hasSuffix ".nix" i) && !(elem i eF)))
      (filter (i: (stringLength (readFile i)) > 0))
    ];

  # eF list includes file names neither absolute nor relative path
  # imports every .nix file in the directory without importing subdirectories unless subdir=true is passed. Level is 1. If subdir is true and there is no subdir then it will be ignored
  # to ignore a directory: "dir/default.nix"
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
      (filter (i: (pathExists i) && (stringLength (readFile i)) > 0))
    ];
  flakeToNix = {
    src,
    copySourceTreeToStore ? true,
    useBuiltinsFetchTree ? false,
    system ? builtins.currentSystem or "unknown-system",
  }: (lixFlake-compat {
    inherit src copySourceTreeToStore useBuiltinsFetchTree system;
  });
}
