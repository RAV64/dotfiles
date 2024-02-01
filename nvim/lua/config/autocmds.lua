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

local filetype_group = vim.api.nvim_create_augroup("my_filetype_group", {})
local function ft(filetypes, callback)
	vim.api.nvim_create_autocmd("FileType", {
		group = filetype_group,
		pattern = filetypes,
		callback = callback,
	})
end

local update_lead = require("config.util").update_lead()

ft({ "rust", "python" }, function()
	vim.opt_local.shiftwidth = 4
	vim.opt_local.tabstop = 4
	update_lead()
end)

ft({ "lua", "javascript", "javascriptreact", "typescript", "typescriptreact", "json" }, function()
	vim.opt_local.shiftwidth = 2
	vim.opt_local.tabstop = 2
	update_lead()
end)

ft({ "markdown" }, function()
	vim.opt_local.wrap = true
end)

-- vim.api.nvim_create_autocmd("LspAttach", {
-- 	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
-- 	callback = function(args)
-- 		local client = vim.lsp.get_client_by_id(args.data.client_id)
-- 		if client and client.server_capabilities.inlayHintProvider then
-- 			vim.lsp.inlay_hint.enable(args.buf, true)
-- 		end
-- 	end,
-- })

vim.api.nvim_create_augroup("macro_visual_indication", {})
vim.api.nvim_create_autocmd("RecordingEnter", {
	group = "macro_visual_indication",
	callback = function()
		vim.api.nvim_set_hl(0, "CursorLine", { bg = "#603717" })
	end,
})

vim.api.nvim_create_autocmd("RecordingLeave", {
	group = "macro_visual_indication",
	callback = function()
		vim.api.nvim_set_hl(0, "CursorLine", { bg = "#393939" })
	end,
})
