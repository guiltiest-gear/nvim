local status_ok, colorful_winsep = pcall(require, "colorful-winsep")
if not status_ok then
    return
end

colorful_winsep.setup()
