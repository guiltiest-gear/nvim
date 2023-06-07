return {
    'andymass/vim-matchup',
    dependencies = 'nvim-treesitter/nvim-treesitter',
    init = function()
        vim.g.matchup_matchparen_offscreen = { method = 'status_manual' }
    end,
    event = {
        'BufReadPost',
        'BufNewFile',
    },
}
