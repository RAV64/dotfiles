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
        -- stylua: ignore
        internal_pairs = {
          { "<", ">", fly = true, dosuround = true, newline = true, space = true },
          { "[", "]", fly = true, dosuround = true, newline = true, space = true },
          { "(", ")", fly = true, dosuround = true, newline = true, space = true },
          { "{", "}", fly = true, dosuround = true, newline = true, space = true },
          { '"', '"', suround = true, multiline = false, alpha = { "txt" } },
          { "'", "'", suround = true, cond = function(fn) return not fn.in_lisp() or fn.in_string() end, alpha = true, nft = { "tex", "latex" }, multiline = false, },
          { "`", "`", nft = { "tex", "latex" }, multiline = false },
          { "``", "''", ft = { "tex", "latex" } },
          { "```", "```", newline = true, ft = { "markdown" } },
          { "<!--", "-->", ft = { "markdown", "html" } },
          { '"""', '"""', newline = true, ft = { "python" } },
          { "'''", "'''", newline = true, ft = { "python" } },
        },
			},
		},
	},
}
