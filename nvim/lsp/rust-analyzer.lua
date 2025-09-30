-- https://rust-analyzer.github.io/book/configuration.html

local cfg = {
	cargo = { buildScripts = { enable = true } },
	procMacro = { enable = true },
	checkOnSave = true,
	imports = {
		granularity = { enforce = true, group = "module" },
		merge = { glob = false },
	},
	check = { command = "clippy" },
}

return {
	name = "rust-analyzer",
	cmd = { "rust-analyzer" },
	filetypes = { "rust" },
	root_dir = vim.fs.root(0, { "Cargo.toml", ".git" }),
	capabilities = UTIL.capabilities({
		{
			experimental = {
				serverStatusNotification = true,
			},
		},
	}),
	settings = {
		["rust-analyzer"] = cfg,
	},
	before_init = function(init_params, _)
		-- See https://github.com/rust-lang/rust-analyzer/blob/eb5da56d839ae0a9e9f50774fa3eb78eb0964550/docs/dev/lsp-extensions.md?plain=1#L26
		init_params.initializationOptions = cfg
	end,
}
