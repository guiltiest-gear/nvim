return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'debugloop/telescope-undo.nvim',
        'nvim-lua/plenary.nvim',
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make',
        },
    },
    branch = '0.1.x',
    cmd = 'Telescope',
    opts = {
        defaults = {
            path_display = { 'smart' },
            file_ignore_patterns = { '.git/' },
        },
        pickers = {
            find_files = {
                find_command = { 'rg', '--files', '--hidden', '--glob', '!**/.git/*' },
            },
        },
        extensions = {
            fzf = {
                theme = 'tokyonight',
                fuzzy = true,
                override_generic_sorter = true,
                override_file_sorter = true,
                case_mode = 'smart_case',
            },
            undo = {
                side_by_side = true,
                layout_strategy = 'vertical',
                layout_config = {
                    preview_height = 0.8,
                },
            },
        },
    },
    config = function(_, opts)
        -- Load the configs
        require('telescope').setup(opts)

        -- Load the extensions
        require('telescope').load_extension('fzf')
        require('telescope').load_extension('undo')
    end,
}
