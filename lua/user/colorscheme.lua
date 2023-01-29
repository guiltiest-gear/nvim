local status_ok, tokyonight = pcall(require, "tokyonight")
if not status_ok then
    return
end

tokyonight.setup {
    style = "night",
    transparent = true,
    lualine_bold = true
}

vim.cmd[[colorscheme tokyonight]]
