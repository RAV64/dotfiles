-- Puff 'a' Buff Away ~~
local api = vim.api
local fn = vim.fn

local function unshow_in_window(win_id)
	if not api.nvim_win_is_valid(win_id) then
		return
	end

	local cur_buf = api.nvim_win_get_buf(win_id)

	api.nvim_win_call(win_id, function()
		-- If we're in the cmdline window, just close it
		if fn.getcmdwintype() ~= "" then
			api.nvim_cmd({ cmd = "close!" }, {})
			return
		end

		-- Try using the alternate buffer
		local alt_buf = fn.bufnr("#")
		if alt_buf ~= cur_buf and fn.buflisted(alt_buf) == 1 then
			api.nvim_win_set_buf(win_id, alt_buf)
			return
		end

		-- Try bprevious
		local ok = pcall(api.nvim_cmd, { cmd = "bprevious" }, {})
		if ok and cur_buf ~= api.nvim_win_get_buf(win_id) then
			return
		end

		-- Otherwise, create a new listed buffer
		local new_buf = api.nvim_create_buf(true, false)
		api.nvim_win_set_buf(win_id, new_buf)
	end)
end

local function puff_buff()
	local buf_id = api.nvim_get_current_buf()

	-- Validate buffer
	if not api.nvim_buf_is_valid(buf_id) then
		vim.notify(string.format("Buffer %d is not valid.", buf_id), vim.log.levels.WARN)
		return false
	end

	-- Check for unsaved changes. If present, confirm with the user.
	if vim.bo[buf_id].modified then
		local choice = fn.confirm(
			string.format("Buffer %d has unsaved changes. Delete anyway?", buf_id),
			"&No\n&Yes",
			1,
			"Question"
		)
		if choice ~= 2 then
			return false
		end
	end

	-- Unshow this buffer from all windows
	local wins = fn.win_findbuf(buf_id)
	for _, w in ipairs(wins) do
		unshow_in_window(w)
	end

	-- Finally, delete the buffer (use pcall to avoid errors if it's already gone)
	if api.nvim_buf_is_valid(buf_id) then
		api.nvim_cmd({ cmd = "bdelete", bang = true, args = { tostring(buf_id) } }, {})
	else
		vim.notify("Tried to delete buffer that did not exist", vim.log.levels.ERROR)
		return false
	end

	return true
end

vim.keymap.set("n", "<S-q>", puff_buff)
