local status, tsc = pcall(require, "nvim-treesitter.configs")
if not status then
	print("ERROR treesitter")
	return
end

tsc.setup({
	ensure_installed = "all",
	ignore_install = { "phpdoc" },
	highlight = {
		enable = true,
		use_languagetree = true,
	},
	autopairs = {
		enable = true,
	},
	indent = {
		enable = true,
	},
	rainbow = {
		enable = true,
		extended_mode = true,
		max_file_lines = nil,
	},

	textobjects = {
		move = {
			enable = true,
			set_jumps = true,
			goto_next_start = {
				["tp"] = "@parameter.inner",
				["tf"] = "@function.outer",
				["tc"] = "@class.outer",
			},
			goto_next_end = {
				["tP"] = "@parameter.inner",
				["tF"] = "@function.outer",
				["tC"] = "@class.outer",
			},
			goto_previous_start = {
				["Tp"] = "@parameter.inner",
				["Tf"] = "@function.outer",
				["Tc"] = "@class.outer",
			},
			goto_previous_end = {
				["TP"] = "@parameter.inner",
				["TF"] = "@function.outer",
				["TC"] = "@class.outer",
			},
		},

		select = {
			enable = true,
			keymaps = {
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@conditional.outer",
				["ic"] = "@conditional.inner",
				["aa"] = "@parameter.outer",
				["ia"] = "@parameter.inner",
				["av"] = "@variable.outer",
				["iv"] = "@variable.inner",
			},
		},
	},
})
require("nvim-ts-autotag").setup()
