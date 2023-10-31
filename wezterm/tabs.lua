local wezterm = require("wezterm")

local M = {}
M.arrow_solid = ""
M.arrow_thin = ""
M.home_dir = os.getenv("HOME")

M.filetype = {
	["rust"] = { { Foreground = { Color = "#f5a97f" } }, { Text = "" } },
}

M.icons = {
	["nvim"] = { { Foreground = { Color = "#89e051" } }, { Text = wezterm.nerdfonts.custom_vim } },
	["git"] = { Foreground = { Color = "#41535b" }, { Text = "󰊢" } },
	["Python"] = { { Foreground = { Color = "#F7CE57" } }, { Text = "" } },
	["fish"] = { { Foreground = { Color = "#cdd6f4" } }, { Text = "" } },
	["cargo-watch"] = M.filetype["rust"],
	["cargo"] = M.filetype["rust"],
	["cr"] = M.filetype["rust"],
	["ct"] = M.filetype["rust"],
	["mdbook"] = { { Text = "" } },
	["watch"] = { { Text = "󰜎" } },
}
function M.basename(s)
	return string.gsub(s, "(.*/)(.*)", "%2")
end

function M.process(tab)
	local process_name = M.basename(tab.active_pane.foreground_process_name)
	return wezterm.format(M.icons[process_name] or { { Text = string.format("%s:", process_name) } })
end

function M.cwd(tab)
	local current_dir = tab.active_pane.current_working_dir.file_path

	if current_dir == M.home_dir then
		return "~"
	end

	return M.basename(current_dir)
end

function M.setup(config)
	config.use_fancy_tab_bar = false
	config.tab_bar_at_bottom = true
	config.hide_tab_bar_if_only_one_tab = true
	config.tab_max_width = 64
	config.unzoom_on_switch_pane = true
	config.show_tab_index_in_tab_bar = false
	config.show_new_tab_button_in_tab_bar = false

	wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
		local colors = config.resolved_palette
		local active_bg = colors.tab_bar.active_tab.bg_color
		local inactive_bg = colors.tab_bar.inactive_tab.bg_color

		local tab_idx
		for i, t in ipairs(tabs) do
			if t.tab_id == tab.tab_id then
				tab_idx = i
				break
			end
		end

		local title = #tabs < 7 and string.format(" %s  %s ", M.process(tab), M.cwd(tab))
			or tab.is_active and string.format(" %s  %s ", M.process(tab), M.cwd(tab))
			or string.format("%s %s ", tab_idx, M.process(tab))

		local is_last = tab_idx == #tabs
		local next_tab = tabs[tab_idx + 1]
		local next_is_active = next_tab and next_tab.is_active
		local arrow = (tab.is_active or is_last or next_is_active) and M.arrow_solid or M.arrow_thin
		local arrow_bg = inactive_bg
		local arrow_fg = colors.tab_bar.inactive_tab_edge

		if is_last then
			arrow_fg = tab.is_active and active_bg or inactive_bg
		elseif tab.is_active then
			arrow_fg = active_bg
		elseif next_is_active then
			arrow_bg = active_bg
			arrow_fg = inactive_bg
		end

		return {
			{ Attribute = { Intensity = tab.is_active and "Bold" or "Normal" } },
			{ Text = title },
			{ Foreground = { Color = arrow_fg } },
			{ Background = { Color = arrow_bg } },
			{ Text = arrow },
		}
	end)
end

return M
