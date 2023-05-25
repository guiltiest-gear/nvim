local opts = { noremap = true, silent = true }
local map = vim.api.nvim_set_keymap
-- Set space as my leader key
map('', '<Space>', '<Nop>', opts)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Open dashboard-nvim
map('n', '<leader>d', '<cmd>Dashboard<CR>', opts)

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

-- Toggleterm.nvim keymap
map('n', [[<C-\>]], '<cmd>ToggleTerm<CR>', opts)

-- Resize splits with arrow keys
map('n', '<M-l>', '<cmd>vertical resize +1<CR>', opts)
map('n', '<M-h>', '<cmd>vertical resize -1<CR>', opts)
map('n', '<M-k>', '<cmd>resize +1<CR>', opts)
map('n', '<M-j>', '<cmd>resize -1<CR>', opts)

-- Lazy keymap
map('n', '<leader>Ll', '<cmd>Lazy<CR>', opts)
map('n', '<leader>Lu', '<cmd>Lazy update<CR>', opts)
map('n', '<leader>Ls', '<cmd>Lazy sync<CR>', opts)
map('n', '<leader>LL', '<cmd>Lazy log<CR>', opts)
map('n', '<leader>Lc', '<cmd>Lazy clean<CR>', opts)
map('n', '<leader>Lp', '<cmd>Lazy profile<CR>', opts)

-- Move lines
map('n', '<A-j>', '<cmd>m .+1<cr>==', opts)
map('n', '<A-k>', '<cmd>m .-2<cr>==', opts)
map('i', '<A-j>', '<esc><cmd>m .+1<cr>==gi', opts)
map('i', '<A-k>', '<esc><cmd>m .-2<cr>==gi', opts)
map('v', '<A-j>', "<cmd>m '>+1<cr>gv=gv", opts)
map('v', '<A-k>', "<cmd>m '<-2<cr>gv=gv", opts)
