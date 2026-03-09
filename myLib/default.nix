let
  sources = import ../npins;
  lixFlake-compat = import sources.flake-compat;
  lib = import "${sources.nixpkgs}/lib";
  inherit
    (builtins)
    filter
    # any
    elem
    readFile
    readDir
    stringLength
    pathExists
    concatLists
    ;
  inherit
    (lib)
    pipe
    mapAttrsToList
    hasSuffix
    hasPrefix
    mapAttrs'
    nameValuePair
    filterAttrs
    ;
in rec {
  # wrapper around lib.genAttrs so I don't need to import lib in the root default.nix
  genAttrs = list: fn: lib.genAttrs list fn;

  mkEnabledByDefault = desc:
    lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = desc;
    };

  # files/directories starting with _ and empty files will be ignored. Idea stolen from vic/import-tree
  # importRecursive = {
  #   dir,
  #   excludePrefixedWith ? ["_"],
  # }: let
  #   filteredAttrs =
  #     readDir dir
  #     |> (filterAttrs (n: v: !(any (prefix: hasPrefix prefix n) excludePrefixedWith) && (v == "directory" || hasSuffix ".nix" n)));
  #
  #   pred = n: type:
  #     if type == "directory"
  #     then
  #       importRecursive {
  #         dir = dir + "/${n}";
  #         inherit excludePrefixedWith;
  #       }
  #     else if type == "regular"
  #     then [(dir + "/${n}")]
  #     else [];
  # in
  #   concatLists (mapAttrsToList pred filteredAttrs)
  #   |> (filter (e: (pathExists e) && (stringLength (readFile e)) > 0));
  importRecursive = dir
  : let
    filteredAttrs =
      readDir dir
      |> (filterAttrs (n: v: !(hasPrefix "_" n) && (v == "directory" || hasSuffix ".nix" n)));

    pred = n: type:
      if type == "directory"
      then importRecursive (dir + "/${n}")
      else if type == "regular"
      then [(dir + "/${n}")]
      else [];
  in
    concatLists (mapAttrsToList pred filteredAttrs)
    |> (filter (e: (pathExists e) && (stringLength (readFile e)) > 0));

  # @Deprecated
  # eF list includes file names neither absolute nor relative path
  # imports every .nix file in the directory without importing subdirectories unless subdir=true is passed. Level is 1. If subdir is true and there is no subdir then it will be ignored
  # to ignore a directory: "dir/default.nix"
  importDir = {
    dir,
    eF ? [],
    subdir ? false,
  }:
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
