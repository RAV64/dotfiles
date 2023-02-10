return {
	"lukas-reineke/indent-blankline.nvim",
	event = "BufReadPre",
	opts = {
		-- char = "▏",
		char = "│",
		filetype_exclude = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "OUTLINE" },
		show_trailing_blankline_indent = false,
		show_current_context = false,
		char_highlight_list = {
			"IndentBlanklineIndent1",
			"IndentBlanklineIndent2",
			"IndentBlanklineIndent3",
			"IndentBlanklineIndent4",
			"IndentBlanklineIndent5",
			"IndentBlanklineIndent6",
		},
	},
}
