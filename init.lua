-- Enable experimental loader
vim.loader.enable()

-- Load all the files
require('core.options')
require('core.keymaps')
require('core.autocommands')
require('core.bootstrap')
