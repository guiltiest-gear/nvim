return {
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
}
