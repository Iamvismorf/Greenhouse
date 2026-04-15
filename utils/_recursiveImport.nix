# files/directories starting with _ and empty files will be ignored. Idea stolen from github.com/vic/import-tree
# supports multiple directory
#
# [] []?: -> []
let
  sources = import ../+npins;
  lib = import "${sources.nixpkgs}/lib";
  inherit
    (builtins)
    filter
    any
    readFile
    readDir
    stringLength
    pathExists
    concatLists
    concatMap
    ;
  inherit
    (lib)
    mapAttrsToList
    hasSuffix
    hasPrefix
    filterAttrs
    ;

  recursiveImport = {
    dirs,
    excludePrefixedWith ? ["_"],
  }: let
    importDir = dir: let
      filteredAttrs =
        readDir dir
        |> (filterAttrs (n: v: !(any (prefix: hasPrefix prefix n) excludePrefixedWith) && (v == "directory" || hasSuffix ".nix" n)));
      pred = i: type:
        if type == "directory"
        then importDir (dir + "/${i}")
        else if type == "regular"
        then [(dir + "/${i}")]
        else [];
    in
      concatLists (mapAttrsToList pred filteredAttrs)
      |> (filter (e: (pathExists e) && (stringLength (readFile e)) > 0));
  in
    concatMap importDir dirs;
in
  recursiveImport
