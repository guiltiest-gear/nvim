return {
    "nvim-telescope/telescope.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    branch = "0.1.x",
    cmd = "Telescope",
    config = function()
        local telescope = require("telescope")
        telescope.setup({
            defaults = {
                path_display = { "smart" },
                file_ignore_patterns = { ".git/" },
            },
            pickers = {
                find_files = {
                    find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
                },
            },
            extensions = {
                fzf = {
                    theme = "tokyonight",
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                },
            },
        })

        -- Load the extension
        telescope.load_extension("fzf")
    end,
}
