return {
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
		"altermo/ultimate-autopair.nvim",
		event = { "InsertEnter" },
		opts = {
			cmap = false,
			tabout = { enable = true },
			internal_pairs = {
				{ "[", "]", fly = true, dosuround = true, newline = true, space = true, suround = true },
				{ "(", ")", fly = true, dosuround = true, newline = true, space = true, suround = true },
				{ "{", "}", fly = true, dosuround = true, newline = true, space = true, suround = true },
				{ "<", ">", suround = true, multiline = false },
				{ '"', '"', suround = true, multiline = false },
				{ "'", "'", suround = true, multiline = false },
				{ "`", "`", suround = true, multiline = false },
			},
		},
	},
}
