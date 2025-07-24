return {
	name = "lua-ls",
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_dir = vim.fs.root(0, { ".stylua.toml", ".git" }) or vim.uv.cwd(),
	capabilities = UTIL.capabilities(),
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" },
			telemetry = { enable = false },
			globals = { "vim", "hs", "UTIL" },
			workspace = {
				library = {
					vim.fn.expand("$VIMRUNTIME/lua"),
					vim.fn.expand("$VIMRUNTIME/lua/vim/lsp"),
					"${3rd}/luv/library",
				},
				maxPreload = 100000,
				preloadFileSize = 10000,
				checkThirdParty = false,
			},
		},
	},
	single_file_support = true,
	log_level = vim.lsp.protocol.MessageType.Warning,
}
