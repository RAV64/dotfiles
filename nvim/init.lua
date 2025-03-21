_G.UTIL = require("config.util")

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
		require("mod.autopair")
		require("mod.puff-buff")
		require("mod.surround")
		require("mod.treesitter-matchit")
		require("mod.lsp")

		-- require("mod.treesitter-diagnostics")
	end,
})
