-- Define local variables
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Remove trailing whitespaces
autocmd('BufWritePre', {
    pattern = '',
    command = '%s/\\s\\+$//e'
})

-- Highlight text on yank
augroup('YankHighlight', { clear = true })
autocmd('TextYankPost', {
    group = 'YankHighlight',
    callback = function()
        vim.highlight.on_yank({ higroup = 'IncSearch', timeout = '700' })
    end
})

-- Automatically rebalance windows on vim resize
autocmd('VimResized', {
    pattern = '',
    command = 'wincmd ='
})

-- close man and help with just <q>
autocmd('FileType', {
    pattern = {
        "help",
        "man",
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
    end,
})
