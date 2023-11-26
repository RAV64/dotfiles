return {
	{
		"max397574/better-escape.nvim",
		event = "InsertEnter",
		opts = {
			mapping = { "jk", "jj", "qq" },
		},
	},

	{
		"abecodes/tabout.nvim",
		event = "InsertEnter",
		opts = {
			tabouts = {
				{ open = "'", close = "'" },
				{ open = '"', close = '"' },
				{ open = "`", close = "`" },
				{ open = "(", close = ")" },
				{ open = "[", close = "]" },
				{ open = "{", close = "}" },
				{ open = "<", close = ">" },
			},
		},
	},

	{
		"echasnovski/mini.pairs",
		event = "InsertEnter",
		config = true,
	},
}
