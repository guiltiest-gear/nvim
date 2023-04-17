return {
    'echasnovski/mini.animate',
    event = 'BufEnter',
    opts = function()
        local animate = require('mini.animate')
        return {
            resize = {
                enable = false,
            },
            open = {
                enable = false,
            },
            close = {
                enable = false,
            },
            scroll = {
                timing = animate.gen_timing.linear({ duration = 100, unit = 'total' }),
            },
        }
    end,
    config = function(_, opts)
        require('mini.animate').setup(opts)
    end,
}
