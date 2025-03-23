local lsp = vim.lsp
local diag = vim.diagnostic

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("user-lsp-attach", { clear = true }),
	callback = function(event)
		local set = function(mode, keys, func, desc)
			vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = desc })
		end

		set("n", "<leader>r", lsp.buf.rename, "Rename")
		set("n", "Z", function()
			diag.jump({ count = -1, float = true })
		end, "Goto previous diagnostics")
		set("n", "z", function()
			diag.jump({ count = 1, float = true })
		end, "Goto next diagnostics")
		set("n", "ge", diag.open_float, "Open diagnostics")
		set("i", "<C-s>", lsp.buf.signature_help, "Show signature")
		set("n", "<leader>gwa", lsp.buf.add_workspace_folder, "add_workspace_folder")
		set("n", "<leader>gwr", lsp.buf.remove_workspace_folder, "remove_workspace_folder")
		set("n", "<leader>gwl", function()
			vim.print(lsp.buf.list_workspace_folders())
		end, "list_workspace_folders")
	end,
})

diag.config({
	underline = true,
	update_in_insert = false,
	virtual_text = { spacing = 4, source = "if_many", prefix = "●" },
	severity_sort = true,
})

lsp.enable("rust-analyzer")
lsp.enable("lua-ls")
