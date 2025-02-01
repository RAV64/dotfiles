-------------------------------------------------------
-- Local References
-------------------------------------------------------
local vapi = vim.api
local vapi_mode = vapi.nvim_get_mode
local vbo = vim.bo
local vb = vim.b
local diag_get = vim.diagnostic.get
local gbit = bit
local lshift = gbit.lshift
local bor = gbit.bor

-- Commonly used string constants
local space = " "
local empty = ""
local sLine = "%#StatusLine#"
local spacedSLine = space .. sLine .. space
local sModePrefix = "%#StatuslineMode"
local dErr = "%#StatusLineRed# ✖ "
local dWarn = "%#StatusLineYellow#  "
local dHint = "%#StatusLineGreen#  "
local dInfo = "%#StatusLineBlue#  "
local gYellow = "%#StatusLineYellow# ~"
local gGreen = "%#StatusLineGreen# +"
local gRed = "%#StatusLineRed# -"
local gitDelimiter = sLine .. "%="
local gitSymbol = gitDelimiter .. "  "
local filePH = " %f %3l:%-2c %r%m"

-- Diagnostic + Git bitpack caches
local last_diag_pack = 0
local last_git_pack = 0
local last_git_head = nil

-- Mode lookup table
-- stylua: ignore
local mode_to_str = {
	["n"] = "NOR", ["no"] = "OP-", ["nov"] = "OP-", ["noV"] = "OP-", ["no\22"] = "OP-",
	["niI"] = "NOR", ["niR"] = "NOR", ["niV"] = "NOR", ["nt"] = "NOR", ["ntT"] = "NOR",
	["v"] = "VIS", ["vs"] = "VIS", ["V"] = "VIS", ["Vs"] = "VIS", ["\22"] = "VIS",
	["\22s"] = "VIS", ["s"] = "SEL", ["S"] = "SEL", ["\19"] = "SEL", ["i"] = "INS",
	["ic"] = "INS", ["ix"] = "INS", ["R"] = "REP", ["Rc"] = "REP", ["Rx"] = "REP",
	["Rv"] = "VIR", ["Rvc"] = "VIR", ["Rvx"] = "VIR", ["c"] = "COM", ["cv"] = "VIM",
	["ce"] = "EX ", ["r"] = "PRO", ["rm"] = "MOR", ["r?"] = "CON", ["!"] = "SHE",
	["t"] = "TER",
}
local _unk = "UNK"
local unk = function(v)
	vim.notify("Unknown ft: " .. v)
	return _unk
end

-- Filetype Icons (cached)
local icons = require("mini.icons")
local custom_icons = { filetype = {} }
local _icon_cache = {}
local function cached_icon(ft)
	local c = _icon_cache[ft]
	if c then
		return c
	end
	local i = icons.get("filetype", ft) or custom_icons.filetype[ft] or ft
	_icon_cache[ft] = i
	return i
end

-- Caches
local git_str = gitDelimiter
local diag_str = empty

local last_ft = nil
local last_ft_icon = empty
local last_mode = empty
local last_mode_str = empty
local last_prefix = empty
local last_statusline = nil
local last_suffix = empty

local new_mode = empty

function _G.st()
	return last_statusline
end

vim.o.statusline = "%{%v:lua.st()%}"

local redraw = function()
	vim.cmd("redrawstatus")
end

local update_status = function()
	last_statusline = last_prefix .. last_suffix
	redraw()
end

local update_prefix = function()
	last_prefix = last_mode_str .. space .. last_ft_icon .. filePH
	update_status()
end

local update_suffix = function()
	last_suffix = diag_str .. git_str
	update_status()
end

-------------------------------------------------------
-- Force immediate redraw on relevant events
-------------------------------------------------------
local update_diag = function()
	------------------------------------------------------------------
	-- Only check if *not* Insert mode (105 == 'i')
	------------------------------------------------------------------
	if new_mode:byte(1) ~= 105 then
		local dlist = diag_get(0)
		if #dlist ~= 0 then
			local d_e, d_w, d_h, d_i = 0, 0, 0, 0
			for idx = 1, #dlist do
				local sev = dlist[idx].severity
				if sev == 1 then
					d_e = d_e + 1
				elseif sev == 2 then
					d_w = d_w + 1
				elseif sev == 3 then
					d_i = d_i + 1
				else
					d_h = d_h + 1
				end
			end
			local dp = bor(lshift(d_e, 24), lshift(d_w, 16), lshift(d_h, 8), d_i)
			if dp ~= last_diag_pack then
				last_diag_pack = dp
				diag_str = ((d_e > 0) and (dErr .. d_e) or empty)
					.. ((d_w > 0) and (dWarn .. d_w) or empty)
					.. ((d_h > 0) and (dHint .. d_h) or empty)
					.. ((d_i > 0) and (dInfo .. d_i) or empty)
				update_suffix()
			end
		else
			-- If there are no diagnostics, but we had some before, reset
			if last_diag_pack ~= 0 then
				last_diag_pack = 0
				diag_str = empty
				update_suffix()
			end
		end
	end
end

local update_git = function()
	local g = vb.gitsigns_status_dict
	if g then
		-- If there's Git info, build/update pack
		local g_h = g.head or empty
		local g_a = g.added or 0
		local g_c = g.changed or 0
		local g_r = g.removed or 0
		local gp = bor(lshift(g_a, 16), lshift(g_c, 8), g_r)
		if (g_h ~= last_git_head) or (gp ~= last_git_pack) then
			last_git_pack = gp
			last_git_head = g_h
			git_str = gitSymbol
				.. g_h
				.. ((g_a > 0) and (gGreen .. g_a) or empty)
				.. ((g_c > 0) and (gYellow .. g_c) or empty)
				.. ((g_r > 0) and (gRed .. g_r) or empty)
				.. space
			update_suffix()
		end
	else
		if (last_git_pack ~= 0) or (last_git_head ~= nil) or (git_str ~= empty) then
			last_git_pack = 0
			last_git_head = nil
			git_str = gitDelimiter .. space
			update_suffix()
		end
	end
end

local update_mode = function()
	new_mode = vapi_mode().mode
	-- Mode changed?
	if new_mode ~= last_mode then
		last_mode = new_mode
		local short_mode = mode_to_str[new_mode] or unk(new_mode)
		last_mode_str = sModePrefix .. short_mode .. "# " .. short_mode .. spacedSLine
		update_diag()
		update_prefix()
	end
end

local update_filetype = function()
	if vbo.filetype ~= last_ft then
		last_ft = vbo.filetype
		last_ft_icon = cached_icon(last_ft)
		update_prefix()
	end
end

local full_update = function()
	update_mode()
	update_filetype()
	update_diag()
	update_git()
end

vim.api.nvim_create_autocmd("DiagnosticChanged", {
	callback = update_diag,
})

vim.api.nvim_create_autocmd("User", {
	pattern = "GitSignsUpdate",
	callback = update_git,
})

vim.api.nvim_create_autocmd("ModeChanged", {
	callback = update_mode,
})

vim.api.nvim_create_autocmd("BufEnter", {
	callback = full_update,
})

full_update()
