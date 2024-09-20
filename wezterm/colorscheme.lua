local M = {}

function M.setup(config)
	config.colors = {
		background = "#2C2A2E",

		brights = {
			"#f2cdcd", -- "grey",
			"#ff6188", -- "red",
			"#a8dc76", -- "lime",
			"#ffd966", -- "yellow",
			"#82A6ED", -- "blue",
			"#D499FF", -- "fuchsia",
			"#94e2d5", -- "aqua",
			"#FCFCFA", -- "white",
		},

		ansi = {
			"#f2cdcd",
			"#ff6188",
			"#a8dc76",
			"#ffd966",
			"#82A6ED",
			"#D499FF",
			"#94e2d5",
			"#FCFCFA",
		},

		tab_bar = {
			background = "#1F1D20",
			active_tab = {
				bg_color = "#2C2A2E",
				fg_color = "#FCFCFA",
				intensity = "Normal",
				italic = false,
				strikethrough = false,
				underline = "None",
			},
			inactive_tab = {
				bg_color = "#1F1D20",
				fg_color = "#525252",
				intensity = "Half",
				italic = false,
				strikethrough = false,
				underline = "None",
			},
			new_tab = {
				bg_color = "#1F1D20",
				fg_color = "#1F1D20",
				intensity = "Normal",
				italic = false,
				strikethrough = false,
				underline = "None",
			},
		},
	}
	config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
end
return M
