return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = "VeryLazy",
	config = function()
		local configs = require("nvim-treesitter.configs")
		configs.setup({
			-- List of parser names
			ensure_installed = "all",

			-- List of parsers to ingnore installing
			ignore_install = { "" },

			-- Autoinstall missing parsers when enering buffer
			auto_install = true,
		})
	end,
}
