return {
    'nvim-lualine/lualine.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    event = {
        'BufReadPre',
        'BufNewFile'
    },
    config = function()
        local lualine = require('lualine')
        local navic = require('nvim-navic')
        lualine.setup({
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
                            return navic.get_location()
                        end,
                        cond = function()
                            return navic.is_available()
                        end,
                    },
                },
                lualine_x = { 'fileformat', 'filetype' },
                lualine_y = { 'progress' },
                lualine_z = { 'location' },
            },
        })
    end,
}
