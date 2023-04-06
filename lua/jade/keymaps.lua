local opts = { noremap = true, silent = true }
local map = vim.api.nvim_set_keymap
-- Set comma as my leader key
map("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Better split navigation
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- Quit neovim
map("n", "<leader>q", ":qa<CR>", opts)

-- Quick write
map("n", "<leader>w", ":w<CR>", opts)

-- Resize splits with arrow keys
map("n", "<M-l>", ":vertical resize +1<CR>", opts)
map("n", "<M-h>", ":vertical resize -1<CR>", opts)
map("n", "<M-j>", ":resize +1<CR>", opts)
map("n", "<M-k>", ":resize -1<CR>", opts)

-- Buffer navigation
map("n", "<leader>bp", ":bprev<CR>", opts)
map("n", "<leader>bn", ":bnext<CR>", opts)
map("n", "<leader>bf", ":bfirst<CR>", opts)
map("n", "<leader>bl", ":blast<CR>", opts)

-- Telescope keybindings
map("n", "<leader>ff", ":Telescope find_files<CR>", opts)
map("n", "<leader>fg", ":Telescope live_grep<CR>", opts)
map("n", "<leader>fb", ":Telescope buffers<CR>", opts)
map("n", "<leader>fh", ":Telescope help_tags<CR>", opts)
map("n", "<leader>fm", ":Telescope man_pages<CR>", opts)
map("n", "<leader>fr", ":Telescope oldfiles<CR>", opts)
map("n", "<leader>fR", ":Telescope registers<CR>", opts)
map("n", "<leader>fk", ":Telescope keymaps<CR>", opts)
map("n", "<leader>fc", ":Telescope commands<CR>", opts)

-- Lazy keymap
map("n", "<leader>L", ":Lazy<CR>", opts)

-- Alias replace all with S
map("n", "S", ":%s//g<Left><Left>", { noremap = true })

-- Nvim tree
map("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

-- bufdelete.nvim keybind
map("n", "<leader>bK", ":Bdelete!<CR>", opts)
map("n", "<leader>bk", ":Bdelete<CR>", opts)

-- vim-illuminate
map("n", "<leader>it", ":IlluminateToggle<CR>", opts)
map("n", "<leader>ib", ":IlluminateToggleBuf<CR>", opts)

-- Git
map("n", "<leader>gg", ":Neogit<CR>", opts)
map("n", "<leader>gj", ":lua require 'gitsigns'.next_hunk()<CR>", opts)
map("n", "<leader>gk", ":lua require 'gitsigns'.prev_hunk()<CR>", opts)
map("n", "<leader>gl", ":lua require 'gitsigns'.blame_line()<CR>", opts)
map("n", "<leader>gp", ":lua require 'gitsigns'.preview_hunk()<CR>", opts)
map("n", "<leader>gr", ":lua require 'gitsigns'.reset_hunk()<CR>", opts)
map("n", "<leader>gR", ":lua require 'gitsigns'.reset_buffer()<CR>", opts)
map("n", "<leader>gs", ":lua require 'gitsigns'.stage_hunk()<CR>", opts)
map("n", "<leader>gu", ":lua require 'gitsigns'.undo_stage_hunk()<CR>", opts)
map("n", "<leader>go", ":Telescope git_status<CR>", opts)
map("n", "<leader>gb", ":Telescope git_branches<CR>", opts)
map("n", "<leader>gc", ":Telescope git_commits<CR>", opts)
map("n", "<leader>gd", ":Gitsigns diffthis HEAD<CR>", opts)

-- Toggle twilight
map("n", "<leader>t", ":Twilight<CR>", opts)

-- Jump back to alpha
map("n", "<leader>a", ":Alpha<CR>", opts)

-- Hop keymaps
map("n", "<leader>hw", ":HopWord<CR>", opts)
map("n", "<leader>hc", ":HopChar1<CR>", opts)
map("n", "<leader>hC", ":HopChar2<CR>", opts)
map("n", "<leader>hp", ":HopPattern<CR>", opts)
map("n", "<leader>hl", ":HopLine<CR>", opts)
map("n", "<leader>ha", ":HopAnywhere<CR>", opts)

-- nvim-hlslens keymaps
map("n", "n", [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]], opts)
map("n", "N", [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]], opts)
map("n", "*", [[*<Cmd>lua require('hlslens').start()<CR>]], opts)
map("n", "#", [[#<Cmd>lua require('hlslens').start()<CR>]], opts)
map("n", "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]], opts)
map("n", "g#", [[g#<Cmd>lua require('hlslens').start()<CR>]], opts)

-- windows.nvim keymaps
map("n", "<C-w>z", ":WindowsMaximize<CR>", opts)
map("n", "<C-w>_", ":WindowsMaximizeVertically<CR>", opts)
map("n", "<C-w>|", ":WindowsMaximizeHorizontally<CR>", opts)
map("n", "<C-w>=", ":WindowsEqualize<CR>", opts)

-- nvim-genghis keymaps
map("n", "<leader>Gn", ":New<CR>", opts)
map("n", "<leader>Gd", ":Duplicate<CR>", opts)
map("n", "<leader>GN", ":NewFromSelection<CR>", opts)
map("n", "<leader>Gr", ":Rename<CR>", opts)
map("n", "<leader>Gm", ":Move<CR>", opts)
map("n", "<leader>Gf", ":CopyFilename<CR>", opts)
map("n", "<leader>GF", ":CopyFilepath<CR>", opts)
map("n", "<leader>Gx", ":Chmodx<CR>", opts)

-- trouble.nvim keymaps
map("n", "<leader>xx", ":TroubleToggle<CR>", opts)
map("n", "<leader>xw", ":TroubleToggle workspace_diagnostics<CR>", opts)
map("n", "<leader>xd", ":TroubleToggle document_diagnostics<CR>", opts)
map("n", "<leader>xq", ":TroubleToggle quickfix<CR>", opts)
map("n", "<leader>xl", ":TroubleToggle loclist<CR>", opts)
map("n", "<leader>xr", ":TroubleToggle lsp_references<CR>", opts)
