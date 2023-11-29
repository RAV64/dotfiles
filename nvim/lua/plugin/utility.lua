return {
	{ "boltlessengineer/smart-tab.nvim", keys = { { mode = "i", "<tab>" } }, opts = { skips = {} } },
	{ "echasnovski/mini.comment", keys = { "gc", mode = { "n", "x" }, desc = "Comment" }, config = true },
	{ "echasnovski/mini.pairs", event = "InsertEnter", config = true },
	{
		"echasnovski/mini.surround",
		event = "BufReadPost",
		opts = {
			mappings = {
				add = "<leader>sa",
				delete = "<leader>sd",
				replace = "<leader>sc",

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
    -- stylua: ignore
		keys = {
			{ "<leader>bd", function() require("mini.bufremove").delete(0, false) end, desc = "Delete Buffer" },
			{ "<leader>bD", function() require("mini.bufremove").delete(0, true) end, desc = "Delete Buffer (Force)" },
			{ "<S-q>", function() require("mini.bufremove").delete(0, false) end, desc = "Delete Buffer" },
		},
	},

	{
		"ggandor/leap.nvim",
		keys = {
			{ "s", mode = { "n", "x", "o" }, desc = "Leap forward to" },
			{ "S", mode = { "n", "x", "o" }, desc = "Leap backward to" },
		},
		config = function()
			local leap = require("leap")
			leap.add_default_mappings(true)
			leap.opts.safe_labels = {}
		end,
	},
}
