return {
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
}
