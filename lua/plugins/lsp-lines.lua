return {
    'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
    event = 'LspAttach',
    keys = {
        {
            '<leader>l',
            function()
                return require('lsp_lines').toggle()
            end,
            { desc = 'Toggle lsp_lines' },
        },
    },
    config = function()
        local lsp_lines = require('lsp_lines')
        lsp_lines.setup()
        vim.diagnostic.config {
            virtual_text = false,
        }
    end,
}
