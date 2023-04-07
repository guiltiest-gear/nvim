return {
	"TimUntersberger/neogit",
	dependencies = "nvim-lua/plenary.nvim",
	cmd = "Neogit",
	config = function()
		local neogit = require("neogit")
		neogit.setup({
			kind = "replace",
		})
	end,
}
