-- Define local variables
local autocmd = vim.api.nvim_create_autocmd
---@param name string
---@return integer
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

-- Close various file types with just <q>
autocmd('FileType', {
  group = augroup('close_with_q'),
  pattern = { 'help', 'lspinfo', 'checkhealth', 'qf', 'query', 'notify' },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', vim.cmd.close, { buffer = event.buf, silent = true })
  end,
})

-- Fix manpage bugs
autocmd('FileType', {
  group = augroup('man_bugfixes'),
  pattern = { 'man' },
  callback = function(event)
    vim.opt_local.signcolumn = 'no'
    vim.bo[event.buf].buflisted = false
  end,
})

-- Auto create dir when saving a file where some intermediate directory does not exist
autocmd('BufWritePre', {
  group = augroup('auto_create_dir'),
  callback = function(event)
    if event.match:match('^%w%w+:[\\/][\\/]') then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ':p:h'), 'p')
  end,
})

-- Check for spelling in text filetypes and enable wrapping
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
    if vim.opt.buftype:get() ~= 'nofile' then
      vim.cmd.checktime()
    end
  end,
})

-- Toggle relative numbers based on certain events
autocmd({ 'BufEnter', 'InsertLeave', 'CmdlineLeave', 'WinEnter' }, {
  group = augroup('auto_relative_numbers_on'),
  callback = function()
    if vim.opt.number:get() and vim.api.nvim_get_mode() ~= 'i' then
      vim.opt.relativenumber = true
    end
  end,
})

autocmd({ 'BufLeave', 'InsertEnter', 'CmdlineEnter', 'WinLeave' }, {
  group = augroup('auto_relative_numbers_off'),
  callback = function()
    if vim.opt.number:get() then
      vim.opt.relativenumber = false
      vim.cmd.redraw()
    end
  end,
})

-- Disable conceallevel for json filetypes
autocmd('FileType', {
  group = augroup('json_conceal'),
  pattern = { 'json', 'jsonc', 'json5' },
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
})

-- Fix luasnip session logic to avoid random jumps with tab. Copied from:
-- https://github.com/L3MON4D3/LuaSnip/issues/258#issuecomment-1429989436
autocmd('ModeChanged', {
  group = augroup('fix_luasnip_session_logic'),
  pattern = '*',
  callback = function()
    if
      ((vim.v.event.old_mode == 's' and vim.v.event.new_mode == 'n') or vim.v.event.old_mode == 'i')
      and require('luasnip').session.current_nodes[vim.api.nvim_get_current_buf()]
      and not require('luasnip').session.jump_active
    then
      require('luasnip').unlink_current()
    end
  end,
})
