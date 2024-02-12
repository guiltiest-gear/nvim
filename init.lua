-- Safely require files
local function safeRequire(module)
  local success, loadedModule = pcall(require, module)
  if success then
    return loadedModule
  end
  vim.cmd.echo('Error loading ' .. module)
end

safeRequire('core.options')
safeRequire('core.keymaps')
safeRequire('core.autocommands')
safeRequire('core.bootstrap')
