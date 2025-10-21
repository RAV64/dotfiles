local lsp = vim.lsp
local diag = vim.diagnostic

local set = function(mode, keys, func, args)
	vim.keymap.set(mode, keys, func, args)
end

set("n", "Z", function()
	diag.jump({ count = -1, float = true })
end, { desc = "Goto previous diagnostics" })
set("n", "z", function()
	diag.jump({ count = 1, float = true })
end, { desc = "Goto next diagnostics" })
set("n", "ge", diag.open_float, { desc = "Open diagnostics" })

local keybinds = function(buf)
	set("n", "<leader>r", lsp.buf.rename, { desc = "Rename", buffer = buf })
	set("i", "<C-s>", lsp.buf.signature_help, { desc = "Show signature", buffer = buf })
	set("n", "<leader>gwa", lsp.buf.add_workspace_folder, { desc = "add_workspace_folder", buffer = buf })
	set("n", "<leader>gwr", lsp.buf.remove_workspace_folder, { desc = "remove_workspace_folder", buffer = buf })
	set("n", "<leader>gwl", function()
		vim.print(lsp.buf.list_workspace_folders())
	end, { desc = "list_workspace_folders", buffer = buf })
	set({ "n", "x" }, "<C-Space><C-i>", function()
		lsp.buf.code_action({
			apply = true,
			context = {
				only = { "refactor.inline" },
				diagnostics = {},
			},
		})
	end, { desc = "LSP: Inline variable" })
	set({ "n", "x" }, "<C-Space><C-e>", function()
		lsp.buf.code_action({
			apply = true,
			context = {
				only = { "refactor.extract" },
				diagnostics = {},
			},
		})
	end, { desc = "LSP: Extract" })
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

lsp.enable({ "rust-analyzer", "lua-ls", "jdtls" })
