local o = vim.o
local status_ok, windows = pcall(require, "windows")
if not status_ok then
    return
end

o.winwidth = 10
o.winminwidth = 10
o.equalalways = false
windows.setup()
