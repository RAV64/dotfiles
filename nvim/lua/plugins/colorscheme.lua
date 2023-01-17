return {
	"catppuccin/nvim",
	lazy = false,
	name = "catppuccin",
	config = function()
		require("catppuccin").setup({
			no_italic = true,
			flavour = "mocha",
			integrations = {
				treesitter = true,
				cmp = true,
				gitsigns = true,
				telescope = true,
				nvimtree = true,
				dashboard = false,
				notify = false,
				leap = true,
				symbols_outline = true,
				ts_rainbow = true,
				indent_blankline = { enabled = true, colored_indent_levels = true },
				native_lsp = {
					enabled = true,
				},
			},
			-- transparent_background = true,
			custom_highlights = {
				BufferLineBufferSelected = { fg = "#a6e3a1" },
				BufferLineFill = { bg = "#181825" },
				BufferLineIndicatorSelected = { fg = "#a6e3a1" },
				ColorColumn = { bg = "#313244" },
				LspFloatWinNormal = { bg = "None" },
				NormalFloat = { bg = "None" },
				TelescopeNormal = { bg = "None" },
				TelescopeBorder = { bg = "None" },
				LineNr = { fg = "#9399b2" },
				CursorLine = { bg = "#313244" },
				CursorLineNr = { bg = "#313244" },
				CursorLineSign = { bg = "#313244" },
			},
		})
		vim.cmd.colorscheme("catppuccin")
	end,
}
