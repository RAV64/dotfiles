vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("user-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
	desc = "go to last loc when opening a buffer",
	group = vim.api.nvim_create_augroup("user-open-last-loc", { clear = true }),
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

vim.api.nvim_create_autocmd({ "BufRead" }, {
	pattern = { "*.log" },
	callback = function()
		vim.bo.filetype = "log"
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	desc = "close some filetypes with <q>",
	group = vim.api.nvim_create_augroup("user-close-misc-buffers", { clear = true }),
	pattern = {
		"help",
		"lspinfo",
		"man",
		"notify",
		"qf",
		"query",
		"startuptime",
		"tsplayground",
		"checkhealth",
		"grug-far",
		"log",
		"minifiles",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf })
		vim.keymap.set("n", "Q", "<cmd>close<cr>", { buffer = event.buf })
		vim.keymap.set("n", "<esc>", "<cmd>close<cr>", { buffer = event.buf })
	end,
})

vim.api.nvim_create_user_command("W", function()
	vim.cmd("update")
end, {})

vim.api.nvim_create_autocmd("BufWritePost", {
	group = vim.api.nvim_create_augroup("user-reload-rust-analyzer", { clear = true }),
	pattern = { "Cargo.toml" },
	callback = UTIL.rust.refresh_cargo_workspace,
})

vim.api.nvim_create_autocmd("OptionSet", {
	group = vim.api.nvim_create_augroup("user-update-indentation-chars", { clear = true }),
	pattern = { "shiftwidth" },
	callback = UTIL.update_lead(),
})

-- MACRO COLOR -----------------------------------------
local macro_cursorline_group = vim.api.nvim_create_augroup("user-macro-visual-indication", { clear = true })
local original_cursorline_hl = vim.api.nvim_get_hl(0, { name = "CursorLine", link = false })

vim.api.nvim_create_autocmd("RecordingEnter", {
	group = macro_cursorline_group,
	callback = function()
		vim.api.nvim_set_hl(0, "CursorLine", { link = "MacroCursorLine" })
	end,
})

vim.api.nvim_create_autocmd("RecordingLeave", {
	group = macro_cursorline_group,
	callback = function()
		vim.api.nvim_set_hl(0, "CursorLine", original_cursorline_hl)
	end,
})
-- /MACRO COLOR ----------------------------------------
-- FT --------------------------------------------------
local function ft(filetypes, callback)
	vim.api.nvim_create_autocmd("FileType", {
		pattern = filetypes,
		callback = callback,
	})
end

ft({ "rust" }, function(event)
	vim.keymap.set("n", "gp", UTIL.rust.go_to_parent_module, { buffer = event.buf })
end)

ft({ "rust", "toml" }, function(event)
	if vim.bo.filetype == "rust" or vim.fn.expand("%:t") == "Cargo.toml" then
		vim.keymap.set("n", "<leader>c", function()
			UTIL.find_file("Cargo.toml")
		end, { buffer = event.buf })
	end
end)

ft({ "rust", "python" }, function()
	vim.opt_local.shiftwidth = 4
	vim.opt_local.tabstop = 4
end)

ft({ "lua", "javascript", "javascriptreact", "typescript", "typescriptreact", "json" }, function()
	vim.opt_local.shiftwidth = 2
	vim.opt_local.tabstop = 2
end)

ft({ "markdown" }, function()
	vim.opt_local.linebreak = true
	vim.opt_local.wrap = true
end)

ft({ "ron" }, function()
	vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
end)
-- /FT -------------------------------------------------
