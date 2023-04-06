-- Install lazy.nvim automaticallypl
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
require('lazy').setup({
    -- nvim-lualine
    {
        'nvim-lualine/lualine.nvim',
        dependencies = 'nvim-tree/nvim-web-devicons'
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
    'windwp/nvim-autopairs',

    -- nvim-surround
    'kylechui/nvim-surround',

    -- Comment.nvim
    'numToStr/Comment.nvim',

    -- indent-blankline.nvim
    'lukas-reineke/indent-blankline.nvim',

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
        dependencies = 'nvim-telescope/telescope.nvim'
    },

    -- bufferline.nvim
    {
        'akinsho/bufferline.nvim',
        dependencies = 'nvim-tree/nvim-web-devicons',
        version = 'v3.*'
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
        build = ':TSUpdate'
    },

    -- hlargs.nvim
    {
        'm-demare/hlargs.nvim',
        dependencies = 'nvim-treesitter/nvim-treesitter'
    },

    -- toggleterm.nvim
    {
        'akinsho/toggleterm.nvim',
        version = '*'
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
        dependencies = 'rafamadriz/friendly-snippets'
    },

    -- nvim-lspconfig
    'neovim/nvim-lspconfig',

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
        dependencies = 'nvim-lua/plenary.nvim'
    },

    -- Twilight
    {
        'folke/twilight.nvim',
        cmd = 'Twilight',
    },

    -- vim-illuminate
    'RRethy/vim-illuminate',

    -- nvim-scrollbar
    'petertriho/nvim-scrollbar',

    -- hop.nvim
    'phaazon/hop.nvim',

    -- fidget.nvim
    'j-hui/fidget.nvim',

    -- nvim-ufo
    {
        'kevinhwang91/nvim-ufo',
        dependencies = 'kevinhwang91/promise-async'
    },

    -- nvim-hlslens
    'kevinhwang91/nvim-hlslens',

    -- neodim
    {
        'zbirenbaum/neodim',
        event = 'LspAttach'
    },

    -- colorful-winsep.nvim
    'nvim-zh/colorful-winsep.nvim',

    -- numb.nvim
    'nacro90/numb.nvim',

    -- windows.nvim
    {
        'anuvyklack/windows.nvim',
        dependencies = {
            'anuvyklack/middleclass',
            'anuvyklack/animation.nvim'
        }
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
    'cpea2506/relative-toggle.nvim',

    -- nvim-navic
    {
        'SmiteshP/nvim-navic',
        dependencies = 'neovim/nvim-lspconfig',
        event = 'LspAttach'
    },

    -- vim-cool
    'romainl/vim-cool',
})
