local M = {}

local mode_to_str = {
	["n"] = "NOR",
	["no"] = "OP-",
	["nov"] = "OP-",
	["noV"] = "OP-",
	["no\22"] = "OP-",
	["niI"] = "NOR",
	["niR"] = "NOR",
	["niV"] = "NOR",
	["nt"] = "NOR",
	["ntT"] = "NOR",
	["v"] = "VIS",
	["vs"] = "VIS",
	["V"] = "VIS",
	["Vs"] = "VIS",
	["\22"] = "VIS",
	["\22s"] = "VIS",
	["s"] = "SEL",
	["S"] = "SEL",
	["\19"] = "SEL",
	["i"] = "INS",
	["ic"] = "INS",
	["ix"] = "INS",
	["R"] = "REP",
	["Rc"] = "REP",
	["Rx"] = "REP",
	["Rv"] = "VIR",
	["Rvc"] = "VIR",
	["Rvx"] = "VIR",
	["c"] = "COM",
	["cv"] = "VIM",
	["ce"] = "EX ",
	["r"] = "PRO",
	["rm"] = "MOR",
	["r?"] = "CON",
	["!"] = "SHE",
	["t"] = "TER",
}

function M.mode_component()
	local mode = mode_to_str[vim.api.nvim_get_mode().mode] or "UNK"
	return string.format("%%#StatuslineMode%s# %s %%#StatusLine#", mode, mode)
end

---@return string
function M.git_component()
	local git = vim.b.gitsigns_status_dict
	if not git then
		return ""
	end

	local added = git.added and git.added > 0 and string.format("%%#StatusLineGreen# +%s", git.added) or ""
	local changed = git.changed and git.changed > 0 and string.format("%%#StatusLineYellow# ~%s", git.changed) or ""
	local removed = git.removed and git.removed > 0 and string.format("%%#StatusLineRed# -%s", git.removed) or ""

	return "  " .. table.concat({ git.head, added, changed, removed })
end

local last_diagnostic_component = ""
function M.diagnostics_component()
	if vim.startswith(vim.api.nvim_get_mode().mode, "i") then
		return last_diagnostic_component
	end

	local counts = vim.iter(vim.diagnostic.get(0)):fold({
		ERROR = 0,
		WARN = 0,
		HINT = 0,
		INFO = 0,
	}, function(acc, diagnostic)
		local severity = vim.diagnostic.severity[diagnostic.severity]
		acc[severity] = acc[severity] + 1
		return acc
	end)

	local error = counts.ERROR > 0 and string.format("%%#StatusLineRed# ✖ %s", counts.ERROR) or ""
	local warn = counts.WARN > 0 and string.format("%%#StatusLineYellow#  %s", counts.WARN) or ""
	local hint = counts.HINT > 0 and string.format("%%#StatusLineBlue#  %s", counts.HINT) or ""
	local info = counts.INFO > 0 and string.format("%%#StatusLineBlue#  %s", counts.INFO) or ""

	return table.concat({ error, warn, hint, info })
end

local icons = require("mini.icons")
local custom_icons = {}
custom_icons.filetype = {}

local _icon_cache = {}

local _cache_and_return = function(ft)
	local icon = icons.get("filetype", ft) or custom_icons.filetype[ft] or ft
	_icon_cache[ft] = icon
	return _icon_cache[ft]
end

local cached_icon = function(ft)
	return _icon_cache[ft] or _cache_and_return(ft)
end

function M.filetype_icon()
	return cached_icon(vim.bo.filetype)
end

function M.split()
	return "%="
end

function M.render()
	return table.concat({
		M.mode_component(),
		" ",
		M.filetype_icon(),
		" %f", -- Relative path to file from cwd
		" %3l:%-2c ",
		"%r", -- Readonly
		"%m", -- Modified
		M.diagnostics_component(),
		"%#StatusLine#",
		M.split(),
		M.git_component(),
		" ",
	})
end

vim.o.statusline = "%!v:lua.require'mod.statusline'.render()"

return M
