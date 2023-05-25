return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make',
            config = function()
                require('telescope').load_extension('fzf')
            end,
        },
    },
    branch = '0.1.x',
    keys = {
        {
            '<leader>ff',
            function()
                return require('telescope.builtin').find_files()
            end,
        },
        {
            '<leader>fw',
            function()
                return require('telescope.builtin').live_grep()
            end,
        },
        {
            '<leader>fb',
            function()
                return require('telescope.builtin').buffers()
            end,
        },
        {
            '<leader>fh',
            function()
                return require('telescope.builtin').help_tags()
            end,
        },
        {
            '<leader>fm',
            function()
                return require('telescope.builtin').man_pages()
            end,
        },
        {
            '<leader>fr',
            function()
                return require('telescope.builtin').oldfiles()
            end,
        },
        {
            '<leader>fR',
            function()
                return require('telescope.builtin').registers()
            end,
        },
        {
            '<leader>fk',
            function()
                return require('telescope.builtin').keys()
            end,
        },
        {
            '<leader>fc',
            function()
                return require('telescope.builtin').commands()
            end,
        },
        {
            '<leader>go',
            function()
                return require('telescope.builtin').git_status()
            end,
        },
        {
            '<leader>gb',
            function()
                return require('telescope.builtin').git_branches()
            end,
        },
        {
            '<leader>gc',
            function()
                return require('telescope.builtin').git_commits()
            end,
        },
    },
    opts = {
        defaults = {
            theme = 'tokyonight',
            path_display = { 'smart' },
            file_ignore_patterns = { '.git/' },
            layout_strategy = 'horizontal',
            layout_config = { prompt_position = 'top' },
            sorting_strategy = 'ascending',
        },
        pickers = {
            find_files = {
                find_command = { 'rg', '--files', '--hidden', '--glob', '!**/.git/*' },
            },
        },
    },
}
