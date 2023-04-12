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
        ft = {
            'c',
            'cpp',
            'cs',
            'go',
            'java',
            'js',
            'jsx',
            'ts',
            'tsx',
            'jl',
            'lua',
            'nix',
            'php',
            'py',
            'r',
            'rb',
            'vim',
            'zig',
            'rs'
        },
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
        cmd = {
            'HopWord',
            'HopChar1',
            'HopChar2',
            'HopPattern',
            'HopLine',
            'HopAnywhere'
        },
        config = true
    },

    -- nvim-hlslens
    {
        'kevinhwang91/nvim-hlslens',
        keys = {
            'n',
            'N',
            '*',
            '#'
        },
        config = true
    },

    -- colorful-winsep.nvim
    {
        'nvim-zh/colorful-winsep.nvim',
        event = 'WinNew',
        config = true
    },

    -- numb.nvim
    {
        'nacro90/numb.nvim',
        event = 'CmdlineEnter',
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
        dependencies = 'nvim-lualine/lualine.nvim',
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
        keys = {
            'n',
            'N',
            '*',
            '#'
        }
    }
}
