return {
	"catppuccin/nvim",
	lazy = false,
	name = "catppuccin",
	priority = 9001,
	config = function()
		require("catppuccin").setup({
			no_italic = true,
			flavour = "mocha",
			integrations = {
				cmp = true,
				gitsigns = true,
				indent_blankline = { enabled = true, colored_indent_levels = true },
				leap = true,
				noice = true,
				native_lsp = {
					enabled = true,
				},
				treesitter = true,
				treesitter_context = true,
				ts_rainbow = true,
				telescope = true,
				neotree = true,
				symbols_outline = true,
				navic = { enabled = true, custom_bg = "NONE" },

				dashboard = false,
				notify = false,
			},
			-- transparent_background = true,
			-- custom_highlights = {
			-- 	BufferLineBufferSelected = { fg = "#a6e3a1" },
			-- 	BufferLineFill = { bg = "#181825" },
			-- 	BufferLineIndicatorSelected = { fg = "#a6e3a1" },
			-- 	ColorColumn = { bg = "#313244" },
			-- 	LspFloatWinNormal = { bg = "None" },
			-- 	NormalFloat = { bg = "None" },
			-- 	TelescopeNormal = { bg = "None" },
			-- 	TelescopeBorder = { bg = "None" },
			-- 	LineNr = { fg = "#9399b2" },
			-- 	CursorLine = { bg = "#313244" },
			-- 	CursorLineNr = { bg = "#313244" },
			-- 	CursorLineSign = { bg = "#313244" },
			-- },
		})
		vim.cmd.colorscheme("catppuccin")
	end,
}
