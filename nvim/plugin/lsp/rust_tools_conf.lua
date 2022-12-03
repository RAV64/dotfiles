local status, rt = pcall(require, "rust-tools")
if not status then
	print("ERROR: rust-tools")
	return
end

local remap = require("rav64.keymaps")
local nnoremap = remap.nnoremap

rt.setup({
	auto_focus = true,
	server = {
		on_attach = function(_, bufnr)
      require("rav64.set_lsp_keybinds")

			nnoremap("<leader>ra", rt.hover_actions.hover_actions, { buffer = bufnr })
			nnoremap("<leader>rr", rt.runnables.runnables, { buffer = bufnr })
			nnoremap("<leader>rJ", rt.join_lines.join_lines, { buffer = bufnr })
		end,
	},
})
