local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.front_end = "WebGpu"
config.webgpu_power_preference = "HighPerformance"
config.animation_fps = 30
config.max_fps = 120

require("colorscheme").setup(config)
require("keys").setup(config)
require("tabs").setup(config)
require("fonts").setup(config)

config.default_cursor_style = "BlinkingUnderline"
config.force_reverse_video_cursor = true
config.cursor_thickness = 2

config.send_composed_key_when_left_alt_is_pressed = true
config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "RESIZE"
config.enable_scroll_bar = false

return config
