return {
    -- Comment.nvim
    {
        'numToStr/Comment.nvim',
        keys = {
            { 'gc', mode = 'n', desc = 'Toggle comments (normal mode)' },
            { 'gc', mode = 'v', desc = 'Toggle comments (visual mode)' },
            { 'gb', mode = 'n', desc = 'Toggle block comments (normal mode)' },
            { 'gb', mode = 'v', desc = 'Toggle block comments (visual mode)' },
        },
        config = true,
    },

    -- trouble.nvim
    {
        'folke/trouble.nvim',
        dependencies = 'nvim-tree/nvim-web-devicons',
        keys = {
            { '<leader>xx', '<cmd>TroubleToggle<CR>' },
            { '<leader>xw', '<cmd>TroubleToggle workspace_diagnostics<CR>' },
            { '<leader>xd', '<cmd>TroubleToggle document_diagnostics<CR>' },
            { '<leader>xq', '<cmd>TroubleToggle quickfix<CR>' },
            { '<leader>xl', '<cmd>TroubleToggle loclist<CR>' },
            { '<leader>xr', '<cmd>TroubleToggle lsp_references<CR>' },
        },
        config = true,
    },

    -- hlargs.nvim
    {
        'm-demare/hlargs.nvim',
        dependencies = 'nvim-treesitter/nvim-treesitter',
        ft = {
            'c',
            'cpp',
            'lua',
            'vim',
        },
        config = true,
    },

    -- numb.nvim
    {
        'nacro90/numb.nvim',
        event = 'CmdlineEnter',
        config = true,
    },
}
