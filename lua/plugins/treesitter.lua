return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = {
        'BufReadPost',
        'BufNewFile'
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
            'bash',
            'comment',
            'diff',
            'vim',
            'vimdoc',
            'norg'
        },
        ignore_install = { '' },
        auto_install = true
    },
    config = function(_, opts)
        require('nvim-treesitter.configs').setup(opts)
    end,
}
