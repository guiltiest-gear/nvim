return {
    'RRethy/vim-illuminate',
    event = {
        'BufReadPost',
        'BufNewFile',
    },
    keys = {
        {
            '<leader>it',
            function()
                return require('illuminate').toggle()
            end,
        },
        {
            '<leader>ib',
            function()
                return require('illuminate').toggle_buf()
            end,
        },
    },
    opts = {
        filetypes_denylist = {
            'help',
            'text',
        },
    },
    config = function(_, opts)
        require('illuminate').configure(opts)
    end,
}
