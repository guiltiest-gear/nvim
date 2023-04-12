return {
    "folke/which-key.nvim",
    keys = {
        "<leader>",
        '"',
        "'",
        "`",
    },
    config = function()
        local which_key = require("which-key")
        local setup = {
            plugins = {
                marks = true,
                registers = true,
                spelling = {
                    enabled = true,
                    suggestions = 20,
                },
                presets = {
                    operators = true,
                    motions = true,
                    text_objects = true,
                    windows = true,
                    nav = true,
                    z = true,
                    g = true,
                },
            },
            operators = { gc = "Comments" },
            icons = {
                breadcrumb = "»",
                separator = "➜",
                group = "+",
            },
            popup_mappings = {
                scroll_down = "<c-d>",
                scroll_up = "<c-u>",
            },
            window = {
                border = "rounded",
                position = "bottom",
                margin = { 1, 0, 1, 0 },
                padding = { 2, 2, 2, 2 },
                winblend = 0,
            },
            layout = {
                height = { min = 4, max = 25 },
                width = { min = 20, max = 50 },
                spacing = 3,
                align = "left",
            },
            ignore_missing = true,
            hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " },
            show_help = true,
            triggers = "auto",
            triggers_blacklist = {
                i = { "j", "k" },
                v = { "j", "k" },
            },
        }

        local mappings = {
            ["d"] = "Open dashboard",
            ["e"] = "Explorer",
            ["t"] = "Toggle twilight",
            ["l"] = "Toggle lsp_lines",
            ["q"] = "Quit the current file",
            ["Q"] = "Quit neovim",
            ["w"] = "Save the current file",
            f = {
                name = "Find",
                f = "Find files",
                g = "Find text",
                b = "Find buffers",
                h = "Find help pages",
                m = "Find man pages",
                r = "Find recent files",
                R = "Find registers",
                k = "Find keymaps",
                c = "Find commands",
            },
            i = {
                name = "Illuminate",
                t = "Toggle vim-illuminate globally",
                b = "Toggle vim-illuminate per buffer",
            },
            b = {
                name = "Buffer",
                p = "Go to previous buffer",
                n = "Go to next buffer",
                f = "Go to the first buffer",
                l = "Go to the last buffer",
                k = "Kill the current buffer",
                K = "Kill the current buffer forcefully",
            },
            g = {
                name = "Git",
                g = "Open neogit",
                j = "Next hunk",
                k = "Prev hunk",
                l = "Blame",
                p = "Preview hunk",
                r = "Reset hunk",
                R = "Reset buffer",
                s = "Stage hunk",
                u = "Undo stage hunk",
                o = "Open changed file",
                b = "Checkout branch",
                c = "Checkout commit",
                d = "Diff",
            },
            h = {
                name = "Hop",
                w = "Hop to a word",
                c = "Hop to a character",
                C = "Hop to a bigram",
                p = "Hop to an arbitrary pattern",
                l = "Hop to a line",
                a = "Hop anywhere",
            },
            G = {
                name = "nvim-genghis",
                n = "Create a new file",
                d = "Duplicate the current file",
                N = "Move the current selection to a new file",
                r = "Rename the current file",
                m = "Move the current file",
                f = "Copy the name of the current file",
                F = "Copy the path of the current file",
                x = "Make the current file executable",
            },
            x = {
                name = "Trouble",
                x = "Toggle trouble",
                w = "Toggle workspace diagnostics",
                d = "Toggle document_diagnostics",
                q = "Open up quickfix",
                l = "Open up location list",
                r = "Open up lsp references",
            },
            L = {
                name = "Lazy.nvim",
                l = "Open lazy.nvim",
                u = "Update plugins",
                s = "Sync plugins",
                L = "Open the log",
                c = "Clean plugins",
                p = "Profiler"
            },
        }

        local opts = {
            mode = "n",
            prefix = "<leader>",
            buffer = nil,
            silent = true,
            noremap = true,
            nowait = true,
        }

        which_key.setup(setup)
        which_key.register(mappings, opts)
    end,
}
