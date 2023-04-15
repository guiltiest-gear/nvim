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
        config = function()
            local null_ls = require('null-ls')

            -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
            local formatting = null_ls.builtins.formatting
            -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
            local diagnostics = null_ls.builtins.diagnostics
            -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/code_actions
            -- local code_actions = null_ls.builtins.code_actions
            null_ls.setup({
                debug = false,
                sources = {
                    formatting.stylua,
                    formatting.markdownlint,
                    diagnostics.markdownlint,
                    diagnostics.luacheck,
                    -- code_actions.gitsigns
                },
            })
        end,
    },
}
