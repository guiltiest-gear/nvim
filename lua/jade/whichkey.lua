local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
    return
end

local setup = {
    plugins = {
        marks = true,
        registers = true,
        spelling = {
            enabled = true,
            suggestions = 20
        },
        presets = {
            operators = true,
            motions = true,
            text_objects = true,
            windows = true,
            nav = true,
            z = true,
            g = true
        }
    },
    operators = { gc = "Comments" },
    icons = {
        breadcrumb = "»",
        separator = "➜",
        group = "+"
    },
    popup_mappings = {
        scroll_down = "<c-d>",
        scroll_up = "<c-u>"
    },
    window = {
        border = "rounded",
        position = "bottom",
        margin  = { 1, 0, 1, 0 },
        padding = { 2, 2, 2, 2 },
        winblend = 0
    },
    layout = {
        height = { min = 4, max = 25 },
        width = { min = 20, max = 50 },
        spacing = 3,
        align = "left"
    },
    ignore_missing = true,
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " },
    show_help = true,
    triggers = "auto",
    triggers_blacklist = {
        i = { "j", "k" },
        v = { "j", "k" }
    }
}

local mappings = {
    ["a"] = "Alpha",
    ["e"] = "Explorer",
    ["t"] = "Toggle twilight",
    ["l"] = "Toggle lsp_lines",
    ["q"] = "Quit neovim",
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
        c = "Find commands"
    },
    i = {
        name = "Illuminate",
        t = "Toggle vim-illuminate globally",
        b = "Toggle vim-illuminate per buffer"
    },
    p = {
        name = "Packer",
        u = "Update",
        c = "Compile",
        i = "Install",
        s = "Sync",
        S = "Status"
    },
    b = {
        name = "Buffer",
        p = "Go to previous buffer",
        n = "Go to next buffer",
        f = "Go to the first buffer",
        l = "Go to the last buffer",
        k = "Kill the current buffer",
        K = "Kill the current buffer forcefully"
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
        d = "Diff"
    },
    h = {
        name = "Hop",
        w = "Hop to a word",
        c = "Hop to a character",
        C = "Hop to a bigram",
        p = "Hop to an arbitrary pattern",
        l = "Hop to a line",
        a = "Hop anywhere"
    }
}

local opts = {
    mode = "n",
    prefix = "<leader>",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = true
}

which_key.setup(setup)
which_key.register(mappings, opts)
