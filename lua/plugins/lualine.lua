return {
    'nvim-lualine/lualine.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    event = {
        'BufReadPre',
        'BufNewFile',
    },
    opts = {
        options = {
            theme = 'tokyonight',
            component_separators = { left = '', right = '' },
            section_separators = { left = '', right = '' },
            disabled_filetypes = { 'mason', 'dashboard', 'NvimTree' },
        },
        sections = {
            lualine_a = { 'mode' },
            lualine_b = { 'branch', 'diff', 'diagnostics' },
            lualine_c = {
                'filename',
                {
                    function()
                        return require('nvim-navic').get_location()
                    end,
                    cond = function()
                        return require('nvim-navic').is_available()
                    end,
                },
            },
            lualine_x = {
                'fileformat',
                'filetype',
                {
                    require('lazy.status').updates,
                    cond = require('lazy.status').has_updates,
                    color = { fg = '#ff9e64' }
                }
            },
            lualine_y = { 'progress' },
            lualine_z = { 'location' },
        },
        extensions = { 'lazy' }
    },
}
