local wezterm = require("wezterm")
local M = {}

local font = {
	neon = "Monaspace Neon",
	argon = "Monaspace Argon",
	xenon = "Monaspace Xenon",
	radon = "Monaspace Radon",
	krypton = "Monaspace Krypton",
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
			}),
		},
	}
end
return M
