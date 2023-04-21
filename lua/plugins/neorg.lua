return {
    'nvim-neorg/neorg',
    build = ':Neorg sync-parsers',
    ft = 'norg',
    cmd = 'Neorg',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-neorg/neorg-telescope'
    },
    opts = {
        load = {
            ['core.defaults'] = {},
            ['core.concealer'] = {},
            ['core.dirman'] = {
                config = {
                    workspaces = {
                        notes = '~/git/notes'
                    }
                }
            },
            ['core.integrations.telescope'] = {},
            ['core.completion'] = {
                config = {
                    engine = 'nvim-cmp'
                }
            },
            ['core.integrations.nvim-cmp'] = {},
            -- Required for core.completion
            ['core.integrations.treesitter'] = {},
            -- Required by core.integrations.treesitter
            ['core.neorgcmd'] = {},
            ['core.highlights'] = {},
            ['core.mode'] = {},
            ['core.keybinds'] = {},
        }
    }
}
