return {
    'anuvyklack/windows.nvim',
    dependencies = {
        'anuvyklack/animation.nvim',
        'anuvyklack/middleclass',
    },
    event = 'WinNew',
    keys = {
        { '<C-w>z', '<cmd>WindowsMaximize<CR>' },
        { '<C-w>_', '<cmd>WindowsMaximizeVertically<CR>' },
        { '<C-w>|', '<cmd>WindowsMaximizeHorizontally<CR>' },
        { '<C-w>=', '<cmd>WindowsEqualize<CR>' },
    },
    config = function()
        vim.o.winwidth = 10
        vim.o.winminwidth = 10
        vim.o.equalalways = false
        require('windows').setup()
    end,
}
