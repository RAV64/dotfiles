return {
	{ "echasnovski/mini.comment", keys = { "gc", mode = { "n", "x" }, desc = "Comment" }, config = true },
	{ "echasnovski/mini.pairs", event = "InsertEnter", config = true },
	{
		"echasnovski/mini.ai",
		keys = {
			{ "a", mode = { "x", "o" } },
			{ "i", mode = { "x", "o" } },
		},
		dependencies = {
			{
				"nvim-treesitter/nvim-treesitter-textobjects",
				init = function()
					require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
				end,
			},
		},
		config = function()
			local ai = require("mini.ai")
			local ts_gen = ai.gen_spec.treesitter
			ai.setup({
				n_lines = 500,
				custom_textobjects = {
					["?"] = false,
					f = ts_gen({ a = "@function.outer", i = "@function.inner" }),
					c = ts_gen({ a = "@class.outer", i = "@class.inner" }),
				},
			})
		end,
	},
	{
		"echasnovski/mini.surround",
		event = "BufReadPost",
		opts = {
			mappings = {
				add = "<leader>sa",
				delete = "<leader>sd",
				replace = "<leader>sc",
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
