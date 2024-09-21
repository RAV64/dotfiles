require("config.options")
require("config.lazy")

vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	callback = function()
		vim.opt.clipboard = "unnamedplus"
		require("config.colors")
		require("config.keymaps")
		require("config.autocmds")
		require("mod.statusline")
	end,
})

vim.api.nvim_create_autocmd("UiEnter", {
	callback = function()
		if vim.tbl_isempty(vim.fn.argv()) then
			require("telescope.builtin").find_files()
		end
	end,
})
