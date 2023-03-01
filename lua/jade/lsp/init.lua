local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
    return
end

require 'jade.lsp.mason'
require 'jade.lsp.mason-lspconfig'
require 'jade.lsp.null-ls'
require 'jade.lsp.settings.lua_ls'
require 'jade.lsp.settings.marksman'
require 'jade.lsp.settings.clangd'
