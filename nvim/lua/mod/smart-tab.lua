local jump_out = function()
	local node_ok, node = pcall(vim.treesitter.get_node)
	if not node_ok or not node then
		vim.notify("TS not available")
		return
	end
	local row, col = node:end_()
	pcall(vim.api.nvim_win_set_cursor, 0, { row + 1, col })
end

vim.keymap.set({ "s", "i" }, "<Tab>", jump_out, { desc = "Smart tab (jump out)" })
