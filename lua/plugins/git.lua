return {
    -- neogit
    {
        'TimUntersberger/neogit',
        dependencies = 'nvim-lua/plenary.nvim',
        keys = {
            {
                '<leader>gg',
                function()
                    return require('neogit').open()
                end,
                desc = 'Neogit',
            },
        },
        opts = {
            kind = 'replace',
            disable_builtin_notifications = true,
        },
    },

    -- gitsigns.nvim
    {
        'lewis6991/gitsigns.nvim',
        init = function()
            -- load gitsigns only when a git file is opened
            vim.api.nvim_create_autocmd({ 'BufRead' }, {
                group = vim.api.nvim_create_augroup('GitSignsLazyLoad', { clear = true }),
                callback = function()
                    vim.fn.system('git -C ' .. '"' .. vim.fn.expand('%:p:h') .. '"' .. ' rev-parse')
                    if vim.v.shell_error == 0 then
                        vim.api.nvim_del_augroup_by_name('GitSignsLazyLoad')
                        vim.schedule(function()
                            require('lazy').load { plugins = { 'gitsigns.nvim' } }
                        end)
                    end
                end,
            })
        end,
        ft = 'gitcommit',
        keys = {
            {
                '<leader>gj',
                function()
                    return require('gitsigns').next_hunk()
                end,
                desc = 'Next hunk',
            },
            {
                '<leader>gk',
                function()
                    return require('gitsigns').prev_hunk()
                end,
                desc = 'Previous hunk',
            },
            {
                ']g',
                function()
                    return require('gitsigns').next_hunk()
                end,
                desc = 'Next hunk',
            },
            {
                '[g',
                function()
                    return require('gitsigns').prev_hunk()
                end,
                desc = 'Previous hunk',
            },
            {
                '<leader>gl',
                function()
                    return require('gitsigns').blame_line()
                end,
                desc = 'Open git blame',
            },
            {
                '<leader>gp',
                function()
                    return require('gitsigns').preview_hunk()
                end,
                desc = 'Preview the hunk',
            },
            {
                '<leader>gr',
                function()
                    return require('gitsigns').reset_hunk()
                end,
                desc = 'Reset the hunk',
            },
            {
                '<leader>gR',
                function()
                    return require('gitsigns').reset_buffer()
                end,
                desc = 'Reset the buffer',
            },
            {
                '<leader>gs',
                function()
                    return require('gitsigns').stage_hunk()
                end,
                desc = 'Stage the hunk',
            },
            {
                '<leader>gS',
                function()
                    return require('gitsigns').stage_buffer()
                end,
                desc = 'Stage the buffer',
            },
            {
                '<leader>gu',
                function()
                    return require('gitsigns').undo_stage_hunk()
                end,
                desc = 'Unstage the hunk',
            },
            {
                '<leader>gd',
                function()
                    return require('gitsigns').diffthis()
                end,
                desc = 'Open a diff',
            },
        },
        opts = {
            signs = {
                add = {
                    hl = 'GitSignsAdd',
                    text = '+',
                    numhl = 'GitSignsAddNr',
                    linehl = 'GitSignsAddLn',
                },
                change = {
                    hl = 'GitSignsChange',
                    text = '~',
                    numhl = 'GitSignsChangeNr',
                    linehl = 'GitSignsChangeLn',
                },
                delete = {
                    hl = 'GitSignsDelete',
                    text = '-',
                    numhl = 'GitSignsDeleteNr',
                    linehl = 'GitSignsDeleteLn',
                },
                topdelete = {
                    hl = 'GitSignsDelete',
                    text = '-',
                    numhl = 'GitSignsDeleteNr',
                    linehl = 'GitSignsDeleteLn',
                },
                changedelete = {
                    hl = 'GitSignsChange',
                    text = '~',
                    numhl = 'GitSignsChangeNr',
                    linehl = 'GitSignsChangeLn',
                },
            },
            signcolumn = true, -- Toggle with `:GitSigns toggle_signs`
            watch_gitdir = {
                interval = 1000,
                follow_files = true,
            },
            attach_to_untracked = true,
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
                delay = 1000,
            },
            sign_priority = 6,
            update_debounce = 100,
            status_formatter = nil,
            preview_config = {
                border = 'single',
                style = 'minimal',
                relative = 'cursor',
                row = 0,
                col = 1,
            },
        },
    },
}
