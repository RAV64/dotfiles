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
		treesitter = true,
		cmp = true,
		gitsigns = true,
		telescope = true,
		nvimtree = true,
		dashboard = false,
		notify = false,
		indent_blankline = { colored_indent_levels = { true } },
		bufferline = { enabled = true, italics = false },
		leap = true,
		symbols_outline = true,
		ts_rainbow = true,
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
	color_overrides = {
		latte = {
			rosewater =    "#f5dfdb",
			flamingo     = "#F2CDCD",  -- C
			pink =         "#AB9DF2",
      mauve =        "#CBA6F7", -- C
      red =          "#ff6188",
      maroon =       "#e45454",
      peach =        "#fc9867",
      yellow =       "#ffd866",
      green =        "#A9DC76",
      teal =         "#8db9e2",
      sky =          "#78DCE8",
      sapphire =     "#74C7EC",
      blue =         "#fa973a",
      lavender =     "#73c991",
      text =         "#fcfcfa",
      subtext0 =     "#a0a0a0",
      subtext1 =     "#8c8c8c",
      overlay0 =     "#525252",
      overlay1 =     "#585858",
      overlay2 =     "#5B595C",
      surface0 =     "#19181a",
      surface1 =     "#2c2525",
      surface2 =     "#72696a",
      base =         "#2D2A2E",
      crust =        "#000000"
		},
	},
})

vim.g.catppuccin_flavour = "mocha"
vim.cmd([[colorscheme catppuccin]])
