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

				notify = true,
			},
			custom_highlights = function(C)
				local base = C.base
				return {
					-- CmpItemAbbr = { fg = base, bg = C.overlay2 },
					-- CmpItemAbbrDeprecated = { fg = base, bg = C.overlay0, style = { "strikethrough" } },
					-- CmpItemKind = { fg = base, bg = C.blue },
					-- CmpItemMenu = { fg = base, bg = C.text },
					-- CmpItemAbbrMatch = { fg = base, bg = C.text, style = { "bold" } },
					-- CmpItemAbbrMatchFuzzy = { fg = base, bg = C.text, style = { "bold" } },
					CmpItemKindSnippet = { fg = base, bg = C.mauve },
					CmpItemKindKeyword = { fg = base, bg = C.red },
					CmpItemKindText = { fg = base, bg = C.teal },
					CmpItemKindMethod = { fg = base, bg = C.blue },
					CmpItemKindConstructor = { fg = base, bg = C.blue },
					CmpItemKindFunction = { fg = base, bg = C.blue },
					CmpItemKindFolder = { fg = base, bg = C.blue },
					CmpItemKindModule = { fg = base, bg = C.blue },
					CmpItemKindConstant = { fg = base, bg = C.peach },
					CmpItemKindField = { fg = base, bg = C.green },
					CmpItemKindProperty = { fg = base, bg = C.green },
					CmpItemKindEnum = { fg = base, bg = C.green },
					CmpItemKindUnit = { fg = base, bg = C.green },
					CmpItemKindClass = { fg = base, bg = C.yellow },
					CmpItemKindVariable = { fg = base, bg = C.flamingo },
					CmpItemKindFile = { fg = base, bg = C.blue },
					CmpItemKindInterface = { fg = base, bg = C.yellow },
					CmpItemKindColor = { fg = base, bg = C.red },
					CmpItemKindReference = { fg = base, bg = C.red },
					CmpItemKindEnumMember = { fg = base, bg = C.red },
					CmpItemKindStruct = { fg = base, bg = C.blue },
					CmpItemKindValue = { fg = base, bg = C.peach },
					CmpItemKindEvent = { fg = base, bg = C.blue },
					CmpItemKindOperator = { fg = base, bg = C.blue },
					CmpItemKindTypeParameter = { fg = base, bg = C.blue },
					CmpItemKindCopilot = { fg = base, bg = C.teal },
				}
			end,
		})
		vim.cmd.colorscheme("catppuccin")
	end,
}
