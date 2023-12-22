local wezterm = require("wezterm")

local M = {}
local home_dir = os.getenv("HOME")
local fmt = wezterm.format

local process_icon = {
	rust = { { Foreground = { Color = "#f5a97f" } }, { Text = "   " } },
	vim = { { Foreground = { Color = "#89e051" } }, { Text = "   " } },
	git = { Foreground = { Color = "#41535b" }, { Text = " 󰊢  " } },
	python = { { Foreground = { Color = "#F7CE57" } }, { Text = "   " } },
	shell = { { Foreground = { Color = "#cdd6f4" } }, { Text = "   " } },
	runner = { { Foreground = { Color = "#b4befe" } }, { Text = " 󰜎  " } },
	docs = { { Text = "   " } },
	node = { { Foreground = { Color = "#89e051" } }, { Text = " 󰎙  " } },
	update = { { Text = "   " } },
	brew = { { Text = " 󱄖  " } },
}

local icons = {
	["nvim"] = process_icon.vim,
	["git"] = process_icon.git,
	["lazygit"] = process_icon.git,
	["Python"] = process_icon.python,
	["fish"] = process_icon.shell,
	["zsh"] = process_icon.shell,
	["bash"] = process_icon.shell,
	["cargo-make"] = process_icon.rust,
	["cargo"] = process_icon.rust,
	["rustup"] = process_icon.rust,
	["rust-analyzer"] = process_icon.rust,
	["cr"] = process_icon.rust,
	["ct"] = process_icon.rust,
	["mdbook"] = process_icon.docs,
	["cargo-watch"] = process_icon.runner,
	["watch"] = process_icon.runner,
	["node"] = process_icon.node,
	["ruby"] = process_icon.brew,
}

local process_name_cache = {}
local current_dir_cache = {
	[home_dir] = "~ ",
	DEBUG = " ",
}

local function cwd_cacher(name)
	current_dir_cache[name] = name:match("[^/]*$") .. " "
	return current_dir_cache[name]
end

local function ps_cacher(name)
	process_name_cache[name] = fmt(icons[name:match("[^/]*$")] or { { Text = name:match("[^/]*$") .. " " } })
	return process_name_cache[name]
end

local function ps(tab)
	return process_name_cache[tab.active_pane.foreground_process_name]
		or ps_cacher(tab.active_pane.foreground_process_name)
end

local function cwd(tab)
	local dir = tab.active_pane.current_working_dir
	return current_dir_cache[dir and dir.file_path or "DEBUG"]
		or cwd_cacher(tab.active_pane.current_working_dir.file_path)
end

function M.setup(config)
	config.use_fancy_tab_bar = false
	config.tab_bar_at_bottom = true
	config.hide_tab_bar_if_only_one_tab = true
	config.tab_max_width = 32
	config.unzoom_on_switch_pane = true
	config.show_tab_index_in_tab_bar = false
	config.show_new_tab_button_in_tab_bar = false

	local active_bg = config.colors.tab_bar.active_tab.bg_color
	local inactive_bg = config.colors.tab_bar.inactive_tab.bg_color

	---@diagnostic disable-next-line: unused-local
	wezterm.on("format-tab-title", function(tab, tabs, panes, _config, hover, max_width)
		for i = 1, #tabs do
			if tabs[i].tab_id == tab.tab_id then
				if tab.is_active then
					return {
						{ Attribute = { Intensity = "Bold" } },
						{ Text = i < 5 and ps(tab) .. cwd(tab) or i .. ps(tab) },
						{ Foreground = { Color = active_bg } },
						{ Background = { Color = inactive_bg } },
						{ Text = "" },
					}
				elseif tabs[i + 1] and tabs[i + 1].is_active then
					return {
						{ Attribute = { Intensity = "Normal" } },
						{ Text = i < 5 and ps(tab) .. cwd(tab) or i .. ps(tab) },
						{ Foreground = { Color = inactive_bg } },
						{ Background = { Color = active_bg } },
						{ Text = "" },
					}
				else
					return {
						{ Attribute = { Intensity = "Normal" } },
						{ Text = i < 5 and ps(tab) .. cwd(tab) or i .. ps(tab) },
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
