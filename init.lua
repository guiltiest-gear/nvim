-- Enable experimental loader
vim.loader.enable()

-- Use pcall to load the modules
---@param module string
---@return unknown|nil
local function safe_require(module)
  ---@type boolean, unknown
  local success, loaded = pcall(require, module)
  if success then
    return loaded
  end
  vim.api.nvim_echo({ { 'Error loading' .. module .. '\n' } }, true, {})
end

-- Load the files
safe_require('core.options')
safe_require('core.keymaps')
safe_require('core.autocommands')
safe_require('core.bootstrap')
