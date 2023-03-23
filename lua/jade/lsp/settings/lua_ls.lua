require 'lspconfig'.lua_ls.setup {
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
