return {
    -- todo-comments.nvim
    {
        'folke/todo-comments.nvim',
        dependencies = 'nvim-lua/plenary.nvim',
        event = {
            'BufReadPost',
            'BufNewFile',
        },
        keys = {
            {
                ']t',
                function()
                    return require('todo-comments').jump_next()
                end,
                desc = 'Jump to next todo comment',
            },
            {
                '[t',
                function()
                    return require('todo-comments').jump_prev()
                end,
                desc = 'Jump to previous todo comment',
            },
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

    -- vim-illuminate
    {
        'RRethy/vim-illuminate',
        event = {
            'BufReadPost',
            'BufNewFile',
        },
        opts = {
            filetypes_denylist = {
                'help',
                'text',
            },
        },
        config = function(_, opts)
            require('illuminate').configure(opts)
        end,
    },

    -- nvim-hlslens
    {
        'kevinhwang91/nvim-hlslens',
        dependencies = {
            'romainl/vim-cool',
            -- HACK: There doesn't seem to be an autocommand event to detect when you start
            -- searching, so this will have to do until I can find an event for that or until neovim creates that event
            keys = { '/', '?' },
        },
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
}
