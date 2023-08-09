local wezterm = require("wezterm")

return {
	default_cursor_style = "BlinkingUnderline",
	font = wezterm.font("JetBrains Mono"),
	font_size = 12.5,
	line_height = 0.9,

	send_composed_key_when_left_alt_is_pressed = true,
	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},
	enable_tab_bar = true,
	show_tab_index_in_tab_bar = false,
	window_close_confirmation = "NeverPrompt",
	color_scheme = "Catppuccin Mocha",
	colors = {
		background = "#202020",
		tab_bar = {
			background = "#262626",
			active_tab = {
				bg_color = "#161616",
				fg_color = "#ffffff",
				intensity = "Normal",
				italic = false,
				strikethrough = false,
				underline = "None",
			},
			inactive_tab = {
				bg_color = "#262626",
				fg_color = "#ffffff",
				intensity = "Normal",
				italic = false,
				strikethrough = false,
				underline = "None",
			},
			new_tab = {
				bg_color = "#262626",
				fg_color = "#ffffff",
				intensity = "Normal",
				italic = false,
				strikethrough = false,
				underline = "None",
			},
		},
	},
	use_fancy_tab_bar = false,
	window_decorations = "RESIZE",
	hide_tab_bar_if_only_one_tab = true,
	window_background_opacity = 0.9,
	text_background_opacity = 1.0,
}
