local status, nvimtree = pcall(require, "nvim-tree")
if not status then
	print("ERROR: nvim-tree")
	return
end

nvimtree.setup {
}
