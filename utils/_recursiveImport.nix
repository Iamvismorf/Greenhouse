# files/directories starting with _ and empty files will be ignored. Idea stolen from github.com/vic/import-tree
# fn: -> []
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
    ;
  inherit
    (lib)
    mapAttrsToList
    hasSuffix
    hasPrefix
    filterAttrs
    ;

  recursiveImport = {
    dir,
    excludePrefixedWith ? ["_"],
  }: let
    filteredAttrs =
      readDir dir
      |> (filterAttrs (n: v: !(any (prefix: hasPrefix prefix n) excludePrefixedWith) && (v == "directory" || hasSuffix ".nix" n)));

    pred = n: type:
      if type == "directory"
      then
        recursiveImport {
          dir = dir + "/${n}";
          inherit excludePrefixedWith;
        }
      else if type == "regular"
      then [(dir + "/${n}")]
      else [];
  in
    concatLists (mapAttrsToList pred filteredAttrs)
    |> (filter (e: (pathExists e) && (stringLength (readFile e)) > 0));
in
  recursiveImport
