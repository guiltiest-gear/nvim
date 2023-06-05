local opts = { noremap = true, silent = true }
local map = vim.api.nvim_set_keymap
-- Set space as my leader key
map('', '<Space>', '<Nop>', opts)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Better split navigation
map('n', '<C-h>', '<C-w>h', opts)
map('n', '<C-j>', '<C-w>j', opts)
map('n', '<C-k>', '<C-w>k', opts)
map('n', '<C-l>', '<C-w>l', opts)

-- Quit neovim
map('n', '<leader>Q', '<cmd>qa<CR>', opts)
map('n', '<leader>q', '<cmd>q<CR>', opts)

-- Quick write
map('n', '<leader>w', '<cmd>w<CR>', opts)

-- Resize splits with arrow keys
map('n', '<M-l>', '<cmd>vertical resize +1<CR>', opts)
map('n', '<M-h>', '<cmd>vertical resize -1<CR>', opts)
map('n', '<M-k>', '<cmd>resize +1<CR>', opts)
map('n', '<M-j>', '<cmd>resize -1<CR>', opts)

-- Lazy keymap
vim.keymap.set('n', '<leader>ll', function()
    return require('lazy').home()
end)
vim.keymap.set('n', '<leader>lu', function()
    return require('lazy').update()
end)
vim.keymap.set('n', '<leader>ls', function()
    return require('lazy').sync()
end)
vim.keymap.set('n', '<leader>lL', function()
    return require('lazy').log()
end)
vim.keymap.set('n', '<leader>lc', function()
    return require('lazy').clean()
end)
vim.keymap.set('n', '<leader>lp', function()
    return require('lazy').profile()
end)

-- Move lines
map('n', '<A-j>', '<cmd>m .+1<cr>==', opts)
map('n', '<A-k>', '<cmd>m .-2<cr>==', opts)
map('i', '<A-j>', '<esc><cmd>m .+1<cr>==gi', opts)
map('i', '<A-k>', '<esc><cmd>m .-2<cr>==gi', opts)
map('v', '<A-j>', "<cmd>m '>+1<cr>gv=gv", opts)
map('v', '<A-k>', "<cmd>m '<-2<cr>gv=gv", opts)
