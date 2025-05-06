local api, fn, set = vim.api, vim.fn, vim.keymap.set

local function switch_buf(win)
	if not api.nvim_win_is_valid(win) then
		return
	end
	api.nvim_win_call(win, function()
		if fn.getcmdwintype() ~= "" then
			return api.nvim_cmd({ cmd = "close!" }, {})
		end
		local cur = api.nvim_win_get_buf(win)
		local alt = fn.bufnr("#")
		if alt ~= cur and fn.buflisted(alt) == 1 then
			return api.nvim_win_set_buf(win, alt)
		end
		if pcall(api.nvim_cmd, { cmd = "bprevious" }, {}) and api.nvim_win_get_buf(win) ~= cur then
			return
		end
		api.nvim_win_set_buf(win, api.nvim_create_buf(true, false))
	end)
end

local function delete_buf()
	local buf = api.nvim_get_current_buf()
	if
		not api.nvim_buf_is_valid(buf)
		or (vim.bo[buf].modified and fn.confirm(("Unsaved changes in %d. Delete?"):format(buf), "&No\n&Yes", 1) ~= 2)
	then
		return
	end

	for _, w in ipairs(fn.win_findbuf(buf)) do
		switch_buf(w)
	end

	api.nvim_cmd({ cmd = "bdelete", bang = true, args = { tostring(buf) } }, {})
end

set("n", "<S-q>", delete_buf, { desc = "Delete buffer" })
