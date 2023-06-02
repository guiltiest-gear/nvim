return {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
        {
            'nvim-treesitter/nvim-treesitter-context',
            config = true,
        },
    },
    build = function()
        require('nvim-treesitter.install').update()
    end,
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
            'comment',
            'diff',
            'vim',
            'vimdoc',
        },
        ignore_install = { '' },
        auto_install = true,
        matchup = {
            enabled = true,
        },
    },
    config = function(_, opts)
        require('nvim-treesitter.configs').setup(opts)
    end,
}
