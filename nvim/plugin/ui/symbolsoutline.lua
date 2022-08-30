local status, so = pcall(require, "symbols-outline")
if not status then
	print("ERROR: symbols-outline")
	return
end

so.setup({})

local nnoremap = require("rav64.keymaps").nnoremap
nnoremap("Å", function()
	so.toggle_outline()
end)
