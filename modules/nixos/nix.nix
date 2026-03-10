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

        extra-substituters = ["https://amaryllis.cachix.org"];
        extra-trusted-public-keys = ["amaryllis.cachix.org-1:1bo3DgfwQc7xEL13v65yxt/4/zVcPRj0U5VLM0JHJts="];
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
