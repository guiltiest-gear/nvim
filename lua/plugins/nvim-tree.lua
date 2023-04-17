return {
    'nvim-tree/nvim-tree.lua',
    dependencies = 'nvim-tree/nvim-web-devicons',
    cmd = 'NvimTreeToggle',
    opts = {
        disable_netrw = true,
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
        },
        filters = {
            custom = { '^.git$' }
        },
        glyphs = {
            git = {
                unstaged = '✗',
                staged = '✓',
                unmerged = '',
                renamed = '➜',
                untracked = '★',
                deleted = '',
                ignored = '◌',
            }
        }
    }
}
