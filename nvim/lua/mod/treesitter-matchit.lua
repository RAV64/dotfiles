local api = vim.api
local ts = vim.treesitter
local fn = vim.fn

local AUGROUP = api.nvim_create_augroup("treesitter-matchit", {})

-- stylua: ignore
local MODES = {
	n = function() vim.cmd('execute "normal! \\<Plug>(MatchitNormalForward)"') end,
	x = function() vim.cmd('execute "normal! \\<Plug>(MatchitVisualForward)"') end,
	o = function() vim.cmd('execute "normal! \\<Plug>(MatchitOperationForward)"') end,
}

local FALLBACK = {
	attribute_value = true,
	block_comment = true,
	line_comment = true,
	string_content = true,
	string_fragment = true,
}

-- stylua: ignore
local PAIRS = {
	["("] = true, [")"] = true,
	["["] = true, ["]"] = true,
	["{"] = true, ["}"] = true,
	["<"] = true, [">"] = true,
	['"'] = true, ["'"] = true,
	["`"] = true,
}

local DISABLE_FT = {
	netrw = true,
}

local function get_node_range(node)
	local sr, sc, er, ec = node:range(false)
	if ec == 0 then
		ec = fn.col({ er, "$" }) - 1
	else
		ec = ec - 1
	end
	return sr, sc, er, ec
end

local function jump_to_node(node, to_end)
	local sr, sc, er, ec = get_node_range(node)
	if api.nvim_get_mode().mode == "no" then
		vim.cmd("normal! v")
	end
	if to_end then
		api.nvim_win_set_cursor(0, { er + 1, ec })
	else
		api.nvim_win_set_cursor(0, { sr + 1, sc })
	end
end

local function char_at_cursor()
	local r, c = unpack(api.nvim_win_get_cursor(0))
	local text = api.nvim_buf_get_text(0, r - 1, c, r - 1, c + 1, {})
	return text and text[1] or ""
end

local function match_ts_or_fallback(buf, fallback_fn)
	local ok, parser = pcall(ts.get_parser, buf)
	if not ok then
		return fallback_fn()
	end
	local r, c = unpack(api.nvim_win_get_cursor(0))
	local line = api.nvim_get_current_line()
	if #line > 0 then
		if c >= #line then
			c = #line - 1
		end
		while c > 0 and line:sub(c + 1, c + 1):match("%s") do
			c = c - 1
		end
		if line:sub(1, c + 1):match("^%s*$") then
			local p = line:find("%S")
			if p then
				c = p - 1
			end
		end
	end
	parser:parse({ r - 1, c })
	local root = parser:named_node_for_range({ r - 1, c, r - 1, c }, { ignore_injections = false })
	if not root or FALLBACK[root:type()] then
		return fallback_fn()
	end
	local head = root:child(0)
	local tail = root:child(root:child_count() - 1)
	if not head and not tail and PAIRS[char_at_cursor()] then
		local parent = root:parent()
		if parent then
			root = parent
			head = parent:child(0)
			tail = parent:child(parent:child_count() - 1)
		end
	end
	if head and tail and not head:equal(tail) then
		if ts.is_in_node_range(tail, r - 1, c) then
			jump_to_node(head, false)
		else
			jump_to_node(tail, true)
		end
	else
		local sr, sc, er, ec = get_node_range(root)
		if r - 1 == er and c == ec then
			api.nvim_win_set_cursor(0, { sr + 1, sc })
		else
			api.nvim_win_set_cursor(0, { er + 1, ec })
		end
	end
end

api.nvim_create_autocmd("FileType", {
	group = AUGROUP,
	pattern = "*",
	callback = function()
		local buf = api.nvim_get_current_buf()
		if DISABLE_FT[vim.bo[buf].ft] then
			return
		end
		for mode, fallback_fn in pairs(MODES) do
			vim.keymap.set(mode, "%", function()
				match_ts_or_fallback(buf, fallback_fn)
			end, { buffer = buf })
		end
	end,
})
