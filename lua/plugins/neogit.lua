return {
    'TimUntersberger/neogit',
    dependencies = 'nvim-lua/plenary.nvim',
    keys = {
        { '<leader>gg', '<cmd>Neogit<CR>', desc = 'Neogit' },
    },
    opts = {
        kind = 'replace',
    },
}
