{
  myLib,
  ...
}:
{
    imports = myLib.importDir {
      dir = ./.;
    };
}
