local M = {}

M.plugin = {
	"MagicDuck/grug-far.nvim",
	commit = "3bc6997724c6b9c10bc4bac86821c9061694ded3",
	opts = {
		headerMaxWidth = 80,
		folding = {
			enabled = false,
		},
	},
	cmd = "GrugFar",
	keys = {
		{
			"<leader>R",
			function()
				require("grug-far").open({ transient = true })
			end,
			mode = { "n" },
			desc = "Search and Replace",
		},
	},
}

return M.plugin
