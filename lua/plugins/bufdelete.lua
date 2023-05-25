return {
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
}
