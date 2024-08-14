local M = {}

function M.setup(config)
	config.color_scheme = "Catppuccin Mocha"
	config.colors = {
		background = "#2c2a2e",
		tab_bar = {
			background = "#161616",
			active_tab = {
				bg_color = "#2c2a2e",
				fg_color = "#f2f4f8",
				intensity = "Normal",
				italic = false,
				strikethrough = false,
				underline = "None",
			},
			inactive_tab = {
				bg_color = "#161616",
				fg_color = "#525252",
				intensity = "Half",
				italic = false,
				strikethrough = false,
				underline = "None",
			},
			new_tab = {
				bg_color = "#161616",
				fg_color = "#161616",
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
