local status, cp = pcall(require, "catppuccin")
if not status then
	print("ERROR: catppuccin")
	return
end

cp.setup({
	compile = {
		enabled = true,
		path = vim.fn.stdpath("cache") .. "/catppuccin",
	},
	styles = {
		comments = {},
		conditionals = {},
	},
	integrations = {
		indent_blankline = {
			colored_indent_levels = { true },
		},
		bufferline = {
			enabled = true,
			italics = false,
		},
		leap = true,
		dashboard = false,
		telekasten = false,
		symbols_outline = true,
		ts_rainbow = true,
	},
	custom_highlights = {
		BufferLineBufferSelected = { fg = "#a6e3a1" },
		BufferLineFill = { bg = "#181825" },
		BufferLineIndicatorSelected = { fg = "#a6e3a1" },
		ColorColumn = { bg = "#313244" },
		LspFloatWinNormal = { bg = "None" },
	},
})

vim.g.catppuccin_flavour = "mocha"
vim.cmd([[colorscheme catppuccin]])
