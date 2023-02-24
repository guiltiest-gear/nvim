local navic = require("nvim-navic")

require 'lspconfig'.clangd.setup {
    on_attach = function(client, bufnr)
        navic.attach(client, bufnr)
    end
}
