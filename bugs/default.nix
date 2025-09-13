{ myLib, ... }:
{
 imports = myLib.importDir {
   dir = ./.;
   subdir = true;
 };
}
