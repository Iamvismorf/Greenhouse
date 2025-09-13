#TODO:manual configuring zsh/ using zsh module from hjem-rum
{
  fl-compat,
  sources,
  pkgs,
  config,
  options,
  lib,
  ...
}:
let
  username = "vix";
  ghostty = import sources.ghostty;
  vixvim = (import sources.mnw).lib.wrap pkgs {
  };
in
{
  options = {
    vix.enable = lib.mkEnableOption "user vix";
  };
  config = lib.mkIf config.vix.enable {
    users.users.${username} = {
      isNormalUser = true;
      extraGroups = [
        "networkmanager"
        "input"
        "wheel"
      ];
      # shell = pkgs.zsh;
    };
    # programs.zsh.enable = true;
    hjem.users.${username} = {
      clobberFiles = true;
      xdg.config.files = {
        "fastfetch".source = ./config/fastfetch;
	"git".source = ./config/git;
      };
      packages = builtins.attrValues {
        inherit (pkgs)
	  fastfetch
	  viewnior
	  equibop
	  fuzzel
          ;
      }++
      [
	(pkgs.callPackage (ghostty + "/nix/package.nix") {
	  optimize = "ReleaseFast";
	  revision = sources.ghostty.revision;
	})
	vixvim
      ];
    };
  };
}
