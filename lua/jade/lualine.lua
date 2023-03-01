local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
    return
end

local navic = require("nvim-navic")

lualine.setup {
    options = {
        icons_enabled = true,
        theme = 'tokyonight',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = { "alpha", "packer", "mason", "NvimTree" },
        always_divide_middle = true,
        globalstatus = true
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff' },
        lualine_c = {
            { 'filename' },
            { navic.get_location, cond = navic.is_available }
        },
        lualine_x = { 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
    }
}
