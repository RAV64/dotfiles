local wezterm = require("wezterm")

local weight = {
	regular = "Regular",
	extra_light = "ExtraLight",
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
		"ss07", "ss08",
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
				weight = weight.extra_light,
				harfbuzz_features = monaspace.all_features,
				italic = false,
			}),
		},
		{
			intensity = "Bold",
			font = wezterm.font({
				family = monaspace.font.xenon,
				harfbuzz_features = monaspace.all_features,
				weight = weight.regular,
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
