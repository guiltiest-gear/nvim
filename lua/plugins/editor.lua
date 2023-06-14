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
}
