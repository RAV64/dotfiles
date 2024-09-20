local M = {}

M.plugin = {
	{
		"echasnovski/mini.pairs",
		event = "InsertEnter",
		opts = {
			modes = { insert = true, command = true, terminal = false },
			-- skip autopair when next character is one of these
			skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
			-- skip autopair when the cursor is inside these treesitter nodes
			skip_ts = { "string" },
			-- skip autopair when next character is closing pair
			-- and there are more closing pairs than opening pairs
			skip_unbalanced = true,
			-- better deal with markdown code blocks
			markdown = true,
		},
	},
	-- {
	-- 	"echasnovski/mini.ai",
	-- 	event = "VeryLazy",
	-- 	opts = function()
	-- 		local ai = require("mini.ai")
	-- 		return {
	-- 			n_lines = 500,
	-- 			custom_textobjects = {
	-- 				o = ai.gen_spec.treesitter({ -- code block
	-- 					a = { "@block.outer", "@conditional.outer", "@loop.outer" },
	-- 					i = { "@block.inner", "@conditional.inner", "@loop.inner" },
	-- 				}),
	-- 				f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }), -- function
	-- 				c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }), -- class
	-- 				t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" }, -- tags
	-- 			},
	-- 		}
	-- 	end,
	-- },
	{
		"echasnovski/mini.surround",
		event = "BufReadPost",
		opts = {
			mappings = {
				add = "sa",
				delete = "sd",
				replace = "sr",

				-- Disable
				find = "",
				find_left = "",
				highlight = "",
				update_n_lines = "",
			},
		},
	},
	{
		"echasnovski/mini.bufremove",
		keys = {
			{
				"<S-q>",
				function()
					M.buf_delete(0, false)
				end,
				desc = "Delete Buffer",
			},
		},
		config = function()
			M.buf_delete = require("mini.bufremove").delete
		end,
	},

	{
		"echasnovski/mini.icons",
		config = true,
		init = function()
			package.preload["nvim-web-devicons"] = function()
				require("mini.icons").mock_nvim_web_devicons()
				return package.loaded["nvim-web-devicons"]
			end
		end,
	},

	{
		"echasnovski/mini.files",
		keys = {
			{
				"å",
				function()
					M.files_open(vim.api.nvim_buf_get_name(0), false)
				end,
			},
		},
		opts = {
			mappings = {
				go_in = "",
				go_in_plus = "l",
				go_out = "h",
				go_out_plus = "",
			},
		},
		config = function(_, opts)
			local files = require("mini.files")
			files.setup(opts)
			M.files_open = files.open
		end,
	},
}

return M.plugin
