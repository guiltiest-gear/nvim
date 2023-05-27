return {
    'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
    event = 'LspAttach',
    init = function()
        vim.diagnostic.config {
            virtual_text = false,
        }
    end,
    keys = {
        {
            '<leader>l',
            function()
                return require('lsp_lines').toggle()
            end,
            desc = 'Toggle lsp_lines',
        },
    },
    config = true,
}
