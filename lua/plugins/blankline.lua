return {
    'lukas-reineke/indent-blankline.nvim',
    event = {
        'BufReadPost',
        'BufNewFile'
    },
    opts = {
        char = '▏',
        context_char = '▏',
        use_treesitter = true,
        show_first_indent_level = true,
        show_trailing_blankline_indent = false,
        show_current_context = true,
        show_current_context_start = true,
        filetype_exclude = {
            'help',
            'NvimTree',
            'dashboard',
            'Trouble',
            'neogitstatus'
        },
        context_patterns = {
            'class',
            'return',
            'function',
            'method',
            '^if',
            '^while',
            'jsx_element',
            '^for',
            '^object',
            '^table',
            'block',
            'arguments',
            'if_statement',
            'else_clause',
            'jsx_element',
            'jsx_self_closing_element',
            'try_statement',
            'catch_clause',
            'import_statement',
            'operation_type'
        }
    }
}
