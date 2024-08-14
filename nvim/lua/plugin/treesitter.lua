local M = {}

--stylua: ignore
M.ensure_install = {
	"bash",   "c",        "csv",        "diff",
	"fish",   "html",     "htmldjango", "javascript",
	"jsdoc",  "json",     "jsonc",      "lua",
	"luadoc", "luap",     "markdown",   "markdown_inline",
	"python", "query",    "regex",      "rust",
	"sql",    "toml",     "tsx",        "typescript",
	"vim",    "vimdoc",   "yaml",
  "git_config",
  "git_rebase",
  "gitattributes",
  "gitcommit",
  "gitignore"
}

M.plugin = {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		build = ":TSUpdate",
		lazy = false,
		dependencies = {
			{ "yorickpeterse/nvim-tree-pairs", config = true },
		},
		opts = {
			ensure_install = M.ensure_install,
			auto_install = true,
			highlight = { enable = true, additional_vim_regex_highlighting = false },
			indent = { enable = true },
			incremental_selection = { enable = false },
			disable = function(_, buf)
				local max_filesize = 200 * 1024 -- 2000 KB
				local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
				if ok and stats and stats.size > max_filesize then
					return true
				end
			end,
		},
		config = function(_, opts)
			require("nvim-treesitter").setup(opts)

			local group = vim.api.nvim_create_augroup("custom-treesitter", { clear = true })

			vim.api.nvim_create_autocmd("FileType", {
				group = group,
				callback = function()
					pcall(vim.treesitter.start)
				end,
			})
		end,
	},

	{ "HiPhish/rainbow-delimiters.nvim", event = "BufReadPre" },
}

return M.plugin
