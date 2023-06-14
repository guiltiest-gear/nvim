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

    -- vim-matchup
    {
        'andymass/vim-matchup',
        dependencies = 'nvim-treesitter/nvim-treesitter',
        init = function()
            vim.g.matchup_matchparen_offscreen = { method = 'status_manual' }
        end,
        event = {
            'BufReadPost',
            'BufNewFile',
        },
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

    -- neo-tree.nvim
    {
        'nvim-neo-tree/neo-tree.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-tree/nvim-web-devicons',
            'MunifTanjim/nui.nvim',
        },
        branch = 'v2.x',
        init = function()
            vim.g.neo_tree_remove_legacy_commands = 1
        end,
        keys = {
            {
                '<leader>e',
                '<cmd>Neotree toggle<CR>',
                desc = 'Open neo-tree.nvim',
            },
        },
        opts = {
            default_component_configs = {
                icon = {
                    folder_empty = '󰜌',
                    folder_empty_open = '󰜌',
                },
                git_status = {
                    symbols = {
                        renamed = '󰁕',
                        unstaged = '󰄱',
                    },
                },
            },
            document_symbols = {
                kinds = {
                    File = { icon = '󰈙', hl = 'Tag' },
                    Namespace = { icon = '󰌗', hl = 'Include' },
                    Package = { icon = '󰏖', hl = 'Label' },
                    Class = { icon = '󰌗', hl = 'Include' },
                    Property = { icon = '󰆧', hl = '@property' },
                    Enum = { icon = '󰒻', hl = '@number' },
                    Function = { icon = '󰊕', hl = 'Function' },
                    String = { icon = '󰀬', hl = 'String' },
                    Number = { icon = '󰎠', hl = 'Number' },
                    Array = { icon = '󰅪', hl = 'Type' },
                    Object = { icon = '󰅩', hl = 'Type' },
                    Key = { icon = '󰌋', hl = '' },
                    Struct = { icon = '󰌗', hl = 'Type' },
                    Operator = { icon = '󰆕', hl = 'Operator' },
                    TypeParameter = { icon = '󰊄', hl = 'Type' },
                    StaticMethod = { icon = '󰠄 ', hl = 'Function' },
                },
            },
            source_selector = {
                winbar = true,
                statusline = true,
                sources = {
                    { source = 'filesystem', display_name = ' 󰉓 Files ' },
                    -- { source = 'git_status', display_name = ' 󰊢 Git ' },
                },
            },
            filesystem = {
                filtered_items = {
                    hide_dotfiles = false,
                    hide_by_name = {
                        '.git',
                    },
                },
                follow_current_file = true,
            },
        },
    },

    -- leap.nvim
    {
        'ggandor/leap.nvim',
        dependencies = 'tpope/vim-repeat',
        keys = {
            { 's', mode = { 'n', 'x', 'o' }, desc = 'Leap forward to' },
            { 'S', mode = { 'n', 'x', 'o' }, desc = 'Leap backward to' },
            { 'gs', mode = { 'n', 'x', 'o' }, desc = 'Leap from windows' },
        },
        config = function(_, opts)
            local leap = require('leap')
            for k, v in pairs(opts) do
                leap.opts[k] = v
            end
            leap.add_default_mappings(true)
            vim.keymap.del({ 'x', 'o' }, 'x')
            vim.keymap.del({ 'x', 'o' }, 'X')
        end,
    },

    -- flit.nvim
    {
        'ggandor/flit.nvim',
        dependencies = 'ggandor/leap.nvim',
        keys = function()
            local ret = {}
            for _, key in ipairs { 'f', 'F', 't', 'T' } do
                ret[#ret + 1] = { key, mode = { 'n', 'x', 'o' }, desc = key }
            end
            return ret
        end,
        opts = { labeled_modes = 'nx' },
    },

    -- zen-mode.nvim
    {
        'folke/zen-mode.nvim',
        keys = {
            {
                '<leader>z',
                function()
                    return require('zen-mode').toggle()
                end,
                desc = 'Toggle zen mode',
            },
        },
        opts = {
            plugins = {
                kitty = {
                    enabled = true,
                    font = '+4',
                },
                twilight = { enabled = false },
            },
        },
    },

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

    -- toggleterm.nvim
    {
        'akinsho/toggleterm.nvim',
        version = '*',
        keys = [[<C-\>]],
        opts = {
            open_mapping = [[<C-\>]],
            size = 20,
            hide_numbers = true,
            shell = vim.o.shell,
            shade_terminals = true,
            shading_factor = 2,
            persist_size = true,
            start_in_insert = true,
            direction = 'float',
            close_on_exit = true,
            float_opts = {
                border = 'curved',
            },
        },
    },

    -- bufdelete.nvim
    {
        'famiu/bufdelete.nvim',
        keys = {
            { '<leader>bk', '<cmd>Bdelete<CR>', desc = 'Delete the current buffer' },
            { '<leader>bK', '<cmd>Bdelete!<CR>', desc = 'Delete the current buffer forcefully' },
        },
    },

    -- bufferline.nvim
    {
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
                numbers = function(opts)
                    return string.format('%s', opts.ordinal)
                end,
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
    },

    -- numb.nvim
    {
        'nacro90/numb.nvim',
        event = 'CmdlineEnter',
        config = true,
    },

    -- better-escape.nvim
    {
        'max397574/better-escape.nvim',
        event = 'InsertCharPre',
        opts = {
            mapping = {
                'jj',
                'jk',
                'kk',
            },
        },
    },

    -- telescope.nvim
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make',
                config = function()
                    require('telescope').load_extension('fzf')
                end,
            },
            {
                'debugloop/telescope-undo.nvim',
                config = function()
                    require('telescope').load_extension('undo')
                end,
            },
        },
        branch = '0.1.x',
        keys = {
            {
                '<leader>ff',
                function()
                    return require('telescope.builtin').find_files()
                end,
                desc = 'Find files',
            },
            {
                '<leader>fw',
                function()
                    return require('telescope.builtin').live_grep()
                end,
                desc = 'Find words',
            },
            {
                '<leader>fb',
                function()
                    return require('telescope.builtin').buffers()
                end,
                desc = 'Search buffers',
            },
            {
                '<leader>fh',
                function()
                    return require('telescope.builtin').help_tags()
                end,
                desc = 'Search help',
            },
            {
                '<leader>fm',
                function()
                    return require('telescope.builtin').man_pages()
                end,
                desc = 'Search man pages',
            },
            {
                '<leader>fr',
                function()
                    return require('telescope.builtin').oldfiles()
                end,
                desc = 'Search recently opened files',
            },
            {
                '<leader>fR',
                function()
                    return require('telescope.builtin').registers()
                end,
                desc = 'Search registers',
            },
            {
                '<leader>fk',
                function()
                    return require('telescope.builtin').keymaps()
                end,
                desc = 'Search keymaps',
            },
            {
                '<leader>fc',
                function()
                    return require('telescope.builtin').commands()
                end,
                desc = 'Search commands',
            },
            {
                '<leader>go',
                function()
                    return require('telescope.builtin').git_status()
                end,
                desc = 'Seach through changed files',
            },
            {
                '<leader>gb',
                function()
                    return require('telescope.builtin').git_branches()
                end,
                desc = 'Search through git branches',
            },
            {
                '<leader>gc',
                function()
                    return require('telescope.builtin').git_commits()
                end,
                desc = 'Search and checkout git commits',
            },
            {
                '<leader>ft',
                '<cmd>TodoTelescope<CR>',
                desc = 'Search through todo comments',
            },
            {
                '<leader>u',
                function()
                    return require('telescope').extensions.undo.undo()
                end,
                desc = 'Search through undo tree',
            },
        },
        opts = {
            defaults = {
                theme = 'tokyonight',
                path_display = { 'smart' },
                file_ignore_patterns = { '.git/' },
                layout_strategy = 'horizontal',
                layout_config = { prompt_position = 'top' },
                sorting_strategy = 'ascending',
            },
            pickers = {
                find_files = {
                    find_command = { 'rg', '--color=never', '--files', '--hidden', '--glob', '!**/.git/*' },
                },
            },
            extensions = {
                undo = {
                    side_by_side = true,
                    layout_strategy = 'vertical',
                },
            },
        },
    },
}
