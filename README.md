# My neovim config

This isn't anything all too special, just your standard config.

## IMPORTANT NOTICES

1. This config is oriented with ***myself*** in mind, so there may possibly be
confusing or otherwise strange choices made in the config. Regardless, it works
for me. Decide for yourself if I made a janky shitbox of a config, or something
actually usable for people other than me.

2. This is a living config, assume nothing is final. Plugins will inevitably
change and break. Again, this is a config for myself, not for the masses. Use at
your own risk.

## Installation

```bash
git clone --depth 1 https://codeberg.org/j4de/nvim.git ~/.config/nvim && nvim
```

## Dependencies

* git (Obviously)
* luarocks (Used for installing certain mason packages)
* npm (Used for installing certain mason packages)
* ripgrep (Used as the searcher for telescope)

## Screenshots

![A screenshot of my neovim config first opening, with alpha-nvim
being the startpage](https://codeberg.org/j4de/nvim/raw/commit/4182dd63f3ba604e92daf768e894dd3fc4615d09/assets/Start%20screen.png)
![A screenshot of various files open, including init.lua, plugins.lua,
which-key.lua, and options.lua](https://codeberg.org/j4de/nvim/raw/commit/4182dd63f3ba604e92daf768e894dd3fc4615d09/assets/Editing.png)

## Plugins

* [Comment.nvim](https://github.com/numToStr/Comment.nvim)
* [LuaSnip](https://github.com/L3MON4D3/LuaSnip)
* [animation.nvim](https://github.com/anuvyklack/animation.nvim)
* [better-escape.nvim](https://github.com/max397574/better-escape.nvim)
* [bufdelete.nvim](https://github.com/famiu/bufdelete.nvim)
* [bufferline.nvim](https://github.com/akinsho/bufferline.nvim)
* [cmp-async-path](https://github.com/FelipeLema/cmp-async-path)
* [cmp-buffer](https://github.com/hrsh7th/cmp-buffer)
* [cmp-calc](https://github.com/hrsh7th/cmp-calc)
* [cmp-cmdline](https://github.com/hrsh7th/cmp-cmdline)
* [cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp)
* [cmp-nvim-lua](https://github.com/hrsh7th/cmp-nvim-lua)
* [cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip)
* [colorful-winsep.nvim](https://github.com/nvim-zh/colorful-winsep.nvim)
* [dashboard-nvim](https://github.com/nvimdev/dashboard-nvim)
* [dial.nvim](https://github.com/monaqa/dial.nvim)
* [dressing.nvim](https://github.com/stevearc/dressing.nvim)
* [flit.nvim](https://github.com/ggandor/flit.nvim)
* [friendly-snippets](https://github.com/rafamadriz/friendly-snippets)
* [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)
* [hlargs.nvim](https://github.com/m-demare/hlargs.nvim)
* [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim)
* [lazy.nvim](https://github.com/folke/lazy.nvim)
* [leap.nvim](https://github.com/ggandor/leap.nvim)
* [lsp_lines.nvim](https://git.sr.ht/~whynothugo/lsp_lines.nvim)
* [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)
* [mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim)
* [mason-null-ls.nvim](https://github.com/jay-babu/mason-null-ls.nvim)
* [mason.nvim](https://github.com/williamboman/mason.nvim)
* [middleclass](https://github.com/anuvyklack/middleclass)
* [modicator.nvim](https://github.com/mawkler/modicator.nvim)
* [neogit](https://github.com/TimUntersberger/neogit)
* [null-ls.nvim](https://github.com/jose-elias-alvarez/null-ls.nvim)
* [numb.nvim](https://github.com/nacro90/numb.nvim)
* [nvim-autopairs](https://github.com/windwp/nvim-autopairs)
* [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
* [nvim-hlslens](https://github.com/kevinhwang91/nvim-hlslens)
* [nvim-lsp-notify](https://github.com/mrded/nvim-lsp-notify)
* [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
* [nvim-navic](https://github.com/SmiteshP/nvim-navic)
* [nvim-notify](https://github.com/rcarriga/nvim-notify)
* [nvim-scrollbar](https://github.com/petertriho/nvim-scrollbar)
* [nvim-surround](https://github.com/kylechui/nvim-surround)
* [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua)
* [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
* [nvim-ufo](https://github.com/kevinhwang91/nvim-ufo)
* [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons)
* [plenary.nvim](https://github.com/nvim-lua/plenary.nvim)
* [promise-async](https://github.com/kevinhwang91/promise-async)
* [relative-toggle.nvim](https://github.com/cpea2506/relative-toggle.nvim)
* [symbols-outline.nvim](https://github.com/simrat39/symbols-outline.nvim)
* [telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim)
* [telescope-undo.nvim](https://github.com/debugloop/telescope-undo.nvim)
* [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
* [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim)
* [tokyonight.nvim](https://github.com/folke/tokyonight.nvim)
* [treesj](https://github.com/Wansmer/treesj)
* [trouble.nvim](https://github.com/folke/trouble.nvim)
* [vim-cool](https://github.com/romainl/vim-cool)
* [vim-illuminate](https://github.com/RRethy/vim-illuminate)
* [vim-matchup](https://github.com/andymass/vim-matchup)
* [vim-repeat](https://github.com/tpope/vim-repeat)
* [which-key.nvim](https://github.com/folke/which-key.nvim)
* [windows.nvim](https://github.com/anuvyklack/windows.nvim)
* [zen-mode.nvim](https://github.com/folke/zen-mode.nvim)

## License

MIT
