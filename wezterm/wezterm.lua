local wezterm = require("wezterm")

local config = {}
if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.default_cursor_style = "BlinkingUnderline"
config.font = wezterm.font({
	family = "Firacode Nerd Font",
	weight = "Regular",
})
config.font_size = 14
-- config.line_height = 1.1

config.send_composed_key_when_left_alt_is_pressed = true
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
config.enable_tab_bar = true
-- show_tab_index_in_tab_bar = false
config.window_close_confirmation = "NeverPrompt"
config.color_scheme = "Catppuccin Mocha"
config.colors = {
	background = "#202020",
	tab_bar = {
		background = "#161616",
		active_tab = {
			bg_color = "#202020",
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
config.use_fancy_tab_bar = false

config.tab_bar_at_bottom = true
-- config.freetype_load_target = "HorizontalLcd"

config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = true
config.window_background_opacity = 1.0
config.text_background_opacity = 1.0
config.enable_scroll_bar = false
config.keys = {
	{
		key = "-",
		mods = "CTRL",
		action = wezterm.action.SplitHorizontal({}),
	},
	{
		key = "-",
		mods = "CTRL|SHIFT",
		action = wezterm.action.SplitVertical({}),
	},
}

return config
