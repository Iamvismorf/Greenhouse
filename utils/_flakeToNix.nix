let
  sources = import ../+npins;
  lixFlake-compat = import sources.flake-compat;
in
  {
    src,
    copySourceTreeToStore ? true,
    useBuiltinsFetchTree ? false,
    system ? builtins.currentSystem or "unknown-system",
  }: (lixFlake-compat {
    inherit src copySourceTreeToStore useBuiltinsFetchTree system;
  })
