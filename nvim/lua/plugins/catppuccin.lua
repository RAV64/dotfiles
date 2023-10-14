return {
	"catppuccin/nvim",
	lazy = false,
	name = "catppuccin",
	priority = 9001,
	config = function()
		require("catppuccin").setup({
			no_italic = true,
			flavour = "mocha",
			transparent_background = false,
			integrations = {
				cmp = true,
				gitsigns = true,
				indent_blankline = {
					enabled = true,
					scope_color = "lavender", -- catppuccin color (eg. `lavender`) Default: text
					colored_indent_levels = true,
				},
				leap = true,
				noice = true,
				native_lsp = {
					enabled = true,
					virtual_text = {
						errors = { "italic" },
						hints = { "italic" },
						warnings = { "italic" },
						information = { "italic" },
					},
					underlines = {
						errors = { "underline" },
						hints = { "underline" },
						warnings = { "underline" },
						information = { "underline" },
					},
					inlay_hints = {
						background = true,
					},
				},
				treesitter = true,
				treesitter_context = true,
				rainbow_delimiters = true,
				telescope = true,
				neotree = true,
				symbols_outline = true,
				navic = { enabled = true, custom_bg = "NONE" },
				notify = true,
			},
			color_overrides = {
				mocha = {
					text = "#dde1e6",
					base = "#202020",
					mantle = "#161616",
					surface0 = "#262626",
					surface1 = "#393939",
					surface2 = "#525252",
					overlay0 = "#ffffff",
					overlay1 = "#f2f4f8",
					overlay2 = "#dde1e6",
					-- mauve = "#be95ff",
					-- green = "#8fca5c",
					maroon = "#ee5396",
					-- lavender = "#78a9ff",
					red = "#ea7183",
					peach = "#f39967",
					yellow = "#eaca89",
					green = "#96d382",
					-- blue = "#3ddbd9"
				},
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

					CursorLine = { bg = "#393939" },

					TablineActive = { fg = C.overlay1, bg = C.mantle },
					TablineInactive = { fg = "#90A4AE", bg = C.mantle },
					NeoTreeDirectoryIcon = { fg = "#be95ff" },
					-- PmenuSel = { fg = "", bg = "" },
					redred = { fg = "#ff0000", bg = "#ff0000" },

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
