return {
    -- nvim-notify
    {
        'rcarriga/nvim-notify',
        event = {
            'BufReadPost',
            'BufNewFile',
        },
        opts = {
            background_colour = '#000000',
        },
        config = function(_, opts)
            local notify = require('notify')
            notify.setup(opts)
            vim.notify = notify
        end,
    },

    -- nvim-lsp-notify
    {
        'mrded/nvim-lsp-notify',
        dependencies = 'rcarriga/nvim-notify',
        event = 'LspAttach',
        opts = {
            icons = {
                spinner = {
                    '┤',
                    '┘',
                    '┴',
                    '└',
                    '├',
                    '┌',
                    '┬',
                    '┐',
                },
                done = false,
            },
        },
    },
}
