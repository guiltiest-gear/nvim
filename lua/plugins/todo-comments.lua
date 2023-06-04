return {
    'folke/todo-comments.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    event = {
        'BufReadPost',
        'BufNewFile',
    },
    keys = {
        {
            ']t',
            function()
                return require('todo-comments').jump_next()
            end,
            desc = 'Jump to next todo comment',
        },
        {
            '[t',
            function()
                return require('todo-comments').jump_prev()
            end,
            desc = 'Jump to previous todo comment',
        },
    },
    config = true,
}
