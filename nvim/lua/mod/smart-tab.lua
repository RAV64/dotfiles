local smart_tab = function()
	local node_ok, node = pcall(vim.treesitter.get_node)
	if not node_ok then
		vim.notify("TS not available")
		return false
	end
	-- if not node then
	-- 	vim.notify("parent not")
	-- 	return false
	-- end
	local row, col = node:end_()
	local ok = pcall(vim.api.nvim_win_set_cursor, 0, { row + 1, col })
	return ok
end

vim.keymap.set("i", "<tab>", smart_tab)
