local M = {}

local ntts = function(tx)
	return function()
		UTIL.func("nvim-treesitter-textobjects.select", "select_textobject", tx, "textobjects")
	end
end

M.plugin = {
	{
		"nvim-treesitter/nvim-treesitter",
		commit = "ae32ed8bda5e78d00aaa99300cf2f1c45ce1884c",
		branch = "main",
		build = ":TSUpdate",
		lazy = false,
		opts = { ensure_install = { "unstable" }, ignore_install = { "unsupported" } },
		config = function(_, opts)
			require("nvim-treesitter").setup(opts)

			local group = vim.api.nvim_create_augroup("custom-treesitter", { clear = true })
			local pattern = UTIL.get_top_level_keys(require("nvim-treesitter.parsers"))

			vim.api.nvim_create_autocmd("FileType", {
				pattern = pattern,
				group = group,
				callback = function()
					pcall(vim.treesitter.start)
				end,
			})
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		commit = "fa32a45fdbab9c9c3bda9ecec9b12dddb221b927",
		branch = "main",
		keys = {
			{ "if", ntts("@function.inner"), mode = { "x", "o" } },
			{ "af", ntts("@function.outer"), mode = { "x", "o" } },
			{ "it", ntts("@class.inner"), mode = { "x", "o" } },
			{ "at", ntts("@class.outer"), mode = { "x", "o" } },
		},
	},
}

return M.plugin
