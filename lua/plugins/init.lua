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
            'R',
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

    -- nvim-hlslens
    {
        'kevinhwang91/nvim-hlslens',
        keys = {
            'n',
            'N',
            '*',
            '#'
        },
        dependencies = 'romainl/vim-cool',
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
        event = {
            'BufReadPre',
            'BufNewFile'
        },
        config = true
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

    -- sentiment.nvim
    {
        'utilyre/sentiment.nvim',
        version = '*',
        event = 'BufAdd',
        config = true
    },

    -- treesj
    {
        'Wansmer/treesj',
        keys = {
            '<leader>m',
            '<leader>j',
            '<leader>s'
        },
        dependencies = 'nvim-treesitter/nvim-treesitter',
        config = true
    },

    -- search-replace.nvim
    {
        'roobert/search-replace.nvim',
        cmd = {
            'SearchReplaceSingleBufferVisualSelection',
            'SearchReplaceWithinVisualSelection',
            'SearchReplaceWithinVisualSelectionCWord'
        },
        keys = {
            '<leader>rs',
            '<leader>ro',
            '<leader>rw',
            '<leader>rW',
            '<leader>re',
            '<leader>rf',
            '<leader>rbs',
            '<leader>rbo',
            '<leader>rbw',
            '<leader>rbW',
            '<leader>rbe',
            '<leader>rbf',
        },
        config = true
    }
}
