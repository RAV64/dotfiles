local set = vim.keymap.set
local api = vim.api
local n = "n"
local t = "t"

local function is_term(buf)
	return api.nvim_buf_is_valid(buf)
		and api.nvim_get_option_value("buftype", { buf = buf }) == "terminal"
		and vim.b[buf].quick_term == true
end

local function setup_term_buf(buf)
	vim.b[buf].quick_term = true
	api.nvim_set_option_value("buflisted", false, { buf = buf })
	set(n, "<esc>", "<cmd>close<cr>", {
		buffer = buf,
		desc = "Exit terminal",
	})
	set(t, "<esc>", "<c-\\><c-n><cmd>close<cr>", { buffer = buf, desc = "Exit terminal" })
end

local function open_or_split_terminal()
	for _, win in ipairs(api.nvim_list_wins()) do
		local buf = api.nvim_win_get_buf(win)
		if is_term(buf) then
			api.nvim_set_current_win(win)
			vim.cmd("startinsert")
			return
		end
	end

	for _, buf in ipairs(api.nvim_list_bufs()) do
		if is_term(buf) then
			vim.cmd("split")
			vim.cmd("buffer " .. buf)
			vim.cmd("startinsert")
			return
		end
	end

	vim.cmd("split")
	vim.cmd("terminal fish")
	vim.cmd("startinsert")
	setup_term_buf(api.nvim_get_current_buf())
end

set(n, "<leader><leader>t", open_or_split_terminal, {
	desc = "Open or focus terminal",
})
