## About
My non-flakes, npins based NixOS/Hyprland configurations. The entry point is `./hosts/default.nix`. Users `vix` and `vsmrf` are the same person(me :) ) using different usernames across devices(laptop and main pc respectively). Each user has their own dedicated diretory where they can manage their userspace. As a result, there are no shared modules. That's why `vix`'s and `vsmrf`'s directories have identical structure and contents.
## Usage
- Switching to a new generation:\
Launch nix shell with `nix-shell` and run `sudo nixos-build switch/boot --no-reexec -A nC.<hostName>`. Alternatively there is an alias for the switching command, which is `switchpls nC.<hostname>`
> [!NOTE]
As of 20/09/2025, to `switch/boot` you launch nix shell. However, in a future release of `npins`, you will be able to just run the switch command, mentioned above, without landing in the nix shell. See [Resources](#resources) for more information. 
## Directory Structure
```bash
.
├── bugs
│   ├── default.nix
│   ├── vix
│   │   ├── config
│   │   │   ├── fastfetch/
│   │   │   ├── fish/
│   │   │   ├── fuzzel/
│   │   │   ├── ghostty/
│   │   │   ├── git/
│   │   │   ├── gtk/
│   │   │   ├── neovim/
│   │   │   ├── wm/
│   │   │   └── yazi/
│   │   ├── default.nix
│   │   └── packages.nix
│   └── vsmrf/
├── default.nix
├── hosts
│   ├── Amaryllis                       # main pc
│   │   └── hostSpecific/
│   ├── Daffodil                        # laptop
│   │   ├── configuration.nix
│   │   ├── hardware-configuration.nix
│   │   └── hostSpecific/
│   ├── default.nix
│   └── nixosModules                    # shared modules
│       ├── default.nix
│       └── system
│           └── default.nix
├── myLib/
├── npins/
└── shell.nix
```

## Appreciation
This repo is based on work by Rexcrazy and viperML. Special thanks go to Rex, who helped me with the migrating to the npins-based configuration. Additional thanks to end4 and sora, whose qs code I yoinked for my shell.

## Resources
- [caelestia-dots/shell](https://github.com/caelestia-dots/shell)
- [end-4/dots-hyprland](https://github.com/end-4/dots-hyprland)
- [piegames's npins blog](https://piegames.de/dumps/pinning-nixos-with-npins-revisited/)
- [Rexcrazy804/Zaphkiel](https://github.com/Rexcrazy804/Zaphkiel)
- [viperML/dotfiles](https://github.com/viperML/dotfiles)
