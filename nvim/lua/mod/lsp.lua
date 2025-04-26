local lsp = vim.lsp
local diag = vim.diagnostic

local keybinds = function(buf)
	local set = function(mode, keys, func, desc)
		vim.keymap.set(mode, keys, func, { buffer = buf, desc = desc })
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
end

local document_color = function(client, buf)
	if client:supports_method("textDocument/documentColor") then
		vim.lsp.document_color.enable(true, buf)
	end
end

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("user-lsp-attach", { clear = true }),
	callback = function(event)
		local client = lsp.get_client_by_id(event.data.client_id)
		local buf = event.buf

		keybinds(buf)
		document_color(client, buf)
	end,
})

diag.config({
	underline = true,
	update_in_insert = false,
	virtual_text = { spacing = 4, source = "if_many", prefix = "●" },
	severity_sort = true,
})

lsp.enable({ "rust-analyzer", "lua-ls" })
