local wezterm = require("wezterm")
local M = {}

local font = {
	neon = "MonaspiceNe Nerd Font Mono",
	argon = "MonaspiceAr Nerd Font Mono",
	xenon = "MonaspiceXe Nerd Font Mono",
	radon = "MonaspiceRn Nerd Font Mono",
	krypton = "MonaspiceKr Nerd Font Mono",
}

-- stylua: ignore
local all_features = {
  "calt", "liga", "dlig",
  "ss01", "ss02", "ss03",
  "ss04", "ss05", "ss06",
  "ss07", "ss08",
}

function M.setup(config)
	config.font_size = 14
	config.font = wezterm.font({
		family = font.neon,
		weight = "Regular",
		harfbuzz_features = all_features,
	})
	config.font_rules = {
		{ -- Italic (comments)
			italic = true,
			font = wezterm.font({
				family = font.krypton,
				weight = "ExtraLight",
				harfbuzz_features = all_features,
				italic = false,
			}),
		},
		{
			intensity = "Bold",
			italic = true,
			font = wezterm.font({
				family = font.xenon,
				harfbuzz_features = all_features,
				weight = "Regular",
				italic = false,
			}),
		},
	}
end
return M
