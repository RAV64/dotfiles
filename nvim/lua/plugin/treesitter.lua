--stylua: ignore
local ensure_installed = {
	"bash",   "c",        "csv",        "diff",
	"fish",   "html",     "htmldjango", "javascript",
	"jsdoc",  "json",     "jsonc",      "lua",
	"luadoc", "luap",     "markdown",   "markdown_inline",
	"python", "query",    "regex",      "rust",
	"sql",    "toml",     "tsx",        "typescript",
	"vim",    "vimdoc",   "yaml",
}

return {
	{
		"nvim-treesitter/nvim-treesitter",
		version = false,
		build = ":TSUpdate",
		cmd = { "TSUpdateSync" },
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			{ "nvim-treesitter/nvim-treesitter-context" },
			{ "HiPhish/rainbow-delimiters.nvim" },
		},
		keys = {
			{ "<c-space>", desc = "Increment selection" },
			{ "<bs>", desc = "Decrement selection", mode = "x" },
		},
		opts = {
			ensure_installed = ensure_installed,
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
			require("nvim-treesitter.configs").setup(opts)
		end,
	},

	{
		"echasnovski/mini.ai",
		keys = {
			{ "a", mode = { "x", "o" } },
			{ "i", mode = { "x", "o" } },
		},
		dependencies = {
			{ "nvim-treesitter/nvim-treesitter-textobjects" },
		},
		config = function()
			local ai = require("mini.ai")
			local ts_gen = ai.gen_spec.treesitter
			ai.setup({
				n_lines = 500,
				custom_textobjects = {
					["?"] = false,
					f = ts_gen({ a = "@function.outer", i = "@function.inner" }),
					c = ts_gen({ a = "@class.outer", i = "@class.inner" }),
				},
			})
		end,
	},
}
