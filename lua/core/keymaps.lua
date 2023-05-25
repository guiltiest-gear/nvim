local opts = { noremap = true, silent = true }
local map = vim.api.nvim_set_keymap
-- Set space as my leader key
map('', '<Space>', '<Nop>', opts)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Open dashboard-nvim
map('n', '<leader>d', ':Dashboard<CR>', opts)

-- Better split navigation
map('n', '<C-h>', '<C-w>h', opts)
map('n', '<C-j>', '<C-w>j', opts)
map('n', '<C-k>', '<C-w>k', opts)
map('n', '<C-l>', '<C-w>l', opts)

-- Quit neovim
map('n', '<leader>Q', ':qa<CR>', opts)
map('n', '<leader>q', ':q<CR>', opts)

-- Quick write
map('n', '<leader>w', ':w<CR>', opts)

-- Toggleterm.nvim keymap
map('n', [[<C-\>]], ':ToggleTerm<CR>', opts)

-- Resize splits with arrow keys
map('n', '<M-l>', ':vertical resize +1<CR>', opts)
map('n', '<M-h>', ':vertical resize -1<CR>', opts)
map('n', '<M-k>', ':resize +1<CR>', opts)
map('n', '<M-j>', ':resize -1<CR>', opts)

-- Lazy keymap
map('n', '<leader>Ll', ':Lazy<CR>', opts)
map('n', '<leader>Lu', ':Lazy update<CR>', opts)
map('n', '<leader>Ls', ':Lazy sync<CR>', opts)
map('n', '<leader>LL', ':Lazy log<CR>', opts)
map('n', '<leader>Lc', ':Lazy clean<CR>', opts)
map('n', '<leader>Lp', ':Lazy profile<CR>', opts)

-- Move lines
map('n', '<A-j>', '<cmd>m .+1<cr>==', opts)
map('n', '<A-k>', '<cmd>m .-2<cr>==', opts)
map('i', '<A-j>', '<esc><cmd>m .+1<cr>==gi', opts)
map('i', '<A-k>', '<esc><cmd>m .-2<cr>==gi', opts)
map('v', '<A-j>', ":m '>+1<cr>gv=gv", opts)
map('v', '<A-k>', ":m '<-2<cr>gv=gv", opts)
