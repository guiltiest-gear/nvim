return {
    'rcarriga/nvim-notify',
    event = {
        'BufReadPost',
        'BufNewFile',
    },
    init = function()
        vim.notify = require('notify')
    end,
    opts = {
        background_colour = '#000000',
    },
}
