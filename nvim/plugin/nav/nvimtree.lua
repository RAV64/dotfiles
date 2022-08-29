local status, nvimtree = pcall(require, "nvim-tree")
if not status then
	print("ERROR: nvim-tree")
	return
end

nvimtree.setup({
	open_on_setup = false,
	diagnostics = {
		enable = true,
		show_on_dirs = true,
	},
	view = {
		hide_root_folder = true,
		preserve_window_proportions = true,
	},
	renderer = {
		indent_markers = {
			enable = true,
		},
	},
})

local nnoremap = require("rav64.keymaps").nnoremap

nnoremap("å", function()
	require("nvim-tree").toggle()
end)
