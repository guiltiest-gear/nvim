return {
    -- mason.nvim
    {
        'williamboman/mason.nvim',
        build = ':MasonUpdate',
        dependencies = {
            'williamboman/mason-lspconfig.nvim',
            'neovim/nvim-lspconfig',
            'stevearc/dressing.nvim',
        },
        cmd = 'Mason',
        opts = {
            ui = {
                icons = {
                    package_installed = '✓',
                    package_pending = '➜',
                    package_uninstalled = '✗',
                },
            },
        },
    },

    -- mason-lspconfig
    {
        'williamboman/mason-lspconfig.nvim',
        event = 'LspAttach',
        opts = {
            ensure_installed = {
                'lua_ls',
                'clangd',
                'marksman',
            },
        },
    },

    -- nvim-lspconfig
    {
        'neovim/nvim-lspconfig',
        dependencies = 'williamboman/mason-lspconfig.nvim',
        event = 'LspAttach',
        config = function()
            local navic = require('nvim-navic')
            local lspconfig = require('lspconfig')
            lspconfig.clangd.setup({
                on_attach = function(client, bufnr)
                    navic.attach(client, bufnr)
                end,
            })
            lspconfig.lua_ls.setup({
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
            })
            lspconfig.marksman.setup({
                on_attach = function(client, bufnr)
                    navic.attach(client, bufnr)
                end,
            })
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
                }
            }
        end,
    },
}
