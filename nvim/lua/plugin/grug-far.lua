local M = {}

M.plugin = {
	"MagicDuck/grug-far.nvim",
	opts = {
		headerMaxWidth = 80,
		folding = {
			enabled = false,
		},
	},
	cmd = "GrugFar",
	keys = {
		{
			"<leader>sr",
			function()
				M.grug.grug_far({
					transient = true,
				})
			end,
			mode = { "n" },
			desc = "Search and Replace",
		},
	},
	config = function(_, opts)
		M.grug = require("grug-far")
		M.grug.setup(opts)
	end,
}

return M.plugin
