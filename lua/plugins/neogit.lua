return {
    'TimUntersberger/neogit',
    dependencies = 'nvim-lua/plenary.nvim',
    keys = {
        {
            '<leader>gg',
            function()
                return require('neogit').open()
            end,
            desc = 'Neogit',
        },
    },
    opts = {
        kind = 'replace',
    },
}
