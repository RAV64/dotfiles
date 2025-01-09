---------------------------------------
-- Aggressive Single-Function Statusline
-- with cross-call caching.
---------------------------------------

-- Minimal references and upvalues
local vapi = vim.api
local vdiag = vim.diagnostic
local vbo = vim.bo
local vb = vim.b
local strsub = string.sub
local tconcat = table.concat

-- Predefine our caches
local last_mode = nil
local last_mode_str = nil

local last_ft = nil
local last_ft_icon = nil

-- Diagnostics
local last_diag_mode = nil -- so we know if we switched to/from insert
local last_diag_counts = { ERROR = 0, WARN = 0, HINT = 0, INFO = 0 }
local last_diag_str = ""

-- Git
local last_git_head = nil
local last_git_added = 0
local last_git_changed = 0
local last_git_removed = 0
local last_git_str = ""

-- Local tables
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

-- For filetype icons
local icons = require("mini.icons")
local custom_icons = { filetype = {} }
local _icon_cache = {}
local function cached_icon(ft)
	-- Check local cache
	local cached = _icon_cache[ft]
	if cached then
		return cached
	end
	local icon = icons.get("filetype", ft) or custom_icons.filetype[ft] or ft
	_icon_cache[ft] = icon
	return icon
end

-- The single statusline function
function _G.statusline()
	----------------------------------------------------
	-- 1) Mode component (cached)
	----------------------------------------------------
	local m = vapi.nvim_get_mode().mode
	if m ~= last_mode then
		last_mode = m
		local short_mode = mode_to_str[m] or "UNK"
		last_mode_str = "%#StatuslineMode" .. short_mode .. "# " .. short_mode .. " %#StatusLine#"
	end
	-- inline reference so we don't do multiple concatenations
	local mode_str = last_mode_str

	----------------------------------------------------
	-- 2) Filetype icon (cached)
	----------------------------------------------------
	local ft = vbo.filetype
	if ft ~= last_ft then
		last_ft = ft
		last_ft_icon = cached_icon(ft)
	end
	local ft_icon = last_ft_icon

	----------------------------------------------------
	-- 3) Diagnostics component (cached, partial logic)
	----------------------------------------------------
	local diag_str = last_diag_str
	if strsub(m, 1, 1) == "i" then
	-- In insert mode => return last cached diag
	else
		-- Only re-check if we previously were in insert or
		-- there might be an actual change in diagnostic data
		-- We do a forced re-check below, but you can make this more
		-- elaborate if you trust there’s no new diag in normal mode.
		local diags = vdiag.get(0)
		local counts = { ERROR = 0, WARN = 0, HINT = 0, INFO = 0 }
		for i = 1, #diags do
			local sevname = vdiag.severity[diags[i].severity] -- "ERROR","WARN", etc.
			counts[sevname] = counts[sevname] + 1
		end
		-- compare with last_diag_counts
		if
			(counts.ERROR ~= last_diag_counts.ERROR)
			or (counts.WARN ~= last_diag_counts.WARN)
			or (counts.HINT ~= last_diag_counts.HINT)
			or (counts.INFO ~= last_diag_counts.INFO)
			or (m ~= last_diag_mode)
		then
			-- Update the cache
			last_diag_mode = m
			last_diag_counts.ERROR = counts.ERROR
			last_diag_counts.WARN = counts.WARN
			last_diag_counts.HINT = counts.HINT
			last_diag_counts.INFO = counts.INFO

			local E = counts.ERROR > 0 and ("%#StatusLineRed# ✖ " .. counts.ERROR) or ""
			local W = counts.WARN > 0 and ("%#StatusLineYellow#  " .. counts.WARN) or ""
			local H = counts.HINT > 0 and ("%#StatusLineBlue#  " .. counts.HINT) or ""
			local I = counts.INFO > 0 and ("%#StatusLineBlue#  " .. counts.INFO) or ""
			diag_str = E .. W .. H .. I
			last_diag_str = diag_str
		end
	end

	----------------------------------------------------
	-- 4) Git component (cached)
	----------------------------------------------------
	local git_str = last_git_str
	local git = vb.gitsigns_status_dict
	if not git then
		-- no gitsigns => no display
		if last_git_str ~= "" then
			last_git_str = ""
			git_str = ""
			-- reset last git cache so next time we recompute if it reappears
			last_git_head = nil
			last_git_added = 0
			last_git_changed = 0
			last_git_removed = 0
		end
	else
		-- Compare old vs. new
		local head = git.head or ""
		local added = git.added or 0
		local changed = git.changed or 0
		local removed = git.removed or 0

		if
			(head ~= last_git_head)
			or (added ~= last_git_added)
			or (changed ~= last_git_changed)
			or (removed ~= last_git_removed)
		then
			-- Rebuild
			last_git_head = head
			last_git_added = added
			last_git_changed = changed
			last_git_removed = removed

			local ga = (added > 0) and ("%#StatusLineGreen# +" .. added) or ""
			local gc = (changed > 0) and ("%#StatusLineYellow# ~" .. changed) or ""
			local gr = (removed > 0) and ("%#StatusLineRed# -" .. removed) or ""

			last_git_str = "  " .. tconcat({ head, ga, gc, gr })
			git_str = last_git_str
		end
	end

	----------------------------------------------------
	-- 5) Final assembly
	----------------------------------------------------
	--   %f => filename
	--   %3l:%-2c => line/col
	--   %r => read-only
	--   %m => modified
	--
	--
	return mode_str .. " " .. ft_icon .. " %f %3l:%-2c %r%m" .. diag_str .. "%#StatusLine#%=" .. git_str .. " "
end

vim.api.nvim_create_autocmd("InsertEnter", {
	group = vim.api.nvim_create_augroup("user-update-statusline", { clear = true }),
	callback = function()
		vim.o.statusline = "%{%v:lua._G.statusline()%}"
	end,
})

vim.keymap.set("n", "X", function()
	UTIL.timer(_G.statusline)
end)

-- vim.o.statusline = "%!v:lua.require'mod.statusline'.render()"
vim.o.statusline = "%{%v:lua._G.statusline()%}"
