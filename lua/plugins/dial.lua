return {
    'monaqa/dial.nvim',
    keys = {
        { '<C-a>', function() return require('dial.map').inc_normal() end, expr = true, desc = 'Increment' },
        { '<C-x>', function() return require('dial.map').dec_normal() end, expr = true, desc = 'Decrement' },
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
