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
        substituters = [
          "https://amaryllis.cachix.org"
        ];
        trusted-public-keys = [
          "amaryllis.cachix.org-1:vNkKbFIgjK1V74ll1v59Sg4n+mppn8hjcaIEICkq3ko="
        ];
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
