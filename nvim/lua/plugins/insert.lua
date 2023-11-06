return {
	{
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
			},
		},
	},
}
