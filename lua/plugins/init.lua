return {
    -- nvim-surround
    {
        'kylechui/nvim-surround',
        keys = {
            { 'cs', mode = 'n', desc = 'Change surroundings' },
            { 'ys', mode = 'n', desc = 'Add surroundings' },
            { 'ds', mode = 'n', desc = 'Delete surroundings' },
        },
        config = true,
    },

    -- Comment.nvim
    {
        'numToStr/Comment.nvim',
        keys = {
            { 'gcc', mode = 'n' },
            { 'gc', mode = 'v' },
            { 'gbc', mode = 'n' },
            { 'gb', mode = 'v' },
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
