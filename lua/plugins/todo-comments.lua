return {
    'folke/todo-comments.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    event = {
        'BufReadPost',
        'BufNewFile',
    },
    keys = {
        {
            '<leader>tn',
            function()
                return require('todo-comments').jump_next()
            end,
        },
        {
            '<leader>tp',
            function()
                return require('todo-comments').jump_prev()
            end,
        },
    },
    config = true,
}
