return {
    -- nvim-surround
    {
        'kylechui/nvim-surround',
        event = {
            'BufReadPost',
            'BufNewFile',
        },
        config = true,
    },

    -- Comment.nvim
    {
        'numToStr/Comment.nvim',
        event = {
            'BufReadPost',
            'BufNewFile',
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

    -- nvim-hlslens
    {
        'kevinhwang91/nvim-hlslens',
        dependencies = 'romainl/vim-cool',
        keys = {
            { 'n', [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]] },
            { 'N', [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]] },
            { '*', [[*<Cmd>lua require('hlslens').start()<CR>]] },
            { '#', [[#<Cmd>lua require('hlslens').start()<CR>]] },
            { 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]] },
            { 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]] },
        },
        config = true,
    },

    -- colorful-winsep.nvim
    {
        'nvim-zh/colorful-winsep.nvim',
        event = 'WinNew',
        config = true,
    },

    -- numb.nvim
    {
        'nacro90/numb.nvim',
        event = 'CmdlineEnter',
        config = true,
    },

    -- relative-toggle.nvim
    {
        'cpea2506/relative-toggle.nvim',
        event = 'InsertEnter',
        config = true,
    },

    -- trouble.nvim
    {
        'folke/trouble.nvim',
        dependencies = 'nvim-tree/nvim-web-devicons',
        event = 'LspAttach',
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

    -- symbols-outline.nvim
    {
        'simrat39/symbols-outline.nvim',
        keys = {
            { '<leader>o', '<cmd>SymbolsOutline<CR>', desc = 'Open symbols-outline' },
        },
        config = true,
    },
}
