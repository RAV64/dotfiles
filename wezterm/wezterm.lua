local wezterm = require("wezterm")

return {
	default_cursor_style = "BlinkingUnderline",
	font = wezterm.font("JetBrainsMono Nerd Font Mono"),
	send_composed_key_when_left_alt_is_pressed = true,
	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},
	enable_tab_bar = true,
	hide_tab_bar_if_only_one_tab = true,
	show_tab_index_in_tab_bar = false,
	window_close_confirmation = "NeverPrompt",
	color_scheme = "Catppuccin Mocha",
	window_decorations = "RESIZE",

}
