{
  modules.nixos.nix = {
    documentation.enable = false;

    nixpkgs.config.allowUnfree = true;

    nix = {
      channel.enable = false;
      nixPath = ["nixpkgs=/etc/nixos/nixpkgs"];

      settings = {
        experimental-features = ["nix-command" "flakes" "pipe-operators"];
        auto-optimise-store = true;
        allowed-users = ["@wheel"];
      };

      optimise = {
        automatic = true;
        persistent = true;
        dates = "weekly";
      };

      gc = {
        automatic = true;
        persistent = true;
        dates = "weekly";
        options = "--delete-older-than 30d";
      };
    };
  };
}
