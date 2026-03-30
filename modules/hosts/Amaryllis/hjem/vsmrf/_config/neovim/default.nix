{
  pkgs,
  lib,
  sources,
  ...
}: let
  fs = lib.fileset;
in {
  aliases = ["vim" "vi"];
  initLua = ''
    require("vismorf")
  '';
  extraBinPath =
    [
      pkgs.fzf
      pkgs.ripgrep
      pkgs.fd
    ]
    ++ [
      pkgs.alejandra
      pkgs.nixd
      pkgs.stylua
      pkgs.lua-language-server
      pkgs.shfmt
      pkgs.inotify-tools
      pkgs.kdePackages.qtdeclarative
      pkgs.llvmPackages.clang-tools
      pkgs.neocmakelsp
    ];
  enable = true;
  plugins = {
    dev.myConfig = {
      pure = fs.toSource {
        root = ./nvim;
        fileset = fs.fromSource (lib.sources.cleanSource ./nvim);
      };

      impure = "/home/vsmrf/Greenhouse/modules/hosts/Amaryllis/hjem/vsmrf/_config/neovim/nvim";
    };
    #todo: no idea what this is
    startAttrs = {
      nvim-treesitter = null;
      promise-async = null;
    };
    start =
      builtins.attrValues {
        inherit (pkgs.vimPlugins) lze lzextras;
        inherit
          (pkgs.vimPlugins)
          nvim-web-devicons
          plenary-nvim
          snacks-nvim # replace scroll with neoscroll
          statuscol-nvim
          ;
      }
      ++ [
        {
          name = "zen.nvim";
          src = pkgs.fetchFromGitHub {
            owner = "nendix";
            repo = "zen.nvim";
            rev = sources.zenNvim.revision;
            hash = "sha256-FSDIPyH6Fra9EO8fvr5uwwRaWEHJFjKMgfMZkl3BUeQ=";
          };
        }
      ];
    opt =
      builtins.attrValues {
        inherit (pkgs.vimPlugins) conform-nvim;
        inherit (pkgs.vimPlugins) blink-cmp friendly-snippets lspkind-nvim;
        inherit (pkgs.vimPlugins) nvim-ufo promise-async;

        inherit
          (pkgs.vimPlugins)
          gitsigns-nvim
          bufferline-nvim
          indent-blankline-nvim
          fzf-lua
          flash-nvim
          nvim-autopairs
          nvim-surround
          yazi-nvim
          bufjump-nvim
          ;
      }
      ++ [
        pkgs.vimPlugins.nvim-treesitter.withAllGrammars
        pkgs.vimPlugins.nvim-treesitter-textobjects
      ];
  };
}
