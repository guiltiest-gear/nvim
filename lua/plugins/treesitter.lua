return {
    'nvim-treesitter/nvim-treesitter',
    build = function()
        require('nvim-treesitter.install').update({ with_sync = true })
    end,
    event = {
        'BufReadPre',
        'BufNewFile'
    },
    config = function()
        local configs = require('nvim-treesitter.configs')
        configs.setup({
            -- List of parser names
            ensure_installed = 'all',

            -- List of parsers to ingnore installing
            ignore_install = { '' },

            -- Autoinstall missing parsers when enering buffer
            auto_install = true,
        })
    end,
}
