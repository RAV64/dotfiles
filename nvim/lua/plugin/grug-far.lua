local M = {}

M.plugin = {
	"MagicDuck/grug-far.nvim",
	opts = { headerMaxWidth = 80 },
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
		require("grug-far").setup(opts)
		M.grug = require("grug-far")
	end,
}

return M.plugin
