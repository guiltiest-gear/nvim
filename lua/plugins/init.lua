return {
    -- nvim-surround
    {
        'kylechui/nvim-surround',
        keys = {
            'cs',
            'ys',
            'ds'
        },
        config = true
    },

    -- Comment.nvim
    {
        'numToStr/Comment.nvim',
        keys = {
            'gc',
            'gb'
        },
        config = true
    },

    -- telescope-fzf-native.nvim
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        dependencies = 'nvim-telescope/telescope.nvim',
        lazy = true
    },

    -- bufdelete.nvim
    {
        'famiu/bufdelete.nvim',
        cmd = {
            'Bdelete',
            'Bwipeout'
        }
    },

    -- hlargs.nvim
    {
        'm-demare/hlargs.nvim',
        dependencies = 'nvim-treesitter/nvim-treesitter',
        event = 'VeryLazy',
        config = true
    },

    -- Snippets
    {
        'L3MON4D3/LuaSnip',
        build = 'make install_jsregexp',
        version = 'v1.*',
        dependencies = 'rafamadriz/friendly-snippets',
        event = 'InsertEnter'
    },

    -- nvim-lspconfig
    {
        'neovim/nvim-lspconfig',
        event = 'VeryLazy'
    },

    -- mason.nvim
    {
        'williamboman/mason.nvim',
        dependencies = 'williamboman/mason-lspconfig.nvim',
        build = ':MasonUpdate'
    },

    -- null-ls.nvim
    {
        'jose-elias-alvarez/null-ls.nvim',
        dependencies = 'nvim-lua/plenary.nvim',
        event = 'VeryLazy'
    },

    -- Twilight
    {
        'folke/twilight.nvim',
        cmd = 'Twilight',
        config = true
    },

    -- hop.nvim
    {
        'phaazon/hop.nvim',
        branch = 'v2',
        event = 'VeryLazy',
        config = true
    },

    -- nvim-hlslens
    {
        'kevinhwang91/nvim-hlslens',
        event = 'VeryLazy',
        config = true
    },

    -- colorful-winsep.nvim
    {
        'nvim-zh/colorful-winsep.nvim',
        event = 'WinEnter',
        config = true
    },

    -- numb.nvim
    {
        'nacro90/numb.nvim',
        event = 'CmdlineEnter',
        config = true
    },

    -- windows.nvim
    {
        'anuvyklack/windows.nvim',
        dependencies = {
            'anuvyklack/middleclass',
            'anuvyklack/animation.nvim'
        },
        event = 'WinNew',
        config = true
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
        event = 'InsertEnter',
        config = true
    },

    -- nvim-navic
    {
        'SmiteshP/nvim-navic',
        dependencies = 'neovim/nvim-lspconfig',
        event = 'LspAttach',
        config = true
    },

    -- trouble.nvim
    {
        'folke/trouble.nvim',
        dependencies = 'nvim-tree/nvim-web-devicons',
        event = 'LspAttach',
        config = true
    },

    -- vim-cool
    {
        'romainl/vim-cool',
        event = 'VeryLazy'
    }
}
