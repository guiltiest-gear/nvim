return {
    'lukas-reineke/indent-blankline.nvim',
    event = 'BufAdd',
    opts = {
        char = '▏',
        use_treesitter = true,
        show_first_indent_level = true,
        show_trailing_blankline_indent = true,
        show_current_context = true,
        show_current_context_start = true,
        filetype_exclude = {
            'help',
            'NvimTree',
        },
    },
}
