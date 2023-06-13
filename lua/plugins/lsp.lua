return {
    -- mason.nvim
    {
        'williamboman/mason.nvim',
        build = ':MasonUpdate',
        cmd = 'Mason',
        opts = {
            ui = {
                icons = {
                    package_installed = '',
                    package_pending = '',
                    package_uninstalled = '',
                },
            },
        },
    },

    -- nvim-lspconfig
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'williamboman/mason.nvim',
            {
                'williamboman/mason-lspconfig.nvim',
                opts = {
                    ensure_installed = {
                        'lua_ls',
                        'clangd',
                        'marksman',
                    },
                },
            },
            {
                'jay-babu/mason-null-ls.nvim',
                opts = {
                    ensure_installed = {
                        'stylua',
                        'markdownlint',
                        'luacheck',
                    },
                },
            },
        },
        keys = {
            {
                'gd',
                function()
                    return require('telescope.builtin').lsp_definitions()
                end,
                desc = 'Goto Definition',
            },
            {
                'gr',
                function()
                    return require('telescope.builtin').lsp_references()
                end,
                desc = 'References',
            },
            {
                'gD',
                vim.lsp.buf.declaration,
                desc = 'Goto Declaration',
            },
            {
                'gI',
                function()
                    return require('telescope.builtin').lsp_implementations()
                end,
                desc = 'Goto Implementation',
            },
            {
                'gy',
                function()
                    return require('telescope.builtin').lsp_type_definitions()
                end,
                desc = 'Goto T[y]pe Definition',
            },
            {
                'K',
                vim.lsp.buf.hover,
                desc = 'Hover',
            },
            {
                'gK',
                vim.lsp.buf.signature_help,
                desc = 'Signature Help',
            },
        },
        event = {
            'BufReadPre',
            'BufNewFile',
        },
        config = function()
            local navic = require('nvim-navic')
            local lspconfig = require('lspconfig')
            lspconfig.clangd.setup {
                on_attach = function(client, bufnr)
                    navic.attach(client, bufnr)
                end,
            }
            lspconfig.lua_ls.setup {
                on_attach = function(client, bufnr)
                    navic.attach(client, bufnr)
                end,
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { 'vim' },
                        },
                        workspace = {
                            library = {
                                [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                                [vim.fn.stdpath('config') .. '/lua'] = true,
                            },
                        },
                        telemetry = {
                            enable = false,
                        },
                    },
                },
            }
            lspconfig.marksman.setup {
                on_attach = function(client, bufnr)
                    navic.attach(client, bufnr)
                end,
            }
        end,
    },

    -- null-ls.nvim
    {
        'jose-elias-alvarez/null-ls.nvim',
        dependencies = 'williamboman/mason.nvim',
        event = {
            'BufReadPre',
            'BufNewFile',
        },
        opts = function()
            local nls = require('null-ls')
            return {
                sources = {
                    nls.builtins.formatting.stylua,
                    nls.builtins.formatting.markdownlint,
                    nls.builtins.diagnostics.markdownlint,
                    nls.builtins.diagnostics.luacheck,
                },
            }
        end,
    },

    -- fidget.nvim
    {
        'j-hui/fidget.nvim',
        event = 'LspAttach',
        -- NOTE: Keep tag option until further notice: https://shorta.link/wkrANvwU
        tag = 'legacy',
        opts = {
            window = {
                blend = 0,
            },
        },
    },

    -- lsp_lines.nvim
    {
        'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
        event = 'LspAttach',
        init = function()
            vim.diagnostic.config {
                virtual_text = false,
                virtual_lines = {
                    highlight_whole_line = false,
                },
            }
        end,
        keys = {
            {
                '<leader>L',
                function()
                    return require('lsp_lines').toggle()
                end,
                desc = 'Toggle lsp_lines',
            },
        },
        config = true,
    },

    -- symbols-outline.nvim
    {
        'simrat39/symbols-outline.nvim',
        keys = { { '<leader>o', '<cmd>SymbolsOutline<CR>', desc = 'Open symbols-outline' } },
        config = true,
    },

    -- nvim-navic
    {
        'SmiteshP/nvim-navic',
        event = 'LspAttach',
        opts = {
            icons = {
                File = ' ',
                Module = ' ',
                Namespace = ' ',
                Package = ' ',
                Class = ' ',
                Method = ' ',
                Property = ' ',
                Field = ' ',
                Constructor = ' ',
                Enum = ' ',
                Interface = ' ',
                Function = ' ',
                Variable = ' ',
                Constant = ' ',
                String = ' ',
                Number = ' ',
                Boolean = ' ',
                Array = ' ',
                Object = ' ',
                Key = ' ',
                Null = ' ',
                EnumMember = ' ',
                Struct = ' ',
                Event = ' ',
                Operator = ' ',
                TypeParameter = ' ',
            },
        },
    },
}
