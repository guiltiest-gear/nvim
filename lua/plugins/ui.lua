return {
    -- satellite.nvim
    {
        'lewis6991/satellite.nvim',
        event = {
            'BufReadPost',
            'BufNewFile',
        },
        opts = {
            winblend = 0,
        },
    },

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

    -- dressing.nvim
    {
        'stevearc/dressing.nvim',
        init = function()
            vim.ui.select = function(...)
                require('lazy').load { plugins = { 'dressing.nvim' } }
                return vim.ui.select(...)
            end
            vim.ui.input = function(...)
                require('lazy').load { plugins = { 'dressing.nvim' } }
                return vim.ui.input(...)
            end
        end,
        lazy = true,
    },
}
