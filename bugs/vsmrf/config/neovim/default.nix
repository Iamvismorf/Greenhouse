{
  pkgs,
  lib,
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
      pkgs.stylua
      pkgs.lua-language-server
      pkgs.alejandra
      pkgs.nixd
      pkgs.clang-tools
      pkgs.neocmakelsp
      pkgs.shfmt
      pkgs.inotify-tools
      pkgs.kdePackages.qtdeclarative
    ];
  enable = true;
  plugins = {
    dev.myConfig = {
      pure = fs.toSource {
        root = ./nvim;
        fileset = fs.fromSource (lib.sources.cleanSource ./nvim);
      };

      impure = "/home/vsmrf/Greenhouse/bugs/vsmrf/config/neovim/nvim";
    };
    start =
      builtins.attrValues {
        inherit
          (pkgs.vimPlugins)
          lze
          lzextras
          nvim-web-devicons
          plenary-nvim
          snacks-nvim # replace scroll with neoscroll
          statuscol-nvim
          ;
      }
      ++ [
        {
          name = "kanso.nvim";
          src = pkgs.fetchFromGitHub {
            owner = "webhooked";
            repo = "kanso.nvim";
            rev = "748023fd273782e6e056620ce66a176532cdf375";
            hash = "sha256-REpAQJQnYTWrGnqeb5S7jgDjmMvSUE4JqT+BcSonxfw=";
          };
        }
      ];
    opt =
      builtins.attrValues {
        inherit
          (pkgs.vimPlugins)
          # nvim-lint
          conform-nvim
          friendly-snippets
          lspkind-nvim
          nvim-ufo
          gitsigns-nvim
          blink-cmp
          promise-async
          barbecue-nvim
          nvim-navic
          bufferline-nvim
          indent-blankline-nvim
          lualine-nvim
          fzf-lua
          nvim-window-picker
          flash-nvim
          nvim-autopairs
          nvim-surround
          yazi-nvim
          mini-ai
          ;
      }
      ++ [
        pkgs.vimPlugins.nvim-treesitter.withAllGrammars
        pkgs.vimPlugins.nvim-treesitter-textobjects
      ];
  };
}
