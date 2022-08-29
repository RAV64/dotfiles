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
		LspFloatWinNormal = { bg = "None" },
		BufferLineIndicatorSelected = { fg = "#a6e3a1" },
		BufferLineFill = { bg = "#181825" },
		ColorColumn = { bg = "#313244" },
		BufferLineBufferSelected = { fg = "#b4befe" },
		-- NvimTreeNormal = { bg = "None" },
		-- BufferLineBufferSelected = { style = { "bold" } },
		-- BufferLineNumbersSelected = { style = {}, fg = "#a6e3a1" },
		--
		-- BufferLineError = { style = { "bold" }, fg = "#f38ba8" },
		-- BufferLineErrorDiagnostic = { style = { "bold" }, fg = "#f38ba8" },
		-- BufferLineErrorDiagnosticSelected = { style = { "bold" }, fg = "#f38ba8" },
		-- BufferLineErrorDiagnosticVisible = { style = { "bold" }, fg = "#f38ba8" },
		-- BufferLineErrorSelected = { style = { "bold" }, fg = "#f38ba8" },
		-- BufferLineErrorVisible = { style = { "bold" }, fg = "#f38ba8" },
		--
		-- BufferLineWarning = { style = { "bold" }, fg = "#fab387" },
		-- BufferLineWarningDiagnostic = { style = { "bold" }, fg = "#fab387" },
		-- BufferLineWarningDiagnosticSelected = { style = { "bold" }, fg = "#fab387" },
		-- BufferLineWarningDiagnosticVisible = { style = { "bold" }, fg = "#fab387" },
		-- BufferLineWarningSelected = { style = { "bold" }, fg = "#fab387" },
		-- BufferLineWarningVisible = { style = { "bold" }, fg = "#fab387" },
		--
		-- BufferLineInfo = { style = { "bold" }, fg = "#94e2d5" },
		-- BufferLineInfoDiagnostic = { style = { "bold" }, fg = "#94e2d5" },
		-- BufferLineInfoDiagnosticSelected = { style = { "bold" }, fg = "#94e2d5" },
		-- BufferLineInfoDiagnosticVisible = { style = { "bold" }, fg = "#94e2d5" },
		-- BufferLineInfoSelected = { style = { "bold" }, fg = "#94e2d5" },
		-- BufferLineInfoVisible = { style = { "bold" }, fg = "#94e2d5" },
	},
})

vim.g.catppuccin_flavour = "mocha"
vim.cmd([[colorscheme catppuccin]])
