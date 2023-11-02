local wezterm = require("wezterm")

local M = {}
local home_dir = os.getenv("HOME")
local fmt = wezterm.format

local icons = {
	["nvim"] = { { Foreground = { Color = "#89e051" } }, { Text = wezterm.nerdfonts.custom_vim } },
	["git"] = { Foreground = { Color = "#41535b" }, { Text = "󰊢" } },
	["Python"] = { { Foreground = { Color = "#F7CE57" } }, { Text = "" } },
	["fish"] = { { Foreground = { Color = "#cdd6f4" } }, { Text = "" } },
	["zsh"] = { { Foreground = { Color = "#cdd6f4" } }, { Text = "" } },
	["bash"] = { { Foreground = { Color = "#cdd6f4" } }, { Text = "" } },
	["cargo-watch"] = { { Foreground = { Color = "#f5a97f" } }, { Text = "" } },
	["cargo-make"] = { { Foreground = { Color = "#f5a97f" } }, { Text = "" } },
	["cargo"] = { { Foreground = { Color = "#f5a97f" } }, { Text = "" } },
	["cr"] = { { Foreground = { Color = "#f5a97f" } }, { Text = "" } },
	["ct"] = { { Foreground = { Color = "#f5a97f" } }, { Text = "" } },
	["mdbook"] = { { Text = "" } },
	["watch"] = { { Text = "󰜎" } },
	["node"] = { { Foreground = { Color = "#89e051" } }, { Text = "󰎙" } },
}

local process_name_cache = {}
local current_dir_cache = {
	[home_dir] = "~",
}

local function cwd_b_c(name)
	current_dir_cache[name] = name:match("[^/]*$")
	return current_dir_cache[name]
end

local function process_b_c(name)
	process_name_cache[name] = fmt(icons[name:match("[^/]*$")])
	return process_name_cache[name]
end

local function process(tab)
	return process_name_cache[tab.active_pane.foreground_process_name]
		or process_b_c(tab.active_pane.foreground_process_name)
end

local function cwd(tab)
	return current_dir_cache[tab.active_pane.current_working_dir.file_path]
		or cwd_b_c(tab.active_pane.current_working_dir.file_path)
end

function M.setup(config)
	config.use_fancy_tab_bar = false
	config.tab_bar_at_bottom = true
	config.hide_tab_bar_if_only_one_tab = true
	config.tab_max_width = 32
	config.unzoom_on_switch_pane = true
	config.show_tab_index_in_tab_bar = false
	config.show_new_tab_button_in_tab_bar = false

	local active_bg <const> = config.colors.tab_bar.active_tab.bg_color
	local inactive_bg <const> = config.colors.tab_bar.inactive_tab.bg_color

	---@diagnostic disable-next-line: unused-local
	wezterm.on("format-tab-title", function(tab, tabs, panes, _config, hover, max_width)
		for i = 1, #tabs do
			if tabs[i].tab_id == tab.tab_id then
				if tab.is_active then
					return {
						{ Attribute = { Intensity = "Bold" } },
						{
							Text = i < 5 and " " .. process(tab) .. "  " .. cwd(tab) .. " "
								or i .. " " .. process(tab) .. " ",
						},
						{ Foreground = { Color = active_bg } },
						{ Background = { Color = inactive_bg } },
						{ Text = "" },
					}
				elseif tabs[i + 1] and tabs[i + 1].is_active then
					return {
						{ Attribute = { Intensity = "Normal" } },
						{
							Text = i < 5 and " " .. process(tab) .. "  " .. cwd(tab) .. " "
								or i .. " " .. process(tab) .. " ",
						},
						{ Foreground = { Color = inactive_bg } },
						{ Background = { Color = active_bg } },
						{ Text = "" },
					}
				else
					return {
						{ Attribute = { Intensity = "Normal" } },
						{
							Text = i < 5 and " " .. process(tab) .. "  " .. cwd(tab) .. " "
								or i .. " " .. process(tab) .. " ",
						},
						{ Foreground = { Color = "#313244" } },
						{ Background = { Color = inactive_bg } },
						{ Text = "" },
					}
				end
			end
		end
	end)
end

return M
