local api, ts, fn = vim.api, vim.treesitter, vim.fn
local DISABLE_FT = { netrw = true }

local function pos(n)
	local sr, sc, er, ec = n:range(false)
	return sr, sc, er, (ec == 0 and fn.col({ er, "$" }) - 1 or ec - 1)
end

local function jump(n, to_end)
	if api.nvim_get_mode().mode:sub(1, 2) == "no" then
		vim.cmd("normal! v")
	end
	local sr, sc, er, ec = pos(n)
	api.nvim_win_set_cursor(0, to_end and { er + 1, ec } or { sr + 1, sc })
end

local function match(parser, buf)
	local r, c = unpack(api.nvim_win_get_cursor(0))
	r = r - 1
	local node = parser:named_node_for_range({ r, c, r, c }, { ignore_injections = false })
	if not node then
		return
	end

	if node:child_count() == 0 then
		local t = ts.get_node_text(node, buf) or ""
		if #t == 1 and not t:match("[%w_]") then
			node = node:parent() or node
		end
	end

	local cc = node:child_count()
	if cc >= 2 then
		local head, tail = node:child(0), node:child(cc - 1)
		if head and tail and not head:equal(tail) then
			if ts.is_in_node_range(tail, r, c) then
				jump(head, false)
			else
				jump(tail, true)
			end
			return
		end
	end

	local sr, sc, er, ec = pos(node)
	if r == er and c == ec then
		api.nvim_win_set_cursor(0, { sr + 1, sc })
	else
		api.nvim_win_set_cursor(0, { er + 1, ec })
	end
end

api.nvim_create_autocmd("FileType", {
	group = api.nvim_create_augroup("treesitter-matchit", {}),
	pattern = "*",
	callback = function()
		local buf = api.nvim_get_current_buf()
		if DISABLE_FT[vim.bo[buf].ft] then
			return
		end
		local ok, parser = pcall(ts.get_parser, buf)
		if not ok or not parser then
			return
		end
		vim.keymap.set({ "n", "x", "o" }, "%", function()
			match(parser, buf)
		end, { buffer = buf, silent = true, desc = "Tree-sitter structural match (%)" })
	end,
})
