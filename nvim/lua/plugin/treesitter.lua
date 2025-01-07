local M = {}

local ntts = function(tx)
	return function()
		UTIL.func("nvim-treesitter-textobjects.select", "select_textobject", tx, "textobjects")
	end
end

M.plugin = {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		build = ":TSUpdate",
		lazy = false,
		opts = { ensure_install = { "community" }, ignore_install = { "unsupported" } },
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
	{ "HiPhish/rainbow-delimiters.nvim", event = "BufReadPre" },
	{ "yorickpeterse/nvim-tree-pairs", event = "BufEnter", config = true },

	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		keys = {
			{ "if", ntts("@function.inner"), mode = { "x", "o" } },
			{ "af", ntts("@function.outer"), mode = { "x", "o" } },
			{ "it", ntts("@class.inner"), mode = { "x", "o" } },
			{ "at", ntts("@class.outer"), mode = { "x", "o" } },
		},
	},

	{
		"nvim-treesitter/nvim-treesitter-context",
		event = "BufReadPre",
	},
}

return M.plugin
