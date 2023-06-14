return {
    -- Comment.nvim
    {
        'numToStr/Comment.nvim',
        keys = {
            { 'gc', mode = 'n', desc = 'Toggle comments (normal mode)' },
            { 'gc', mode = 'v', desc = 'Toggle comments (visual mode)' },
            { 'gb', mode = 'n', desc = 'Toggle block comments (normal mode)' },
            { 'gb', mode = 'v', desc = 'Toggle block comments (visual mode)' },
        },
        config = true,
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

    -- numb.nvim
    {
        'nacro90/numb.nvim',
        event = 'CmdlineEnter',
        config = true,
    },
}
