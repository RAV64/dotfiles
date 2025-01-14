--------------------------------------------------------------------------------
-- Setup
--------------------------------------------------------------------------------
local mode = "i"
local _opts = { expr = true, noremap = true, replace_keycodes = false }

local function escape(s)
	return vim.api.nvim_replace_termcodes(s, true, true, true)
end

local BS = escape("<BS>")
local DEL = escape("<Del>")
local LEFT = escape("<C-g>U") .. escape("<left>")
local ESCO = escape("<Esc>O")

--------------------------------------------------------------------------------
-- Pair Insertion
--------------------------------------------------------------------------------
-- Inserts `open..close` and moves the cursor left inside them
local function insert_pair(open, close)
	local v = open .. close .. LEFT
	return function()
		return v
	end
end

-- If the next char is already a matching closer, only insert `open`;
-- otherwise insert the full pair.
local function insert_pair_with_check(open, close)
	local full_pair = insert_pair(open, close)()
	return function()
		local col = vim.api.nvim_win_get_cursor(0)[2]
		local line = vim.api.nvim_get_current_line()
		local next_char = line:sub(col + 1, col + 1)

		if next_char == close then
			return open
		else
			return full_pair
		end
	end
end

--------------------------------------------------------------------------------
-- Main Autopairs Function
--------------------------------------------------------------------------------
local function autopairs(pairs)
	local pair_map = {}

	for _, pair in ipairs(pairs) do
		local open_char = pair.char.open
		local close_char = pair.char.close
		pair_map[open_char] = close_char

		if pair.check_next then
			vim.keymap.set(mode, open_char, insert_pair_with_check(open_char, close_char), _opts)
		else
			vim.keymap.set(mode, open_char, insert_pair(open_char, close_char), _opts)
		end
	end

	local function get_pair_context()
		local col = vim.fn.col(".") - 1
		if col < 0 then
			return nil
		end
		local line = vim.fn.getline(".")
		local opener = line:sub(col, col)
		local closer = pair_map[opener]
		if not closer then
			return nil
		end
		local next_char = line:sub(col + 1, col + 1)
		return { closer = closer, next_char = next_char }
	end

	local function cool_func(fb, k)
		return function()
			local context = get_pair_context()
			if not context then
				return fb
			end
			if context.next_char == context.closer then
				return k
			end
			return fb
		end
	end

	vim.keymap.set(mode, "<BS>", cool_func(BS, BS .. DEL), _opts)
	vim.keymap.set(mode, "<CR>", cool_func("\r", "\r" .. ESCO), _opts)
end

--------------------------------------------------------------------------------
-- Register pairs
--------------------------------------------------------------------------------
local opts = {
	{ char = { open = "(", close = ")" }, check_next = false },
	{ char = { open = "[", close = "]" }, check_next = false },
	{ char = { open = "{", close = "}" }, check_next = false },
	{ char = { open = "<", close = ">" }, check_next = false },
	{ char = { open = '"', close = '"' }, check_next = false },
	{ char = { open = "`", close = "`" }, check_next = false },
}

autopairs(opts)
