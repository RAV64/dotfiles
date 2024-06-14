local M = {}

M.plugin = {
	{
		"stevearc/oil.nvim",
		keys = {
			{ "å", "<CMD>Oil<CR>", desc = "Explorer NeoTree (root dir)" },
		},
		opts = { experimental_watch_for_changes = true },
	},
}

return M.plugin
