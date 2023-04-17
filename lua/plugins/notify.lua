return {
    {
        'rcarriga/nvim-notify',
        event = 'UIEnter',
        opts = {
            background_colour = '#000000',
        },
        config = function(_, opts)
            local notify = require('notify')
            notify.setup(opts)
            vim.notify = notify
        end,
    },
    {
        'mrded/nvim-lsp-notify',
        event = 'LspAttach',
        opts = {
            icons = {
                spinner = { '┤', '┘', '┴', '└', '├', '┌', '┬', '┐' },
                done = false
            },
        },
    },
}
