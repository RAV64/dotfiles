local pair_map = {
	["("] = ")",
	["["] = "]",
	["{"] = "}",
	["<"] = ">",
	['"'] = '"',
}

local api = vim.api
local keymap = vim.keymap.set

local function termcodes(str)
	return api.nvim_replace_termcodes(str, true, true, true)
end

local BS_SEQ = termcodes("<BS>")
local DEL_SEQ = termcodes("<Del>")
local UNDO_LFT = termcodes("<C-g>U<Left>")
local SPREAD_PAIRS = termcodes("<Esc>O")

local function get_col()
	return api.nvim_win_get_cursor(0)[2]
end

local function char_at(col)
	return api.nvim_get_current_line():sub(col, col)
end

local function should_pair()
	local next_char = char_at(get_col() + 1)
	return not next_char:match("%w")
end

for open, close in pairs(pair_map) do
	keymap("i", open, function()
		if char_at(get_col()) == "\\" or not should_pair() then
			return open
		end
		return open .. close .. UNDO_LFT
	end, { expr = true, noremap = true, replace_keycodes = false })
end

local function skip_if_closer(key, skip_seq, default_seq)
	keymap("i", key, function()
		local col = get_col()
		local cur = char_at(col)
		local nxt = char_at(col + 1)
		if pair_map[cur] == nxt then
			return skip_seq()
		end
		return default_seq
	end, { expr = true, noremap = true, replace_keycodes = false })
end

skip_if_closer("<BS>", BS_SEQ .. DEL_SEQ, BS_SEQ)
skip_if_closer("<CR>", "\r" .. SPREAD_PAIRS, "\r")
