return {
    -- nvim-surround
    {
        'kylechui/nvim-surround',
        event = {
            'BufReadPost',
            'BufNewFile',
        },
        config = true,
    },

    -- Comment.nvim
    {
        'numToStr/Comment.nvim',
        event = {
            'BufReadPost',
            'BufNewFile',
        },
        config = true,
    },

    -- bufdelete.nvim
    {
        'famiu/bufdelete.nvim',
        keys = {
            {
                '<leader>bk',
                function()
                    return require('bufdelete').bufdelete(0, false)
                end,
                desc = 'Delete the current buffer',
            },
            {
                '<leader>bK',
                function()
                    return require('bufdelete').bufdelete(0, true)
                end,
                desc = 'Delete the current buffer forcefully',
            },
        },
    },

    -- hlargs.nvim
    {
        'm-demare/hlargs.nvim',
        dependencies = 'nvim-treesitter/nvim-treesitter',
        ft = {
            'c',
            'cpp',
            'lua',
            'vim',
        },
        config = true,
    },

    -- nvim-hlslens
    {
        'kevinhwang91/nvim-hlslens',
        dependencies = 'romainl/vim-cool',
        keys = {
            'n',
            'N',
            '*',
            '#',
        },
        config = true,
    },

    -- colorful-winsep.nvim
    {
        'nvim-zh/colorful-winsep.nvim',
        event = 'WinNew',
        config = true,
    },

    -- numb.nvim
    {
        'nacro90/numb.nvim',
        event = 'CmdlineEnter',
        config = true,
    },

    -- relative-toggle.nvim
    {
        'cpea2506/relative-toggle.nvim',
        event = 'InsertEnter',
        config = true,
    },

    -- trouble.nvim
    {
        'folke/trouble.nvim',
        dependencies = 'nvim-tree/nvim-web-devicons',
        event = 'LspAttach',
        config = true,
    },

    -- symbols-outline.nvim
    {
        'simrat39/symbols-outline.nvim',
        keys = {
            { '<leader>o', '<cmd>SymbolsOutline<CR>', desc = 'Open symbols-outline' },
        },
        config = true,
    },
}
