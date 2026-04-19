{
  pkgs,
  lib,
  sources,
  utils,
  ...
}: let
  fs = lib.fileset;
  neovimNightlyOut = (utils.flakeToNix {src = sources.neovim-nightly;}).defaultNix;
in {
  aliases = ["vim" "vi"];
  initLua = ''
    require("vismorf")
  '';
  # neovim = neovimNightlyOut.packages.${pkgs.stdenv.hostPlatform.system}.default;
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
          snacks-nvim
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
            hash = sources.zenNvim.hash;
          };
        }
      ];
    opt =
      builtins.attrValues {
        inherit (pkgs.vimPlugins) conform-nvim;
        inherit (pkgs.vimPlugins) friendly-snippets lspkind-nvim;
        inherit (pkgs.vimPlugins) nvim-ufo promise-async;

        inherit
          (pkgs.vimPlugins)
          gitsigns-nvim
          bufferline-nvim
          nvim-cokeline
          indent-blankline-nvim
          mini-animate
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
        pkgs.vimPlugins.nvim-treesitter-context

        #todo: remove this after upstream is merged
        (
          pkgs.vimPlugins.blink-cmp.overrideAttrs
          (_: _: {
            src = pkgs.fetchFromGitHub {
              owner = "Saghen";
              repo = "blink.cmp";
              rev = sources.blink-cmp.revision;
              hash = sources.blink-cmp.hash;
            };
          })
        )
      ];
  };
}
