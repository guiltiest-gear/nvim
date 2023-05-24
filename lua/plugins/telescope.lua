return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
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
            theme = 'tokyonight',
            path_display = { 'smart' },
            file_ignore_patterns = { '.git/' },
        },
        pickers = {
            find_files = {
                find_command = { 'rg', '--files', '--hidden', '--glob', '!**/.git/*' },
            },
        },
    },
    config = function(_, opts)
        -- Load the configs
        require('telescope').setup(opts)

        -- Load the extensions
        require('telescope').load_extension('fzf')
    end,
}
