return {
    'nvim-tree/nvim-tree.lua',
    dependencies = 'nvim-tree/nvim-web-devicons',
    cmd = 'NvimTreeToggle',
    opts = {
        hijack_netrw = true,
        diagnostics = {
            enable = true,
            show_on_dirs = true,
            icons = {
                hint = '',
                info = '',
                warning = '',
                error = '',
            }
        },
        renderer = {
            root_folder_modifier = ':t'
        }
    }
}
