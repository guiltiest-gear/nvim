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

-- Buffer navigation
map('n', '<S-h>', ':BufferLineCyclePrev<CR>', opts)
map('n', '<S-l>', ':BufferLineCycleNext<CR>', opts)
map('n', '[b', ':BufferLineCyclePrev<CR>', opts)
map('n', ']b', ':BufferLineCycleNext<CR>', opts)
map('n', '<Tab>', ':BufferLineCycleNext<CR>', opts)
map('n', '<S-Tab>', ':BufferLineCyclePrev<CR>', opts)

-- Lazy keymap
map('n', '<leader>Ll', ':Lazy<CR>', opts)
map('n', '<leader>Lu', ':Lazy update<CR>', opts)
map('n', '<leader>Ls', ':Lazy sync<CR>', opts)
map('n', '<leader>LL', ':Lazy log<CR>', opts)
map('n', '<leader>Lc', ':Lazy clean<CR>', opts)
map('n', '<leader>Lp', ':Lazy profile<CR>', opts)

-- vim-illuminate
map('n', '<leader>it', ':IlluminateToggle<CR>', opts)
map('n', '<leader>ib', ':IlluminateToggleBuf<CR>', opts)

-- nvim-hlslens keymaps
map('n', 'n', [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]], opts)
map('n', 'N', [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]], opts)
map('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], opts)
map('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], opts)
map('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], opts)
map('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], opts)

-- windows.nvim keymaps
map('n', '<C-w>z', ':WindowsMaximize<CR>', opts)
map('n', '<C-w>_', ':WindowsMaximizeVertically<CR>', opts)
map('n', '<C-w>|', ':WindowsMaximizeHorizontally<CR>', opts)
map('n', '<C-w>=', ':WindowsEqualize<CR>', opts)

-- trouble.nvim keymaps
map('n', '<leader>xx', ':TroubleToggle<CR>', opts)
map('n', '<leader>xw', ':TroubleToggle workspace_diagnostics<CR>', opts)
map('n', '<leader>xd', ':TroubleToggle document_diagnostics<CR>', opts)
map('n', '<leader>xq', ':TroubleToggle quickfix<CR>', opts)
map('n', '<leader>xl', ':TroubleToggle loclist<CR>', opts)
map('n', '<leader>xr', ':TroubleToggle lsp_references<CR>', opts)

-- Move lines
map('n', '<A-j>', '<cmd>m .+1<cr>==', opts)
map('n', '<A-k>', '<cmd>m .-2<cr>==', opts)
map('i', '<A-j>', '<esc><cmd>m .+1<cr>==gi', opts)
map('i', '<A-k>', '<esc><cmd>m .-2<cr>==gi', opts)
map('v', '<A-j>', ":m '>+1<cr>gv=gv", opts)
map('v', '<A-k>', ":m '<-2<cr>gv=gv", opts)
