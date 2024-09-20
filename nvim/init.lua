require("config.options")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = {
		{ import = "plugin" },
		-- { import = "extra.plugin.markdown" },
	},
	defaults = { version = false, lazy = true },
	change_detection = { enabled = false },
	checker = { enabled = false },
	-- rocks = { enabled = false },
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"health",
				"man",
				"matchit",
				"matchparen",
				"netrwPlugin",
				"rplugin",
				"shada",
				"spellfile",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
				"osc52",
			},
		},
	},
})

vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	callback = function()
		vim.opt.clipboard = "unnamedplus"
		require("config.autocmds")
		require("config.keymaps")
		require("config.colors")
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
