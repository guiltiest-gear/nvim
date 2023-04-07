-- Install lazy.nvim automatically
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Plugin section
local plugins = {
    -- nvim-lualine
    {
        'nvim-lualine/lualine.nvim',
        dependencies = 'nvim-tree/nvim-web-devicons',
        event = 'VeryLazy'
    },

    -- neogit
    {
        'TimUntersberger/neogit',
        dependencies = 'nvim-lua/plenary.nvim',
        cmd = 'Neogit'
    },

    -- gitsigns.nvim
    {
        'lewis6991/gitsigns.nvim',
        ft = 'gitcommit'
    },

    -- tokyonight.nvim colorscheme
    {
        'folke/tokyonight.nvim',
        lazy = false,
        priority = 1000
    },

    -- nvim-autopairs
    {
        'windwp/nvim-autopairs',
        event = 'VeryLazy'
    },

    -- nvim-surround
    {
        'kylechui/nvim-surround',
        keys = {
            'cs',
            'ys',
            'ds'
        }
    },

    -- Comment.nvim
    {
        'numToStr/Comment.nvim',
        keys = {
            'gc',
            'gb'
        }
    },

    -- indent-blankline.nvim
    {
        'lukas-reineke/indent-blankline.nvim',
        event = 'VeryLazy'
    },

    -- telescope.nvim
    {
        'nvim-telescope/telescope.nvim',
        dependencies = 'nvim-lua/plenary.nvim',
        branch = '0.1.x',
        cmd = 'Telescope'
    },

    -- telescope-fzf-native.nvim
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        dependencies = 'nvim-telescope/telescope.nvim',
        lazy = true
    },

    -- bufferline.nvim
    {
        'akinsho/bufferline.nvim',
        dependencies = 'nvim-tree/nvim-web-devicons',
        version = 'v3.*',
        event = 'BufAdd'
    },

    -- bufdelete.nvim
    {
        'famiu/bufdelete.nvim',
        cmd = {
            'Bdelete',
            'Bwipeout'
        }
    },

    -- nvim-tree.lua
    {
        'nvim-tree/nvim-tree.lua',
        dependencies = 'nvim-tree/nvim-web-devicons',
        cmd = 'NvimTreeToggle'
    },

    -- which-key.nvim
    {
        'folke/which-key.nvim',
        keys = {
            '<leader>',
            '"',
            "'",
            '`'
        }
    },

    -- alpha-nvim
    {
        'goolord/alpha-nvim',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
            'BlakeJC94/alpha-nvim-fortune'
        },
        lazy = false,
        priority = 1500
    },

    -- nvim-treesitter
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        event = 'VeryLazy'
    },

    -- hlargs.nvim
    {
        'm-demare/hlargs.nvim',
        dependencies = 'nvim-treesitter/nvim-treesitter',
        event = 'VeryLazy'
    },

    -- toggleterm.nvim
    {
        'akinsho/toggleterm.nvim',
        version = '*',
        event = 'VeryLazy'
    },

    -- cmp plugins
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-buffer',
            'FelipeLema/cmp-async-path',
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lua',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-calc'
        },
        event = 'InsertEnter'
    },

    -- Snippets
    {
        'L3MON4D3/LuaSnip',
        build = 'make install_jsregexp',
        version = 'v1.*',
        dependencies = 'rafamadriz/friendly-snippets',
        event = 'VeryLazy'
    },

    -- nvim-lspconfig
    {
        'neovim/nvim-lspconfig',
        event = 'LspAttach'
    },

    -- mason.nvim
    {
        'williamboman/mason.nvim',
        dependencies = 'williamboman/mason-lspconfig.nvim',
        build = ':MasonUpdate',
        cmd = {
            'Mason',
            'MasonInstall',
            'MasonInstallAll',
            'MasonUninstall',
            'MasonUninstallAll',
            'MasonLog'
        }
    },

    -- null-ls.nvim
    {
        'jose-elias-alvarez/null-ls.nvim',
        dependencies = 'nvim-lua/plenary.nvim',
        event = 'LspAttach'
    },

    -- Twilight
    {
        'folke/twilight.nvim',
        cmd = 'Twilight',
    },

    -- vim-illuminate
    {
        'RRethy/vim-illuminate',
        event = 'VeryLazy'
    },

    -- nvim-scrollbar
    {
        'petertriho/nvim-scrollbar',
        event = 'VeryLazy'
    },

    -- hop.nvim
    {
        'phaazon/hop.nvim',
        branch = 'v2',
        event = 'VeryLazy'
    },

    -- fidget.nvim
    {
        'j-hui/fidget.nvim',
        event = 'LspAttach'
    },

    -- nvim-ufo
    {
        'kevinhwang91/nvim-ufo',
        dependencies = 'kevinhwang91/promise-async',
        event = 'VeryLazy'
    },

    -- nvim-hlslens
    {
        'kevinhwang91/nvim-hlslens',
        event = 'VeryLazy'
    },

    -- neodim
    {
        'zbirenbaum/neodim',
        event = 'LspAttach',
        branch = 'v2'
    },

    -- colorful-winsep.nvim
    {
        'nvim-zh/colorful-winsep.nvim',
        event = 'WinEnter'
    },

    -- numb.nvim
    {
        'nacro90/numb.nvim',
        event = 'CmdlineEnter'
    },

    -- windows.nvim
    {
        'anuvyklack/windows.nvim',
        dependencies = {
            'anuvyklack/middleclass',
            'anuvyklack/animation.nvim'
        },
        event = 'WinNew'
    },

    -- lsp_lines.nvim
    {
        'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
        event = 'LspAttach'
    },

    -- nvim-genghis
    {
        'chrisgrieser/nvim-genghis',
        dependencies = 'stevearc/dressing.nvim',
        cmd = {
            'New',
            'Duplicate',
            'NewFromSelection',
            'Rename',
            'Move',
            'CopyFilename',
            'CopyFilepath',
            'Chmodx'
        }
    },

    -- relative-toggle.nvim
    {
        'cpea2506/relative-toggle.nvim',
        event = 'InsertEnter'
    },

    -- nvim-navic
    {
        'SmiteshP/nvim-navic',
        dependencies = 'neovim/nvim-lspconfig',
        event = 'LspAttach'
    },

    {
        'folke/trouble.nvim',
        dependencies = 'nvim-tree/nvim-web-devicons',
        event = 'LspAttach'
    },

    -- vim-cool
    {
        'romainl/vim-cool',
        event = 'VeryLazy'
    },
}

-- options section
local opts = {
    defaults = {
        lazy = true
    },
    custom_keys = {},
}

-- Load the plugins and options
require('lazy').setup(plugins, opts)
