return {
    'akinsho/bufferline.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    version = '*',
    event = 'VimEnter',
    keys = {
        { '<S-h>', '<cmd>BufferLineCyclePrev<CR>' },
        { '<S-l>', '<cmd>BufferLineCycleNext<CR>' },
        { '[b', '<cmd>BufferLineCyclePrev<CR>' },
        { ']b', '<cmd>BufferLineCycleNext<CR>' },
        { '<Tab>', '<cmd>BufferLineCycleNext<CR>' },
        { '<S-Tab>', '<cmd>BufferLineCyclePrev<CR>' },
        {
            '<leader>1',
            function()
                return require('bufferline').go_to(1, true)
            end,
        },
        {
            '<leader>2',
            function()
                return require('bufferline').go_to(2, true)
            end,
        },
        {
            '<leader>3',
            function()
                return require('bufferline').go_to(3, true)
            end,
        },
        {
            '<leader>4',
            function()
                return require('bufferline').go_to(4, true)
            end,
        },
        {
            '<leader>5',
            function()
                return require('bufferline').go_to(5, true)
            end,
        },
        {
            '<leader>6',
            function()
                return require('bufferline').go_to(6, true)
            end,
        },
        {
            '<leader>7',
            function()
                return require('bufferline').go_to(7, true)
            end,
        },
        {
            '<leader>8',
            function()
                return require('bufferline').go_to(8, true)
            end,
        },
        {
            '<leader>9',
            function()
                return require('bufferline').go_to(9, true)
            end,
        },
        {
            '<leader>$',
            function()
                return require('bufferline').go_to(-1, true)
            end,
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
