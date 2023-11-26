return {
	{ "echasnovski/mini.comment", event = "BufReadPost", config = true },
	{
		"echasnovski/mini.ai",
		event = "BufReadPost",
		dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
		config = function()
			local ai = require("mini.ai")
			ai.setup({
				n_lines = 500,
				custom_textobjects = {
					o = ai.gen_spec.treesitter({
						a = { "@block.outer", "@conditional.outer", "@loop.outer" },
						i = { "@block.inner", "@conditional.inner", "@loop.inner" },
					}, {}),
					f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
					c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
					t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },
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
