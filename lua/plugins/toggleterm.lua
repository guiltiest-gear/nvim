return {
    "akinsho/toggleterm.nvim",
    version = "*",
    event = 'VeryLazy',
    config = function()
        local toggleterm = require("toggleterm")
        toggleterm.setup({
            size = 20,
            open_mapping = [[<c-\>]],
            hide_numbers = true,
            shell = vim.o.shell,
            shade_terminals = true,
            shading_factor = 2,
            persist_size = true,
            start_in_insert = true,
            direction = "float",
            close_on_exit = true,
            float_opts = {
                border = "curved",
            },
        })

        function _G.set_terminal_keymaps()
            local opts = { noremap = true }
            vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
            vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
            vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
            vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
        end

        vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
    end,
}
