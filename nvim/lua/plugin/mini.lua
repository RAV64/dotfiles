local M = {}

M.plugin = {
	{ "echasnovski/mini.pairs", event = "InsertEnter", config = true },
	{
		"echasnovski/mini.ai",
		keys = {
			{ "a", mode = { "x", "o" } },
			{ "i", mode = { "x", "o" } },
		},
		config = true,
	},
	{
		"echasnovski/mini.surround",
		event = "BufReadPost",
		opts = {
			mappings = {
				add = "sa",
				delete = "sd",
				replace = "sr",

				-- Disable
				find = "",
				find_left = "",
				highlight = "",
				update_n_lines = "",
			},
		},
	},
	{
		"echasnovski/mini.bufremove",
		keys = {
			{
				"<S-q>",
				function()
					M.buf_delete(0, false)
				end,
				desc = "Delete Buffer",
			},
		},
		config = function()
			M.buf_delete = require("mini.bufremove").delete
		end,
	},
}

return M.plugin
