# based on outfoxxed/impurity.nix
# Non flake configs are impure
# apparently this is home manager's mkOutOfStoreSymlink implementation. I did not know that at the time of writing this
#
# _path -> path in nix store that is a symlink to _path
let
  sources = import ../+npins;
  pkgs = import sources.nixpkgs {};
in
  path: let
    absolutePath = toString path;
    # isImpure = builtins ? currentSystem; # should work with flake configs. No need to check for envVar
    isImpure = builtins.getEnv "IMPURE";
  in
    if isImpure == "true"
    then
      pkgs.runCommand "mkImpure-${absolutePath}" {}
      ''
        ln -s ${absolutePath} $out
      ''
    else path
