return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = { "mrjones2014/nvim-ts-rainbow" },
	version = false, -- last release is way too old and doesn't work on Windows
	build = ":TSUpdate",
	event = "BufReadPost",
	opts = {
		ensure_installed = "all",
		highlight =   {
			enable = true,
		},
		context_commentstring = { enable = true, enable_autocmd = false },
		indent = {
			enable = true,
		},
		autopairs = {
			enable = true,
		},
		rainbow = {
			enable = true,
			extended_mode = true,
			max_file_lines = 2000,
		},
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<c-space>",
				node_incremental = "<c-space>",
				scope_incremental = false,
				node_decremental = "<c-backspace>",
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

	config = function(opts)
		require("nvim-treesitter.configs").setup(opts)
	end,
}
