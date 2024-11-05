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
			"<leader>R",
			function()
				UTIL.func("grug-far", "grug_far", { transient = true })
			end,
			mode = { "n" },
			desc = "Search and Replace",
		},
	},
}

return M.plugin
