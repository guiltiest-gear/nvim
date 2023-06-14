return {
    -- satellite.nvim
    {
        'lewis6991/satellite.nvim',
        event = {
            'BufReadPost',
            'BufNewFile',
        },
        opts = {
            winblend = 0,
        },
    },

    -- nvim-notify
    {
        'rcarriga/nvim-notify',
        event = {
            'BufReadPost',
            'BufNewFile',
        },
        opts = {
            background_colour = '#000000',
        },
        config = function(_, opts)
            local notify = require('notify')
            notify.setup(opts)
            vim.notify = notify
        end,
    },

    -- dressing.nvim
    {
        'stevearc/dressing.nvim',
        init = function()
            vim.ui.select = function(...)
                require('lazy').load { plugins = { 'dressing.nvim' } }
                return vim.ui.select(...)
            end
            vim.ui.input = function(...)
                require('lazy').load { plugins = { 'dressing.nvim' } }
                return vim.ui.input(...)
            end
        end,
        lazy = true,
    },

    -- indent-blankline.nvim
    {
        'lukas-reineke/indent-blankline.nvim',
        dependencies = 'nvim-treesitter/nvim-treesitter',
        event = {
            'BufReadPost',
            'BufNewFile',
        },
        opts = {
            char = '▏',
            context_char = '▏',
            use_treesitter = true,
            show_first_indent_level = true,
            show_trailing_blankline_indent = false,
            show_current_context = true,
            show_current_context_start = true,
            filetype_exclude = {
                'help',
                'dashboard',
                'Trouble',
                'neogitstatus',
            },
            context_patterns = {
                'class',
                'return',
                'function',
                'method',
                '^if',
                '^while',
                'jsx_element',
                '^for',
                '^object',
                '^table',
                'block',
                'arguments',
                'if_statement',
                'else_clause',
                'jsx_element',
                'jsx_self_closing_element',
                'try_statement',
                'catch_clause',
                'import_statement',
                'operation_type',
            },
        },
    },

    -- nvim-ufo
    {
        'kevinhwang91/nvim-ufo',
        dependencies = 'kevinhwang91/promise-async',
        event = {
            'BufReadPost',
            'BufNewFile',
        },
        opts = {
            provider_selector = function(_, filetype, buftype)
                local function handleFallbackException(bufnr, err, providerName)
                    if type(err) == 'string' and err:match('UfoFallbackException') then
                        return require('ufo').getFolds(bufnr, providerName)
                    else
                        return require('promise').reject(err)
                    end
                end
                return (filetype == '' or buftype == 'nofile') and 'indent'
                    or function(bufnr)
                        return require('ufo')
                            .getFolds(bufnr, 'lsp')
                            :catch(function(err)
                                return handleFallbackException(bufnr, err, 'treesitter')
                            end)
                            :catch(function(err)
                                return handleFallbackException(bufnr, err, 'indent')
                            end)
                    end
            end,
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
}
