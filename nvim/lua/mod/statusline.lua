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
local sLine = "%#StatusLine#"
local sModePrefix = "%#StatuslineMode"
local dErr = "%#StatusLineRed# ✖ "
local dWarn = "%#StatusLineYellow#  "
local dHint = "%#StatusLineBlue#  "
local dInfo = "%#StatusLineBlue#  "
local gYellow = "%#StatusLineYellow# ~"
local gGreen = "%#StatusLineGreen# +"
local gRed = "%#StatusLineRed# -"
local gitSymbol = "  "
local space = " "
local empty = ""
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
local last_mode = empty
local last_mode_str = nil
local last_ft = nil
local last_ft_icon = nil
local last_diag_str = empty
local last_git_str = empty
local last_prefix = empty
local last_suffix = empty
local last_statusline = nil

local new_mode = empty
local new_ft = nil
local prefix_changed = true
local suffix_changed = true

-------------------------------------------------------
-- The Single Statusline Function
-------------------------------------------------------
function _G.st()
	-- STEP 0: Precompute new mode & filetype
	new_mode = vapi_mode().mode
	new_ft = vbo.filetype

	------------------------------------------------------------------
	-- STEP 1: Check if all are the same (fast path).
	------------------------------------------------------------------
	if not suffix_changed and (new_mode == last_mode) and (new_ft == last_ft) then
		return last_statusline
	end

	------------------------------------------------------------------
	-- STEP 2: We have changes, figure out which parts to rebuild
	------------------------------------------------------------------

	-- Mode changed?
	if new_mode ~= last_mode then
		last_mode = new_mode
		local short_mode = mode_to_str[new_mode] or "UNK"
		last_mode_str = sModePrefix .. short_mode .. "# " .. short_mode .. space .. sLine
		prefix_changed = true
	end

	-- Filetype changed?
	if new_ft ~= last_ft then
		last_ft = new_ft
		last_ft_icon = cached_icon(new_ft)
		prefix_changed = true
	end

	-- Rebuild prefix if needed
	if prefix_changed then
		last_prefix = last_mode_str .. space .. last_ft_icon .. filePH
		prefix_changed = false
	end

	-- Rebuild suffix if needed
	if suffix_changed then
		last_suffix = last_diag_str .. sLine .. "%=" .. last_git_str .. space
		suffix_changed = false
	end

	last_statusline = last_prefix .. last_suffix
	return last_statusline
end

vim.o.statusline = "%{%v:lua.st()%}"

-------------------------------------------------------
-- Force immediate redraw on relevant events
-------------------------------------------------------
-- Whenever diagnostics change, or Gitsigns updates, redraw immediately:
vim.api.nvim_create_autocmd("DiagnosticChanged", {
	callback = function()
		------------------------------------------------------------------
		-- Only check if *not* Insert mode (105 == 'i')
		------------------------------------------------------------------
		if new_mode:byte(1) ~= 105 then
			local dlist = diag_get(0)
			if #dlist ~= 0 then
				-- Count severity in one pass
				local e, w, h, i_ = 0, 0, 0, 0
				for idx = 1, #dlist do
					local sev = dlist[idx].severity
					if sev == 1 then
						e = e + 1
					elseif sev == 2 then
						w = w + 1
					elseif sev == 3 then
						i_ = i_ + 1
					else
						h = h + 1
					end
				end
				local dp = bor(lshift(e, 24), lshift(w, 16), lshift(h, 8), i_)
				if dp ~= last_diag_pack then
					last_diag_pack = dp
					last_diag_str = ((e > 0) and (dErr .. e) or empty)
						.. ((w > 0) and (dWarn .. w) or empty)
						.. ((h > 0) and (dHint .. h) or empty)
						.. ((i_ > 0) and (dInfo .. i_) or empty)
					suffix_changed = true
					vim.cmd("redrawstatus")
				end
			else
				-- If there are no diagnostics, but we had some before, reset
				if last_diag_pack ~= 0 then
					last_diag_pack = 0
					last_diag_str = empty
					suffix_changed = true
					vim.cmd("redrawstatus")
				end
			end
		end
	end,
})

vim.api.nvim_create_autocmd("User", {
	pattern = "GitSignsUpdate",
	callback = function()
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
				last_git_str = gitSymbol
					.. g_h
					.. ((g_a > 0) and (gGreen .. g_a) or empty)
					.. ((g_c > 0) and (gYellow .. g_c) or empty)
					.. ((g_r > 0) and (gRed .. g_r) or empty)
				suffix_changed = true
				vim.cmd("redrawstatus")
			end
		else
			-- If we've moved to a buffer with no Git info, but previously had it
			if (last_git_pack ~= 0) or (last_git_head ~= nil) or (last_git_str ~= empty) then
				last_git_pack = 0
				last_git_head = nil
				last_git_str = empty
				suffix_changed = true
				vim.cmd("redrawstatus")
			end
		end
	end,
})
