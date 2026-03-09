## About
My classic nixos configuration. The entry point is `./hosts/default.nix`.

## Usage
- Switching to a new generation:\
`sudo nixos-build switch/boot --no-reexec -A nC.<hostName>` or `nh os switch --file ./default.nix nC.<hostName>`. Alternatively there is an alias for the switching command, which is `switchpls nC.<hostname>`

## Directory Structure
```bash
.
├── bugs
│   ├── default.nix
│   ├── hjem.nix
│   ├── theme.nix
│   ├── vix/
│   └── vsmrf
│       ├── config
│       │   ├── BreezeDark.colors/
│       │   ├── fastfetch/
│       │   ├── firefox/
│       │   ├── fish/
│       │   ├── fuzzel/
│       │   ├── ghostty/
│       │   ├── git/
│       │   ├── gtk/
│       │   ├── mpv/
│       │   ├── neovim/
│       │   ├── nixpkgs/
│       │   ├── swappy/
│       │   ├── theme.txt/
│       │   ├── wm/
│       │   └── yazi/
│       ├── default.nix
│       └── packages.nix
├── default.nix
├── hosts
│   ├── Amaryllis/
│   ├── Daffodil/
│   ├── default.nix
│   └── nixosModules
├── myLib/
├── npins/
└── readme.md 
```

## Special Thanks
The nix codes are based on works of [Rexcrazy](https://github.com/Rexcrazy804) and [viperML](https://github.com/viperML). An honorable mention to [end-4](https://github.com/end-4) and [sora](https://github.com/soramanew), whose qs code I yoinked for my shell.

## Resources
- [caelestia-dots/shell](https://github.com/caelestia-dots/shell)
- [end-4/dots-hyprland](https://github.com/end-4/dots-hyprland)
- [piegames's npins blog](https://piegames.de/dumps/pinning-nixos-with-npins-revisited/)
- [Rexcrazy804/Zaphkiel](https://github.com/Rexcrazy804/Zaphkiel)
- [viperML/dotfiles](https://github.com/viperML/dotfiles)
