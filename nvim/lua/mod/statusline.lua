local vapi = vim.api
local diagnostic = vim.diagnostic
local sev = diagnostic.severity
local vapi_mode = vapi.nvim_get_mode
local vbo = vim.bo
local vb = vim.b
local gbit = bit
local lshift = gbit.lshift
local bor = gbit.bor

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
local gitDelimiter = sLine .. "%=" .. "%{SearchStatus()}"
local gitSymbol = gitDelimiter .. "  "
local filePH = "%f %3l:%-2c %r%m"

local last_diag_pack = 0
local last_git_pack = 0
local last_git_head = nil

local mode_to_str = {
	["n"] = "NOR",
	["niI"] = "NOR",
	["niR"] = "NOR",
	["niV"] = "NOR",
	["nt"] = "NOR",
	["v"] = "VIS",
	["V"] = "VIS",
	["\22"] = "VIS",
	["i"] = "INS",
	["ic"] = "INS",
	["ix"] = "INS",
	["c"] = "COM",
	["t"] = "COM",
}

local icons = require("mini.icons")
local function ft_icon(ft)
	return icons.get("filetype", ft)
end

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

-- local gitDelimiter = sLine .. "%=" .. "%{v:hlsearch ? v:lua.SearchStatus() : ''}"
-- _G.SearchStatus = function()
-- 	local sc = vim.fn.searchcount({ recompute = 1, maxcount = 0 })
-- 	return string.format("[%d/%d]", sc.current, sc.total)
-- end

vim.cmd([[
function! SearchStatus() abort
  if !v:hlsearch
    return ''
  endif
  let sc = searchcount({'recompute': 1, 'maxcount': 0})
  return printf(
        \ '[%d/%d]',
        \ get(sc, 'current', 0),
        \ get(sc, 'total',   0)
        \ )
endfunction
]])

vim.o.statusline = "%{%v:lua.st()%}"

local redraw = function()
	vim.cmd("redrawstatus")
end

local update_status = function()
	last_statusline = last_prefix .. last_suffix
	redraw()
end

local update_prefix = function()
	last_prefix = last_mode_str .. filePH
	update_status()
end

local update_suffix = function()
	last_suffix = diag_str .. git_str
	update_status()
end

local update_diag = function()
	if new_mode:byte(1) == 105 then -- 'i'
		return
	end

	local counts = diagnostic.count(0)
	if not counts then
		return
	end
	local d_e = counts[sev.ERROR] or 0
	local d_w = counts[sev.WARN] or 0
	local d_h = counts[sev.HINT] or 0
	local d_i = counts[sev.INFO] or 0

	local dp = bor(lshift(d_e, 24), lshift(d_w, 16), lshift(d_h, 8), d_i)
	if dp == last_diag_pack then
		return
	end
	last_diag_pack = dp

	if dp == 0 then
		diag_str = empty
	else
		diag_str = ((d_e > 0) and (dErr .. d_e) or empty)
			.. ((d_w > 0) and (dWarn .. d_w) or empty)
			.. ((d_h > 0) and (dHint .. d_h) or empty)
			.. ((d_i > 0) and (dInfo .. d_i) or empty)
	end
	update_suffix()
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

local update_mode = function(force)
	new_mode = vapi_mode().mode
	if force or new_mode ~= last_mode then
		last_mode = new_mode
		local short_mode = mode_to_str[new_mode] or "UNK"
		last_mode_str = sModePrefix .. short_mode .. "# " .. last_ft_icon .. spacedSLine
		update_prefix()
	end
end

local update_filetype = function()
	if vbo.filetype ~= last_ft then
		last_ft = vbo.filetype
		last_ft_icon = ft_icon(last_ft)
		update_prefix()
	end
end

local full_update = function()
	update_filetype()
	update_mode(true)
	update_diag()
	update_git()
end

vim.api.nvim_create_autocmd("DiagnosticChanged", {
	callback = update_diag,
})

vim.api.nvim_create_autocmd("InsertLeave", {
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
