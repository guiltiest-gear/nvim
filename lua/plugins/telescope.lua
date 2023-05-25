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
        { '<leader>ff', '<cmd>Telescope find_files<CR>' },
        { '<leader>fw', '<cmd>Telescope live_grep<CR>' },
        { '<leader>fb', '<cmd>Telescope buffers<CR>' },
        { '<leader>fh', '<cmd>Telescope help_tags<CR>' },
        { '<leader>fm', '<cmd>Telescope man_pages<CR>' },
        { '<leader>fr', '<cmd>Telescope oldfiles<CR>' },
        { '<leader>fR', '<cmd>Telescope registers<CR>' },
        { '<leader>fk', '<cmd>Telescope keys<CR>' },
        { '<leader>fc', '<cmd>Telescope commands<CR>' },
        { '<leader>go', '<cmd>Telescope git_status<CR>' },
        { '<leader>gb', '<cmd>Telescope git_branches<CR>' },
        { '<leader>gc', '<cmd>Telescope git_commits<CR>' },
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
