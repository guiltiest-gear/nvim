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
