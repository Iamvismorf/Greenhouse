## About
My classic nixos configurations. The entry point is `./hosts/default.nix`.

## Usage
- Switching to a new generation:\
`sudo nixos-build switch/boot --no-reexec -A nC.<hostName>` or `nh os switch --file ./default.nix nC.<hostName>`. Alternatively there is an alias for the switching command, which is `switchpls nC.<hostname>`

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
│   │   │   ├── wm/                     # for now there are only wallpapers without wm configs
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

## Special Thanks
The nix codes are based on works of [Rexcrazy](https://github.com/Rexcrazy804) and [viperML](https://github.com/viperML). An honorable mention to [end-4](https://github.com/end-4) and [sora](https://github.com/soramanew), whose qs code I yoinked for my shell.

## Resources
- [caelestia-dots/shell](https://github.com/caelestia-dots/shell)
- [end-4/dots-hyprland](https://github.com/end-4/dots-hyprland)
- [piegames's npins blog](https://piegames.de/dumps/pinning-nixos-with-npins-revisited/)
- [Rexcrazy804/Zaphkiel](https://github.com/Rexcrazy804/Zaphkiel)
- [viperML/dotfiles](https://github.com/viperML/dotfiles)
