local status, _ = pcall(require, "lspconfig")
if not status then
	print("ERROR: lspconfig")
	return
end

require("plugins.lsp.handlers").setup()

local servers = { "pyright", "sumneko_lua", "tsserver" }
for _, lsp in pairs(servers) do
	local opts = {}
	local server_opts = require("plugins.lsp.settings." .. lsp)
	opts = vim.tbl_deep_extend("force", server_opts, opts)

	require("lspconfig")[lsp].setup({
		on_attach = require("plugins.lsp.handlers").on_attach,
		capabilities = require("plugins.lsp.handlers").capabilities,
		settings = require("plugins.lsp.settings." .. lsp).settings,
	})
end

require("plugins.lsp.null-ls")
require("plugins.lsp.lspsaga_conf")
require("plugins.lsp.rust_tools_conf")
