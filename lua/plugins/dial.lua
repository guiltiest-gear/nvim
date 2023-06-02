return {
    'monaqa/dial.nvim',
    keys = {
        {
            '<C-a>',
            function()
                return require('dial.map').inc_normal()
            end,
            expr = true,
        },
        {
            '<C-x>',
            function()
                return require('dial.map').dec_normal()
            end,
            expr = true,
        },
        {
            'g<C-a>',
            function()
                return require('dial.map').inc_gnormal()
            end,
            expr = true,
        },
        {
            'g<C-x>',
            function()
                return require('dial.map').dec_gnormal()
            end,
            expr = true,
        },
        {
            '<C-a>',
            function()
                return require('dial.map').inc_visual()
            end,
            'v',
            expr = true,
        },
        {
            '<C-x>',
            function()
                return require('dial.map').dec_visual()
            end,
            'v',
            expr = true,
        },
        {
            'g<C-a>',
            function()
                return require('dial.map').inc_gvisual()
            end,
            'v',
            expr = true,
        },
        {
            'g<C-x>',
            function()
                return require('dial.map').dec_gvisual()
            end,
            'v',
            expr = true,
        },
    },
    config = function()
        local augend = require('dial.augend')
        require('dial.config').augends:register_group {
            default = {
                augend.integer.alias.decimal,
                augend.integer.alias.hex,
                augend.constant.alias.bool,
            },
        }
    end,
}
