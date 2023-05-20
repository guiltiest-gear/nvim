return {
    'anuvyklack/windows.nvim',
    dependencies = {
        'anuvyklack/animation.nvim',
        'anuvyklack/middleclass',
    },
    event = 'WinNew',
    config = function()
        vim.o.winwidth = 10
        vim.o.winminwidth = 10
        vim.o.equalalways = false
        require('windows').setup()
    end,
}
