local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local rav_group = augroup("RAV64", {})
local yank_group = augroup("HighlightYank", {})

vim.api.nvim_command("hi TelescopeNormal NONE")
vim.api.nvim_command("hi TelescopeBorder NONE")
vim.api.nvim_command("hi LineNr guifg=#ffffff")
vim.api.nvim_command("hi LspFloatWinNormal guibg=None")

autocmd({ "BufEnter", "BufWinEnter", "TabEnter" }, {
	group = rav_group,
	pattern = "*.rs",
	callback = function()
		require("lsp_extensions").inlay_hints({})
	end,
})

autocmd("TextYankPost", {
	group = yank_group,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
		})
	end,
})
