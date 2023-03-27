local status_ok, toggle = pcall(require, "relative-toggle")
if not status_ok then
    return
end

toggle.setup()
