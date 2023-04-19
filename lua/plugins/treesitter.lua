return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = {
        'BufReadPost',
        'BufNewFile'
    },
    opts = {
        ensure_installed = 'all',
        ignore_install = { '' },
        auto_install = true
    },
    config = function(_, opts)
        require('nvim-treesitter.configs').setup(opts)
    end,
}
