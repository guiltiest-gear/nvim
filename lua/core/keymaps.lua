local map = vim.keymap.set
-- Set space as my leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Better split navigation
map('n', '<C-h>', '<C-w>h', { desc = 'Go to left window', remap = true })
map('n', '<C-j>', '<C-w>j', { desc = 'Go to lower window', remap = true })
map('n', '<C-k>', '<C-w>k', { desc = 'Go to upper window', remap = true })
map('n', '<C-l>', '<C-w>l', { desc = 'Go to right window', remap = true })

-- Quit neovim
map('n', '<leader>qq', function()
  vim.cmd.q()
end, { desc = 'Quit the current file' })

-- Quick write
map('n', '<leader>w', function()
  vim.cmd.w()
end, { desc = 'Save the current file' })

-- Resize splits with arrow keys
map('n', '<C-Up>', '<cmd>resize +2<CR>', { desc = 'Increase window height' })
map('n', '<C-Down>', '<cmd>resize -2<CR>', { desc = 'Decrease window height' })
map('n', '<C-Left>', '<cmd>vertical resize -2<CR>', { desc = 'Decrease window width' })
map('n', '<C-Right>', '<cmd>vertical resize +2<CR>', { desc = 'Increase window width' })

-- Lazy keymap
map('n', '<leader>l', function()
  return require('lazy').home()
end, { desc = 'Open lazy.nvim' })

-- Better indenting
map('v', '<', '<gv')
map('v', '>', '>gv')

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map('n', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next search result' })
map('x', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next search result' })
map('o', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next search result' })
map('n', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Previous search result' })
map('x', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Previous search result' })
map('o', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Previous search result' })
