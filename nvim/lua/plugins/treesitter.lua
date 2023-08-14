return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		{ "mrjones2014/nvim-ts-rainbow" },
		{ "nvim-treesitter/playground" },

		{
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		{ "nvim-treesitter/nvim-treesitter-context", config = true, event = "VeryLazy" },
	},
	version = false,
	build = ":TSUpdate",
	cmd = { "TSUpdateSync" },
	event = { "BufReadPost", "BufNewFile" },
	keys = {
		{ "<c-space>", desc = "Increment selection" },
		{ "<bs>",      desc = "Decrement selection", mode = "x" },
	},
	opts = {
		ensure_installed = { "c", "lua", "vim", "vimdoc", "rust", "toml", "python", "markdown", "json", "fish" },
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
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
		if type(opts.ensure_installed) == "table" then
			---@type table<string, boolean>
			local added = {}
			opts.ensure_installed = vim.tbl_filter(function(lang)
				if added[lang] then
					return false
				end
				added[lang] = true
				return true
			end, opts.ensure_installed)
		end
		require("nvim-treesitter.configs").setup(opts)

		if opts.textobjects then
			for _, mod in ipairs({ "move", "select", "swap", "lsp_interop" }) do
				if opts.textobjects[mod] and opts.textobjects[mod].enable then
					local Loader = require("lazy.core.loader")
					Loader.disabled_rtp_plugins["nvim-treesitter-textobjects"] = nil
					local plugin = require("lazy.core.config").plugins["nvim-treesitter-textobjects"]
					require("lazy.core.loader").source_runtime(plugin.dir, "plugin")
					break
				end
			end
		end
	end,
}
