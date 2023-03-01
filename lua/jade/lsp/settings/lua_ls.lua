local navic = require("nvim-navic")

require 'lspconfig'.lua_ls.setup {
    on_attach = function(client, bufnr)
        navic.attach(client, bufnr)
    end,
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" }
            },
            workspace = {
                library = {
                    [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                    [vim.fn.stdpath "config" .. "/lua"] = true
                }
            },
            telemetry = {
                enable = false
            }
        }
    }
}
