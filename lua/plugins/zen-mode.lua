return {
    'folke/zen-mode.nvim',
    keys = {
        {
            '<leader>z',
            function()
                return require('zen-mode').toggle()
            end,
            desc = 'Toggle zen mode',
        },
    },
    opts = {
        plugins = {
            kitty = {
                enabled = true,
                font = '+4',
            },
            twilight = { enabled = false },
        },
    },
}
