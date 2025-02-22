-- Puff 'a' Buff Away ~~

local function unshow_in_window(win_id)
	if not vim.api.nvim_win_is_valid(win_id) then
		return
	end

	local cur_buf = vim.api.nvim_win_get_buf(win_id)

	vim.api.nvim_win_call(win_id, function()
		-- If we're in the cmdline window, just close it
		if vim.fn.getcmdwintype() ~= "" then
			vim.cmd("close!")
			return
		end

		-- Try using the alternate buffer
		local alt_buf = vim.fn.bufnr("#")
		if alt_buf ~= cur_buf and vim.fn.buflisted(alt_buf) == 1 then
			vim.api.nvim_win_set_buf(win_id, alt_buf)
			return
		end

		-- Try bprevious
		local ok = pcall(vim.cmd, "bprevious")
		if ok and cur_buf ~= vim.api.nvim_win_get_buf(win_id) then
			return
		end

		-- Otherwise, create a new listed buffer
		local new_buf = vim.api.nvim_create_buf(true, false)
		vim.api.nvim_win_set_buf(win_id, new_buf)
	end)
end

local function puff_buff()
	local buf_id = vim.api.nvim_get_current_buf()

	-- Validate buffer
	if not vim.api.nvim_buf_is_valid(buf_id) then
		vim.notify(string.format("Buffer %d is not valid.", buf_id), vim.log.levels.WARN)
		return false
	end

	-- Check for unsaved changes. If present, confirm with the user.
	if vim.bo[buf_id].modified then
		print(vim.inspect(vim.bo[buf_id].modified))

		local choice = vim.fn.confirm(
			string.format("Buffer %d has unsaved changes. Delete anyway?", buf_id),
			"&No\n&Yes",
			1,
			"Question"
		)
		if choice ~= 2 then
			-- User chose 'No'
			return false
		end
	end

	-- Unshow this buffer from all windows
	local wins = vim.fn.win_findbuf(buf_id)
	for _, w in ipairs(wins) do
		unshow_in_window(w)
	end

	-- Finally, delete the buffer (use pcall to avoid errors if it's already gone)
	local ok, err = pcall(vim.cmd, string.format("bdelete! %d", buf_id))
	if not ok then
		vim.notify(err, vim.log.levels.ERROR)
		return false
	end

	return true
end

vim.keymap.set("n", "<S-q>", puff_buff)
