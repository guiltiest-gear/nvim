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

    -- windows.nvim
    {
        'anuvyklack/windows.nvim',
        dependencies = {
            'anuvyklack/animation.nvim',
            'anuvyklack/middleclass',
        },
        init = function()
            vim.o.winwidth = 10
            vim.o.winminwidth = 10
            vim.o.equalalways = false
        end,
        event = 'WinNew',
        keys = {
            { '<C-w>z', '<cmd>WindowsMaximize<CR>' },
            { '<C-w>_', '<cmd>WindowsMaximizeVertically<CR>' },
            { '<C-w>|', '<cmd>WindowsMaximizeHorizontally<CR>' },
            { '<C-w>=', '<cmd>WindowsEqualize<CR>' },
        },
        config = true,
    },

    -- lualine.nvim
    {
        'nvim-lualine/lualine.nvim',
        dependencies = 'nvim-tree/nvim-web-devicons',
        event = {
            'BufReadPost',
            'BufNewFile',
        },
        opts = {
            options = {
                theme = 'tokyonight',
                component_separators = { left = '', right = '' },
                section_separators = { left = '', right = '' },
                disabled_filetypes = {
                    'mason',
                    'dashboard',
                    'NeogitStatus',
                    'NeogitCommitView',
                    'NeogitPopup',
                    'NeogitConsole',
                },
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = {
                    'branch',
                    'diff',
                    {
                        'diagnostics',
                        sources = { 'nvim_lsp', 'nvim_diagnostic' },
                    },
                },
                lualine_c = {
                    'filename',
                    {
                        function()
                            return require('nvim-navic').get_location()
                        end,
                        cond = function()
                            return require('nvim-navic').is_available()
                        end,
                    },
                },
                lualine_x = {
                    'fileformat',
                    'filetype',
                },
                lualine_y = { 'progress' },
                lualine_z = { 'location' },
            },
            extensions = {
                'man',
                'toggleterm',
                'neo-tree',
                'symbols-outline',
                'trouble',
                'lazy',
            },
        },
    },

    -- dashboard-nvim
    {
        'nvimdev/dashboard-nvim',
        dependencies = 'nvim-tree/nvim-web-devicons',
        event = 'VimEnter',
        keys = {
            { '<leader>d', '<cmd>Dashboard<CR>', desc = 'Open dashboard-nvim' },
        },
        opts = {
            theme = 'doom',
            config = {
                header = {
                    '                                   ',
                    '                                   ',
                    '                                   ',
                    '                                   ',
                    '                                   ',
                    '                                   ',
                    '   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣿⣶⣿⣦⣼⣆          ',
                    '    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       ',
                    '          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄     ',
                    '           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄    ',
                    '          ⢠⣿⣿⣿⠈    ⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   ',
                    '   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  ',
                    '  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   ',
                    ' ⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  ',
                    ' ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇ ⠛⠻⢷⣄ ',
                    '      ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     ',
                    '       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃     ',
                    '                                   ',
                    '                                   ',
                    '                                   ',
                    '                                   ',
                    '                                   ',
                    '                                   ',
                },
                center = {
                    {
                        icon = '󰈞 ',
                        icon_hl = 'Title',
                        desc = 'Find file',
                        desc_hl = 'String',
                        key = 'f',
                        key_hl = 'Number',
                        action = ':lua require("telescope.builtin").find_files()',
                    },
                    {
                        icon = ' ',
                        icon_hl = 'Title',
                        desc = 'New file',
                        desc_hl = 'String',
                        key = 'e',
                        key_hl = 'Number',
                        action = ':ene | startinsert',
                    },
                    {
                        icon = '󰄉 ',
                        icon_hl = 'Title',
                        desc = 'Recently used files                        ',
                        desc_hl = 'String',
                        key = 'r',
                        key_hl = 'Number',
                        action = ':lua require("telescope.builtin").oldfiles()',
                    },
                    {
                        icon = '󰊄 ',
                        icon_hl = 'Title',
                        desc = 'Find text',
                        desc_hl = 'String',
                        key = 'w',
                        key_hl = 'Number',
                        action = ':lua require("telescope.builtin").live_grep()',
                    },
                    {
                        icon = ' ',
                        icon_hl = 'Title',
                        desc = 'Configuration',
                        desc_hl = 'String',
                        key = 'c',
                        key_hl = 'Number',
                        action = ':cd ~/.config/nvim | e ~/.config/nvim/lua/plugins/init.lua',
                    },
                    {
                        icon = ' ',
                        icon_hl = 'Title',
                        desc = 'Update plugins',
                        desc_hl = 'String',
                        key = 'u',
                        key_hl = 'Number',
                        action = ':lua require("lazy").update()',
                    },
                    {
                        icon = ' ',
                        icon_hl = 'Title',
                        desc = 'Mason',
                        desc_hl = 'String',
                        key = 'm',
                        key_hl = 'Number',
                        action = ':Mason',
                    },
                    {
                        icon = ' ',
                        icon_hl = 'Title',
                        desc = 'NeoGit',
                        desc_hl = 'String',
                        key = 'g',
                        key_hl = 'Number',
                        action = ':lua require("neogit").open()',
                    },
                    {
                        icon = ' ',
                        icon_hl = 'Title',
                        desc = 'Quit Neovim',
                        desc_hl = 'String',
                        key = 'q',
                        key_hl = 'Number',
                        action = ':qa',
                    },
                },
                footer = {},
            },
        },
    },
}
