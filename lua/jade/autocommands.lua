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

-- Disable line numbers in the terminal
autocmd('TermOpen', {
    pattern = '',
    command = 'setlocal nonumber norelativenumber'
})

-- Automatically rebalance windows on vim resize
autocmd('VimResized', {
    pattern = '',
    command = 'wincmd ='
})

-- Automatically run :PackerSync whenever plugins.lua is modified
autocmd('BufWritePost', {
    pattern = 'plugins.lua',
    command = 'source <afile> | PackerSync'
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
