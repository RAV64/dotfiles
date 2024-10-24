local function get_top_level_keys(tbl)
	local keys = {}

	for key, _ in pairs(tbl) do
		table.insert(keys, key)
	end

	return keys
end

local M = {}

M.plugin = {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		build = ":TSUpdate",
		lazy = false,
		opts = { ensure_install = "community" },
		config = function(_, opts)
			require("nvim-treesitter").setup(opts)

			local group = vim.api.nvim_create_augroup("custom-treesitter", { clear = true })
			local pattern = get_top_level_keys(require("nvim-treesitter.parsers"))

			vim.api.nvim_create_autocmd("FileType", {
				pattern = pattern,
				group = group,
				callback = function()
					pcall(vim.treesitter.start)
				end,
			})
		end,
	},

	{ "HiPhish/rainbow-delimiters.nvim", event = "BufReadPre", branch = "fix-highlighting" },
	{ "yorickpeterse/nvim-tree-pairs", event = "BufEnter", config = true },
}

return M.plugin
