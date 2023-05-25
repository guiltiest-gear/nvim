return {
    'RRethy/vim-illuminate',
    event = 'LspAttach',
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
            'alpha',
            'NvimTree',
            'help',
            'text',
        },
    },
    config = function(_, opts)
        require('illuminate').configure(opts)
    end,
}
