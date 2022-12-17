local status, telescope = pcall(require, "telescope")
if not status then
	print("ERROR: telescope.actions")
	return
end

telescope.setup({
	pickers = {
		find_files = {
			hidden = true,
		},
	},
	defaults = {
		border = true,
		borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
		color_devicons = true,
		dynamic_preview_title = true,
		file_sorter = require("telescope.sorters").get_fuzzy_file,
		file_previewer = require("telescope.previewers").vim_buffer_cat.new,
		generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
		grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
		initial_mode = "normal",
		layout_strategy = "horizontal",
		prompt_prefix = "🔭 ",
		prompt_position = "top",
		path_display = { "truncate" },
		qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
		results_width = 1,
		selection_strategy = "reset",
		selection_caret = " ",
		set_env = { ["COLORTERM"] = "truecolor" },
		sorting_strategy = "ascending",
		use_less = true,
		winblend = 0,
		vimgrep_arguments = {
			"rg",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
		},
		file_ignore_patterns = {
			"node_modules",
			"venv",
			"packer_compiled.lua",
			"package-lock.json",
			".git/hooks",
			".git/objects",
			".git/refs",
			".git/logs",
			".cache",
			".gradle",
			"flutter",
			"pytorch",
			"*.gpg",
		},
		layout_config = {
			horizontal = {
				prompt_position = "top",
				preview_width = 0.55,
				results_width = 0.8,
			},
			vertical = {
				mirror = false,
			},
			width = 0.95,
			height = 0.95,
			preview_cutoff = 120,
		},
	},
	extensions = {
		file_browser = {
			hidden = true,
		},
		["ui-select"] = {
			require("telescope.themes").get_dropdown({}),
		},
	},
})

telescope.load_extension("fzf")
telescope.load_extension("file_browser")
telescope.load_extension("ui-select")

local nnoremap = require("rav64.keymaps").nnoremap

nnoremap("<leader>fs", function()
	require("telescope.builtin").grep_string()
end)

nnoremap("<leader>fb", function()
	require("telescope.builtin").buffers()
end)

nnoremap("<leader>ff", function()
	require("telescope.builtin").find_files()
end)

nnoremap("<leader>fl", function()
	require("telescope.builtin").live_grep()
end)

nnoremap("<leader>fw", function()
	require("telescope.builtin").current_buffer_fuzzy_find()
end)

nnoremap("<leader>fF", function()
	require("telescope").extensions.file_browser.file_browser()
end)

nnoremap("<leader>fh", function()
	require("telescope.builtin").help_tags()
end)
