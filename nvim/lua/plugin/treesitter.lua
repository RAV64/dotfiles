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
		init = function(plugin)
			local loader = require("lazy.core.loader")
			loader.add_to_rtp(plugin)
			loader.disable_rtp_plugin("nvim-treesitter-textobjects")
			require("nvim-treesitter.query_predicates")
		end,
		keys = {
			{ "<c-space>", desc = "Increment selection" },
			{ "<bs>", desc = "Decrement selection", mode = "x" },
		},
		opts = {
			ensure_installed = {
				"bash",
				"c",
				"csv",
				"diff",
				"fish",
				"html",
				"javascript",
				"jsdoc",
				"json",
				"jsonc",
				"lua",
				"luadoc",
				"luap",
				"markdown",
				"markdown_inline",
				"python",
				"query",
				"regex",
				"rust",
				"sql",
				"toml",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
				"yaml",
			},
			highlight = { enable = true, additional_vim_regex_highlighting = false },
			indent = { enable = true },
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<c-space>",
					node_incremental = "<c-space>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			},
			disable = function(_, buf)
				local max_filesize = 100 * 1024 -- 1000 KB
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
