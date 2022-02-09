local status, _ = pcall(require, "lspconfig")
if not status then
	print("ERROR: lspconfig")
	return
end

local ins_status, lsp_installer = pcall(require, "nvim-lsp-installer")
if not ins_status then
	print("ERROR: nvim-lsp-installer")
	return
end

lsp_installer.on_server_ready(function(server)
	local opts = {
		on_attach = require("plugins.lsp.handlers").on_attach,
		capabilities = require("plugins.lsp.handlers").capabilities,
	}

	if server.name == "sumneko_lua" then
		local sumneko_opts = require("plugins.lsp.settings.sumneko_lua")
		opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
	end

	if server.name == "pyright" then
		local pyright_opts = require("plugins.lsp.settings.pyright")
		opts = vim.tbl_deep_extend("force", pyright_opts, opts)
	end
	server:setup(opts)
end)

require("plugins.lsp.handlers").setup()
require("plugins.lsp.null-ls")
require("plugins.lsp.lspsaga")
--require("plugins.lsp.settings.rust-tools")
