-- Install lazy.nvim automatically
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local opts = {
  git = { log = { '--since=3 days ago' }, timeout = 60 },
  ui = { custom_keys = { false }, backdrop = 100 },
  install = { colorscheme = { 'tokyonight' } },
  checker = { enabled = true },
  diff = {
    cmd = 'terminal_git',
    -- cmd = 'git',
  },
  performance = {
    rtp = {
      disabled_plugins = {
        'gzip',
        'netrwPlugin',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
        'rplugin',
        'matchparen',
        'matchit',
      },
    },
  },
}

-- Load the plugins and options
require('lazy').setup('plugins', opts)
