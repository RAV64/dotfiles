local mode = "i"
local opts = { expr = true, noremap = true, replace_keycodes = false }

local function escape(s)
	return vim.api.nvim_replace_termcodes(s, true, true, true)
end

local left = escape("<C-g>U") .. escape("<left>")

local function insert_pair(open, close)
	local v = open .. close .. left
	return function()
		return v
	end
end

local function insert_pair_with_check(open, close)
	local pairs = insert_pair(open, close)()
	return function()
		local col = vim.api.nvim_win_get_cursor(0)[2]
		local line = vim.api.nvim_get_current_line()
		local next_char = line:sub(col + 1, col + 1)

		if next_char == close then
			return open
		else
			return pairs
		end
	end
end

function Autopairs(pairs)
	for _, pair in ipairs(pairs) do
		local open_char = pair.char.open
		local close_char = pair.char.close

		if pair.check_next then
			vim.keymap.set(mode, open_char, insert_pair_with_check(open_char, close_char), opts)
		else
			vim.keymap.set(mode, open_char, insert_pair(open_char, close_char), opts)
		end
	end
end

Autopairs({
	{ char = { open = "(", close = ")" }, check_next = false },
	{ char = { open = "[", close = "]" }, check_next = false },
	{ char = { open = "{", close = "}" }, check_next = false },
	{ char = { open = "<", close = ">" }, check_next = false },
	{ char = { open = '"', close = '"' }, check_next = false },
	{ char = { open = "`", close = "`" }, check_next = false },
})
