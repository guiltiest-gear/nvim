return {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
        {
            'nvim-treesitter/nvim-treesitter-context',
            config = true,
        },
        'HiPhish/nvim-ts-rainbow2',
    },
    build = ':TSUpdate',
    event = {
        'BufReadPost',
        'BufNewFile',
    },
    opts = {
        ensure_installed = {
            'lua',
            'luadoc',
            'luap',
            'cpp',
            'markdown',
            'markdown_inline',
            'git_config',
            'git_rebase',
            'gitcommit',
            'gitignore',
            'gitattributes',
            'diff',
            'vim',
            'vimdoc',
        },
        ignore_install = { '' },
        auto_install = true,
        -- vim-matchup config
        matchup = {
            enable = true,
        },
        -- nvim-ts-rainbow2 config
        rainbow = {
            enable = true,
        },
    },
    config = function(_, opts)
        require('nvim-treesitter.configs').setup(opts)
    end,
}
