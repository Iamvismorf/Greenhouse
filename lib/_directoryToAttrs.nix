let
  sources = import ../+npins;
  lib = import "${sources.nixpkgs}/lib";

  inherit
    (lib)
    splitString
    toSentenceCase
    nameValuePair
    mapAttrs'
    ;
  inherit
    (builtins)
    foldl'
    readDir
    ;

  #todo: mid implementation. Should explicitly lowercase the first letter
  toCamelCase = basename:
    splitString "." basename
    |> foldl' (acc: elem:
      if acc == ""
      then elem
      else acc + (toSentenceCase elem)) "";

  fn = root: let
    readDir' = directory: let
      content = readDir directory;
      fn = basename: type: let
        fullpath = directory + "/${basename}";
      in
        if type == "directory"
        then nameValuePair basename ((readDir' fullpath) // {__functor = _self: _args: fullpath;})
        else nameValuePair (toCamelCase basename) fullpath;
    in
      mapAttrs' fn content;
  in
    readDir' root;
in
  fn
