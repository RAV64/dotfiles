return {
	{ "boltlessengineer/smart-tab.nvim", keys = { "i", "<tab>", opts = { skips = {} } } },
	{
		"echasnovski/mini.comment",
		event = { "BufReadPost", "BufNewFile" },
		keys = { { "n", "x", "o" }, "gc", desc = "Comment" },
		config = true,
	},
	{ "echasnovski/mini.pairs", event = "InsertEnter", config = true },
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
					require("mini.bufremove").delete(0, false)
				end,
				desc = "Delete Buffer",
			},
		},
	},
}
