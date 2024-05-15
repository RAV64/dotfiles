local M = {}

M.plugin = {
	{
		"stevearc/oil.nvim",
		keys = {
			{ "å", "<CMD>Oil<CR>", desc = "Explorer NeoTree (root dir)" },
		},
		config = true,
	},
}

return M.plugin
