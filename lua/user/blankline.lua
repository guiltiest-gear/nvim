local status_ok, indent_blankline = pcall(require, "indent_blankline")
if not status_ok then
    return
end

indent_blankline.setup {
    char = "▏",
    use_treesitter = true,
    show_first_indent_level = true,
    show_trailing_blankline_indent = true,
    show_current_context = true,
    show_current_context_start = true,
    filetype_exclude = {
        "help",
        "packer",
        "NvimTree"
    }
}
