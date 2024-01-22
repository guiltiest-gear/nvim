-- Define local variables
local autocmd = vim.api.nvim_create_autocmd
local function augroup(name)
  return vim.api.nvim_create_augroup(name, { clear = true })
end

-- Remove trailing whitespaces
autocmd('BufWritePre', { group = augroup('trailing_space'), command = '%s/\\s\\+$//e' })

-- Highlight text on yank
autocmd('TextYankPost', {
  group = augroup('highlight_yank'),
  callback = function()
    vim.highlight.on_yank({ higroup = 'IncSearch', timeout = '700' })
  end,
})

-- Automatically rebalance windows on vim resize
autocmd('VimResized', { group = augroup('resize_splits'), command = 'tabdo wincmd =' })

-- Never insert line as a comment when using 'o' to enter insert mode
autocmd('BufWinEnter', { group = augroup('no_comment_on_o'), command = 'setlocal formatoptions-=o' })

-- Close man and help with just <q>
autocmd('FileType', {
  group = augroup('close_with_q'),
  pattern = { 'help', 'man', 'lspinfo', 'checkhealth', 'qf', 'query', 'notify' },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = event.buf, silent = true })
  end,
})

-- Auto create dir when saving a file where some intermediate directory does not exist
autocmd('BufWritePre', {
  group = augroup('auto_create_dir'),
  callback = function(event)
    if event.match:match('^%w%w+://') then
      return
    end
    local file = vim.loop.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ':p:h'), 'p')
  end,
})

-- Check for spelling in text filetypes and enable wrapping, and set gj and gk keymaps
autocmd('FileType', {
  group = augroup('wrap_spell'),
  pattern = { 'gitcommit', 'markdown', 'text', 'NeogitCommitMessage' },
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.wrap = true
  end,
})

-- Check if the file needs to be reloaded when it's changed
autocmd({ 'FocusGained', 'TermClose', 'TermLeave' }, {
  group = augroup('checktime'),
  callback = function()
    -- Skip checktime if the buffer type is nofile
    if vim.o.buftype ~= 'nofile' then
      vim.cmd.checktime()
    end
  end,
})

-- Toggle relative numbers based on certain events
autocmd({ 'BufEnter', 'FocusGained', 'InsertLeave', 'CmdlineLeave', 'WinEnter' }, {
  group = augroup('auto_relative_numbers_on'),
  pattern = '*',
  callback = function()
    if vim.o.nu and vim.api.nvim_get_mode() ~= 'i' then
      vim.opt.relativenumber = true
    end
  end,
})

autocmd({ 'BufLeave', 'FocusLost', 'InsertEnter', 'CmdlineEnter', 'WinLeave' }, {
  group = augroup('auto_relative_numbers_off'),
  pattern = '*',
  callback = function()
    if vim.o.nu then
      vim.opt.relativenumber = false
      vim.cmd.redraw()
    end
  end,
})

-- Disable conceallevel for json filetypes
autocmd({ 'FileType' }, {
  group = augroup('json_conceal'),
  pattern = { 'json', 'jsonc', 'json5' },
  callback = function()
    vim.wo.conceallevel = 0
  end,
})
