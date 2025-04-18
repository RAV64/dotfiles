local wezterm = require("wezterm")

local weight = {
	thin = "Thin",
	extra_light = "ExtraLight",
	light = "Light",
	demi_light = "DemiLight",
	book = "Book",
	regular = "Regular",
	medium = "Medium",
	demi_bold = "DemiBold",
	bold = "Bold",
	extra_bold = "ExtraBold",
	black = "Black",
	extra_black = "ExtraBlack",
}

local monocraft = {
	font = "Monocraft Nerd Font",
}

local monaspace = {
	font = {
		neon = "MonaspiceNe Nerd Font Mono",
		argon = "MonaspiceAr Nerd Font Mono",
		xenon = "MonaspiceXe Nerd Font Mono",
		radon = "MonaspiceRn Nerd Font Mono",
		krypton = "MonaspiceKr Nerd Font Mono",
	},
  -- stylua: ignore
	all_features = {
		"calt", "liga", "dlig",
		"ss01", "ss02", "ss03",
		"ss04", "ss05", "ss06",
		"ss07", "ss08", "ss09",
    "ss10",
	},
}

function monaspace.setup(config)
	config.font = wezterm.font({
		family = monaspace.font.neon,
		weight = weight.regular,
		harfbuzz_features = monaspace.all_features,
	})
	config.font_rules = {
		{ -- Italic (comments)
			italic = true,
			font = wezterm.font({
				family = monaspace.font.krypton,
				weight = weight.thin,
				harfbuzz_features = monaspace.all_features,
				italic = false,
			}),
		},
		{
			intensity = "Bold",
			font = wezterm.font({
				family = monaspace.font.neon,
				harfbuzz_features = monaspace.all_features,
				weight = weight.medium,
				italic = false,
			}),
		},
	}
end

function monocraft.setup(config)
	config.font = wezterm.font({ family = monocraft.font })
	config.line_height = 1.1
end

local M = {}

function M.setup(config)
	config.font_size = 12.5
	monaspace.setup(config)
end

return M
