return {
    -- Comment.nvim
    {
        'numToStr/Comment.nvim',
        keys = {
            { 'gc', mode = 'n', desc = 'Toggle comments (normal mode)' },
            { 'gc', mode = 'v', desc = 'Toggle comments (visual mode)' },
            { 'gb', mode = 'n', desc = 'Toggle block comments (normal mode)' },
            { 'gb', mode = 'v', desc = 'Toggle block comments (visual mode)' },
        },
        config = true,
    },

    -- nvim-autopairs
    {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        opts = {
            disable_filetype = {
                'TelescopePrompt',
                'text',
            },
        },
        config = function(_, opts)
            local npairs = require('nvim-autopairs')
            npairs.setup(opts)
            local cmp_autopairs = require('nvim-autopairs.completion.cmp')
            require('cmp').event:on('confirm_done', cmp_autopairs.on_confirm_done {})
        end,
    },

    -- nvim-surround
    {
        'kylechui/nvim-surround',
        keys = {
            { 'cs', mode = 'n', desc = 'Change surroundings' },
            { 'ys', mode = 'n', desc = 'Add surroundings' },
            { 'ds', mode = 'n', desc = 'Delete surroundings' },
        },
        opts = {
            check_ts = true,
        },
    },
}
