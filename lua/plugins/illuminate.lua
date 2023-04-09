return {
    "RRethy/vim-illuminate",
    event = "LspAttach",
    config = function()
        local illuminate = require("illuminate")
        illuminate.configure({
            filetypes_denylist = {
                "alpha",
                "NvimTree",
                "help",
                "text",
            },
        })
    end,
}
