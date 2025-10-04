local node_lifo = {}
local node_index = 0

local function node_range(n)
	local sr, sc, er, ec = n:range()
	if ec == 0 and er > sr then
		local prev = er - 1
		local len = #vim.fn.getline(prev + 1)
		return sr, sc, prev, math.max(0, len - 1)
	else
		return sr, sc, er, math.max(0, ec - 1)
	end
end

local function same_range(a, b)
	local asr, asc, aer, aec = node_range(a)
	local bsr, bsc, ber, bec = node_range(b)
	return asr == bsr and asc == bsc and aer == ber and aec == bec
end

local function select_range_from_normal(sr, sc, er, ec)
	vim.api.nvim_win_set_cursor(0, { sr + 1, sc })
	vim.cmd("normal! v")
	vim.api.nvim_win_set_cursor(0, { er + 1, ec })
end

local function select_range_in_visual(sr, sc, er, ec)
	vim.api.nvim_win_set_cursor(0, { sr + 1, sc })
	vim.api.nvim_feedkeys("o", "x", false)
	vim.api.nvim_win_set_cursor(0, { er + 1, ec })
end

local function push_node(n)
	node_index = node_index + 1
	node_lifo[node_index] = n
end

local function top_node()
	return node_lifo[node_index]
end

local function pop_node()
	if node_index <= 1 then
		return
	end
	node_index = node_index - 1
	select_range_in_visual(node_range(node_lifo[node_index]))
end

local function select_node_at_cursor()
	node_index = 0
	local ok, node = pcall(vim.treesitter.get_node)
	if ok and node then
		local sr, sc, er, ec = node_range(node)
		select_range_from_normal(sr, sc, er, ec)
		push_node(node)
	end
end

local function select_parent_node()
	local cur = top_node()
	if not cur then
		return
	end
	local parent = cur:parent()
	while parent do
		if not same_range(parent, cur) then
			push_node(parent)
			select_range_in_visual(node_range(parent))
			return
		end
		cur = parent
		parent = parent:parent()
	end
end

vim.api.nvim_create_autocmd("ModeChanged", {
	pattern = "v:*",
	callback = function()
		node_index = 0
	end,
})

vim.keymap.set("n", "<C-Space>", select_node_at_cursor, { silent = true, desc = "TS: select node" })
vim.keymap.set("v", "<C-Space>", select_parent_node, { silent = true, desc = "TS: parent" })
vim.keymap.set("v", "<BS>", pop_node, { silent = true, desc = "TS: back to child" })
