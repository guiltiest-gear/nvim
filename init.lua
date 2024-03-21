-- Enable experimental loader
vim.loader.enable()

-- Use pcall to load the modules
---@param module string
---@return any
local function safe_require(module)
  ---@type boolean, any
  local success, loaded = pcall(require, module)
  if success then
    return loaded
  end
  vim.notify('Error loading ' .. module, vim.log.levels.ERROR)
end

-- Load the files
safe_require('core.options')
safe_require('core.keymaps')
safe_require('core.autocommands')
safe_require('core.bootstrap')
