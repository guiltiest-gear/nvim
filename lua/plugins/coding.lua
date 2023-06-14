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

    -- dial.nvim
    {
        'monaqa/dial.nvim',
        keys = {
            {
                '<C-a>',
                function()
                    return require('dial.map').inc_normal()
                end,
                expr = true,
                desc = 'Increment',
            },
            {
                '<C-x>',
                function()
                    return require('dial.map').dec_normal()
                end,
                expr = true,
                desc = 'Decrement',
            },
        },
        config = function()
            local augend = require('dial.augend')
            require('dial.config').augends:register_group {
                default = {
                    augend.integer.alias.decimal,
                    augend.integer.alias.decimal_int,
                    augend.integer.alias.hex,
                    augend.constant.alias.bool,
                    augend.constant.alias.alpha,
                    augend.constant.alias.Alpha,
                },
            }
        end,
    },

    -- treesj
    {
        'Wansmer/treesj',
        dependencies = 'nvim-treesitter/nvim-treesitter',
        keys = {
            {
                '<leader>m',
                function()
                    return require('treesj').toggle()
                end,
                desc = 'Toggle node under cursor',
            },
            {
                '<leader>j',
                function()
                    return require('treesj').join()
                end,
                desc = 'Join node under cursor',
            },
            {
                '<leader>s',
                function()
                    return require('treesj').split()
                end,
                desc = 'Split node under cursor',
            },
        },
        opts = {
            max_join_length = 150,
        },
    },
}
