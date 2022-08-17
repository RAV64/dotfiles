local status, nvimtree = pcall(require, "nvim-tree")
if not status then
	print("ERROR: nvim-tree")
	return
end

nvimtree.setup({})

local nnoremap = require("rav64.keymaps").nnoremap

nnoremap("å", function()
	require("nvim-tree").toggle()
end)
