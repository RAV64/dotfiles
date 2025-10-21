local api, fn, go, set = vim.api, vim.fn, vim.go, vim.keymap.set
local pairs = { ["("] = ")", ["["] = "]", ["{"] = "}", ["<"] = ">" }

local function find_pair_range(left, right)
	local sp = (left == right) and fn.searchpos(left, "cbnW") or fn.searchpairpos(left, "", right, "cbnW")
	if sp[1] == 0 then
		return
	end
	local ep = (left == right) and fn.searchpos(right, "nW") or fn.searchpairpos(left, "", right, "nW")
	if ep[1] == 0 then
		return
	end

	local sr, sc = sp[1] - 1, sp[2] - 1
	local er, ec = ep[1] - 1, ep[2] - 1
	local row, col = unpack(api.nvim_win_get_cursor(0))
	local cr, cc = row - 1, col
	if cr < sr or cr > er or (cr == sr and cc < sc) or (cr == er and cc > ec) then
		return
	end
	return sr, sc, er, ec
end

local function getchar_once()
	local ok, c = pcall(fn.getcharstr)
	if not ok or #c ~= 1 then
		return
	end
	return c, pairs[c] or c
end

local function surround_op(range_fn, edit_fn)
	local left, right = getchar_once()
	if not left then
		return
	end

	local sr, sc, er, ec = range_fn(left, right)
	if not sr then
		return
	end

	edit_fn(sr, sc, er, ec, left, right)
end

local M = {}

function M.delete()
	surround_op(find_pair_range, function(sr, sc, er, ec)
		api.nvim_buf_set_text(0, er, ec, er, ec + 1, {})
		api.nvim_buf_set_text(0, sr, sc, sr, sc + 1, {})
	end)
end

function M.replace()
	surround_op(find_pair_range, function(sr, sc, er, ec)
		local ok, c = pcall(fn.getcharstr)
		if not ok or #c ~= 1 then
			return
		end
		local nr = pairs[c] or c
		api.nvim_buf_set_text(0, er, ec, er, ec + 1, { nr })
		api.nvim_buf_set_text(0, sr, sc, sr, sc + 1, { c })
	end)
end

function M.add()
	surround_op(function()
		local srow, scol = unpack(api.nvim_buf_get_mark(0, "["))
		local erow, ecol = unpack(api.nvim_buf_get_mark(0, "]"))
		return srow - 1, scol, erow - 1, ecol + 1
	end, function(sr, sc, er, ec, left, right)
		api.nvim_buf_set_text(0, er, ec, er, ec, { right })
		api.nvim_buf_set_text(0, sr, sc, sr, sc, { left })
	end)
end

function M.setup()
	_G.Surround = M
	set("n", "md", M.delete, { desc = "Delete surrounding" })
	set("n", "mr", M.replace, { desc = "Replace surrounding" })
	set("n", "ms", function()
		go.operatorfunc = "v:lua.Surround.add"
		return "g@"
	end, { expr = true, desc = "Add surrounding (operator)" })
end

M.setup()
