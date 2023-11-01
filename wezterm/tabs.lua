local wezterm = require("wezterm")

local M = {}
M.home_dir = os.getenv("HOME")

M.filetype = {
	rust = { { Foreground = { Color = "#f5a97f" } }, { Text = "" } },
	nvim = { { Foreground = { Color = "#89e051" } }, { Text = wezterm.nerdfonts.custom_vim } },
	python = { { Foreground = { Color = "#F7CE57" } }, { Text = "" } },
	git = { Foreground = { Color = "#41535b" }, { Text = "󰊢" } },
	shell = { { Foreground = { Color = "#cdd6f4" } }, { Text = "" } },
}

M.icons = {
	["nvim"] = M.filetype.nvim,
	["git"] = M.filetype.git,
	["Python"] = M.filetype.python,
	["fish"] = M.filetype.shell,
	["zsh"] = M.filetype.shell,
	["bash"] = M.filetype.shell,
	["cargo-watch"] = M.filetype.rust,
	["cargo-make"] = M.filetype.rust,
	["cargo"] = M.filetype.rust,
	["cr"] = M.filetype.rust,
	["ct"] = M.filetype.rust,
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

	local active_bg = config.colors.tab_bar.active_tab.bg_color
	local inactive_bg = config.colors.tab_bar.inactive_tab.bg_color
	local arrow_solid = ""
	local arrow_thin = ""
	local tab_idx

	---@diagnostic disable-next-line: unused-local
	wezterm.on("format-tab-title", function(tab, tabs, panes, _config, hover, max_width)
		for i, t in ipairs(tabs) do
			if t.tab_id == tab.tab_id then
				tab_idx = i
				break
			end
		end

		local title = tab_idx < 5 and string.format(" %s  %s ", M.process(tab), M.cwd(tab))
			or string.format("%s %s ", tab_idx, M.process(tab))

		local next_tab = tabs[tab_idx + 1]
		local next_is_active = next_tab and next_tab.is_active
		local arrow_bg = inactive_bg
		local arrow_fg = "#313244"

		if tab.is_active then
			arrow_fg = active_bg
		elseif next_is_active then
			arrow_fg = inactive_bg
			arrow_bg = active_bg
		end

		return {
			{ Attribute = { Intensity = tab.is_active and "Bold" or "Normal" } },
			{ Text = title },
			{ Foreground = { Color = arrow_fg } },
			{ Background = { Color = arrow_bg } },
			{ Text = (tab.is_active or next_is_active) and arrow_solid or arrow_thin },
		}
	end)
end

return M
