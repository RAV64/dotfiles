return {
	{ "boltlessengineer/smart-tab.nvim", keys = { { mode = "i", "<tab>" } }, opts = { skips = {} } },
	{ "echasnovski/mini.comment", keys = { "gc", mode = { "n", "x", "o" }, desc = "Comment" }, config = true },
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
    -- stylua: ignore
		keys = {
			{ "<leader>bd", function() require("mini.bufremove").delete(0, false) end, desc = "Delete Buffer" },
			{ "<leader>bD", function() require("mini.bufremove").delete(0, true) end, desc = "Delete Buffer (Force)" },
			{ "<S-q>", function() require("mini.bufremove").delete(0, false) end, desc = "Delete Buffer" },
		},
	},
}
