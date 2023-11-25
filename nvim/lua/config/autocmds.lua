vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"PlenaryTestPopup",
		"help",
		"lspinfo",
		"man",
		"notify",
		"qf",
		"query",
		"spectre_panel",
		"startuptime",
		"tsplayground",
		"neotest-output",
		"checkhealth",
		"neotest-summary",
		"neotest-output-panel",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
})

vim.api.nvim_create_user_command("W", function()
	vim.cmd("update")
end, {})

local update_lead = require("config.util").update_lead()
local function ft(filetypes, callback)
	vim.api.nvim_create_autocmd("FileType", {
		pattern = filetypes,
		callback = function()
			callback()
			update_lead()
		end,
	})
end

ft({ "rust", "python" }, function()
	vim.opt_local.shiftwidth = 4
	vim.opt_local.tabstop = 4
end)

ft({ "lua" }, function()
	vim.opt_local.shiftwidth = 2
	vim.opt_local.tabstop = 2
end)
