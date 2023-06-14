return {
    'RRethy/vim-illuminate',
    event = {
        'BufReadPost',
        'BufNewFile',
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
