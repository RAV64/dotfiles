return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 9001,
	init = function()
		require("catppuccin").setup({
			no_italic = true,
			flavour = "mocha",
			transparent_background = false,
			integrations = {
				alpha = false,
				dashboard = false,
				neogit = false,
				nvimtree = false,
				ufo = false,
				dap = { enabled = false, enable_ui = false },

				leap = true,
				neotree = true,
				noice = true,
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
				local tPreview = "#181818"
				return {
					CursorLine = { bg = C.surface1 },
					TelescopeNormal = { bg = C.mantle },
					TelescopeBorder = { bg = C.mantle },
					TelescopePromptNormal = { bg = C.surface0 },
					TelescopePromptBorder = { bg = C.surface0 },
					TelescopePromptTitle = { bg = C.surface0 },

					TelescopePreviewNormal = { bg = tPreview },
					TelescopePreviewBorder = { bg = tPreview },

					NormalFloat = { bg = C.mantle },
					TablineActive = { fg = C.overlay1, bg = C.mantle },
					TablineInactive = { fg = "#90A4AE", bg = C.mantle },
					NeoTreeDirectoryIcon = { fg = "#be95ff" },
					CmpBackground = { bg = C.mantle },

					LazyNormal = { bg = C.mantle },
					CmpGhostText = { italic = true },

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
					NeoTreeWinSeparator = { fg = C.mantle, bg = C.mantle },
					TreeSitterContext = { bg = C.mantle },
					TreeSitterContextBottom = { underline = true },
					TreeSitterContextLineNumber = { fg = C.overlay2, bg = C.mantle },
					["@codeblock"] = { bg = C.surface0 },
					["@comment"] = { italic = true, fg = C.rosewater },
				}
			end,
		})
		vim.cmd.colorscheme("catppuccin")
	end,
}
