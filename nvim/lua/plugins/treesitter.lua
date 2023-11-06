return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		-- { "nvim-treesitter/playground" },
		{ "nvim-treesitter/nvim-treesitter-textobjects" },
		{ "nvim-treesitter/nvim-treesitter-context", config = true, event = "VeryLazy" },
	},
	version = false,
	build = ":TSUpdate",
	cmd = { "TSUpdateSync" },
	event = { "VeryLazy" },
	keys = {
		{ "<c-space>", desc = "Increment selection" },
		{ "<bs>", desc = "Decrement selection", mode = "x" },
	},
	opts = {
		ensure_installed = {
			"c",
			"lua",
			"vim",
			"vimdoc",
			"rust",
			"toml",
			"python",
			"markdown",
			"json",
			"fish",
			"sql",
			"csv",
		},
		highlight = { enable = true },
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
		playground = {
			enable = true,
			updatetime = 25,
			persist_queries = true,
			keybindings = {
				toggle_query_editor = "o",
				toggle_hl_groups = "i",
				toggle_injected_languages = "t",

				-- This shows stuff like literal strings, commas, etc.
				toggle_anonymous_nodes = "a",
				toggle_language_display = "I",
				focus_language = "f",
				unfocus_language = "F",
				update = "R",
				goto_node = "<cr>",
				show_help = "?",
			},
		},
	},
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
	end,
}
