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
        {
            'debugloop/telescope-undo.nvim',
            config = function()
                require('telescope').load_extension('undo')
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
            desc = 'Find files',
        },
        {
            '<leader>fw',
            function()
                return require('telescope.builtin').live_grep()
            end,
            desc = 'Find words',
        },
        {
            '<leader>fb',
            function()
                return require('telescope.builtin').buffers()
            end,
            desc = 'Search buffers',
        },
        {
            '<leader>fh',
            function()
                return require('telescope.builtin').help_tags()
            end,
            desc = 'Search help',
        },
        {
            '<leader>fm',
            function()
                return require('telescope.builtin').man_pages()
            end,
            desc = 'Search man pages',
        },
        {
            '<leader>fr',
            function()
                return require('telescope.builtin').oldfiles()
            end,
            desc = 'Search recently opened files',
        },
        {
            '<leader>fR',
            function()
                return require('telescope.builtin').registers()
            end,
            desc = 'Search registers',
        },
        {
            '<leader>fk',
            function()
                return require('telescope.builtin').keymaps()
            end,
            desc = 'Search keymaps',
        },
        {
            '<leader>fc',
            function()
                return require('telescope.builtin').commands()
            end,
            desc = 'Search commands',
        },
        {
            '<leader>go',
            function()
                return require('telescope.builtin').git_status()
            end,
            desc = 'Seach through changed files',
        },
        {
            '<leader>gb',
            function()
                return require('telescope.builtin').git_branches()
            end,
            desc = 'Search through git branches',
        },
        {
            '<leader>gc',
            function()
                return require('telescope.builtin').git_commits()
            end,
            desc = 'Search and checkout git commits',
        },
        {
            '<leader>u',
            function()
                return require('telescope').extensions.undo.undo()
            end,
            desc = 'Search through undo tree',
        },
        {
            '<leader>tt',
            '<cmd>TodoTelescope<CR>',
            desc = 'Search through todo comments',
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
                find_command = { 'rg', '--color=never', '--files', '--hidden', '--glob', '!**/.git/*' },
            },
        },
        extensions = {
            undo = {
                side_by_side = true,
                layout_strategy = 'vertical',
            },
        },
    },
}
