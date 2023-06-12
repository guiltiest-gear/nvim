return {
    'akinsho/bufferline.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    version = '*',
    event = 'UIEnter',
    keys = {
        { '<S-h>', '<cmd>BufferLineCyclePrev<CR>', desc = 'Go to next buffer' },
        { '<S-l>', '<cmd>BufferLineCycleNext<CR>', desc = 'Go to previous buffer' },
        { '[b', '<cmd>BufferLineCyclePrev<CR>', desc = 'Go to next buffer' },
        { ']b', '<cmd>BufferLineCycleNext<CR>', desc = 'Go to previous buffer' },
        { '<Tab>', '<cmd>BufferLineCycleNext<CR>', desc = 'Go to next buffer' },
        { '<S-Tab>', '<cmd>BufferLineCyclePrev<CR>', desc = 'Go to previous buffer' },
        {
            '<leader>1',
            function()
                return require('bufferline').go_to(1, true)
            end,
            desc = 'Jump to first buffer',
        },
        {
            '<leader>2',
            function()
                return require('bufferline').go_to(2, true)
            end,
            desc = 'Jump to second buffer',
        },
        {
            '<leader>3',
            function()
                return require('bufferline').go_to(3, true)
            end,
            desc = 'Jump to third buffer',
        },
        {
            '<leader>4',
            function()
                return require('bufferline').go_to(4, true)
            end,
            desc = 'Jump to fourth buffer',
        },
        {
            '<leader>5',
            function()
                return require('bufferline').go_to(5, true)
            end,
            desc = 'Jump to fifth buffer',
        },
        {
            '<leader>6',
            function()
                return require('bufferline').go_to(6, true)
            end,
            desc = 'Jump to sixth buffer',
        },
        {
            '<leader>7',
            function()
                return require('bufferline').go_to(7, true)
            end,
            desc = 'Jump to seventh buffer',
        },
        {
            '<leader>8',
            function()
                return require('bufferline').go_to(8, true)
            end,
            desc = 'Jump to eighth buffer',
        },
        {
            '<leader>9',
            function()
                return require('bufferline').go_to(9, true)
            end,
            desc = 'Jump to ninth buffer',
        },
        {
            '<leader>$',
            function()
                return require('bufferline').go_to(-1, true)
            end,
            desc = 'Jump to last buffer',
        },
    },
    opts = {
        options = {
            mode = 'buffers',
            diagnostics = 'nvim_lsp',
            diagnostics_indicator = function(count, level, diagnostics_dict, context)
                local s = ' '
                for e, n in pairs(diagnostics_dict) do
                    local sym = e == 'error' and ' ' or (e == 'warning' and ' ' or ' ')
                    s = s .. n .. sym
                end
                return s
            end,
        },
    },
}
