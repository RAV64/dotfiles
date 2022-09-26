local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local rav_group = augroup("RAV64", {})
local yank_group = augroup("HighlightYank", {})

autocmd("TextYankPost", {
	group = yank_group,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
		})
	end,
})

autocmd({ "BufWritePre" }, {
	group = rav_group,
	pattern = "*",
	command = "%s/\\s\\+$//e",
})
