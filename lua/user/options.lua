local opt = vim.opt
local g = vim.g

-- Cursor highlighting
opt.cursorline = true
opt.cursorcolumn = true

-- Pane splitting
opt.splitright = true
opt.splitbelow = true

-- Searching
opt.smartcase = true
opt.hlsearch = true
opt.ignorecase = true
opt.incsearch = true

-- Auto indent
opt.autoindent = true

-- Make terminal support truecolor
opt.termguicolors = true

-- Make neovim use the system clipboard
opt.clipboard = 'unnamedplus'

-- Disable old vim status
opt.showmode = false

-- Set relative line numbers
opt.number = true
opt.relativenumber = true
opt.numberwidth = 2

-- Tab config
opt.expandtab = true
opt.smarttab = true
opt.smartindent = true
opt.shiftwidth = 4
opt.tabstop = 4

-- Code folding
opt.foldenable = true
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldcolumn = '1'

-- Decrease update time
opt.timeoutlen = 500
opt.updatetime = 200

-- Disable swapfile
opt.swapfile = false

-- Enable persistent undo
opt.undofile = true

-- cmp config
opt.completeopt = { "menuone", "noselect" }

-- Always show tabline
opt.showtabline = 0

-- Disable mouse support
opt.mouse = {}

-- Scrolloff
opt.scrolloff = 5
opt.sidescrolloff = 5

-- Disable wrapping
opt.wrap = false

-- Enable list
opt.list = true

-- Fill chars
opt.fillchars = [[vert:|,horiz:-,eob: ]]

-- Enable lazy redraw for performance
opt.lazyredraw = true

-- Disable certain builtins
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
g.loaded_netrwSettings = 1
g.loaded_netrwFileHandlers = 1
g.loaded_gzip = 1
g.loaded_zip = 1
g.loaded_zipPlugin = 1
g.loaded_tar = 1
g.loaded_tarPlugin = 1
g.loaded_vimball = 1
g.loaded_vimballPlugin = 1
g.loaded_2html_plugin = 1
g.loaded_logipat = 1
g.loaded_getscript = 1
g.loaded_getscriptPlugin = 1

-- Disable provider warnings in the healthcheck
local disabled_providers = {
    "node",
    "perl",
    "python3"
}

for _, provider in pairs(disabled_providers) do
    g["loaded_" .. provider] = 0
end
