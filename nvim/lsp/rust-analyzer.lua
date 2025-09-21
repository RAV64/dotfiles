return {
	name = "rust-analyzer",
	cmd = { "rust-analyzer" },
	filetypes = { "rust" },
	single_file_support = true,
	root_dir = vim.fs.root(0, { "Cargo.toml", ".git" }),
	capabilities = UTIL.capabilities({
		{
			experimental = {
				commands = {
					"rust-analyzer.runSingle",
					"rust-analyzer.showReferences",
					"rust-analyzer.gotoLocation",
					-- "editor.action.triggerParameterHints",
				},
				codeActionGroup = false,
				hoverActions = false,
				hoverRange = false,
				serverStatusNotification = true,
				snippetTextEdit = false,
				ssr = true,
			},
			textDocument = {
				completion = {
					completionItem = {
						resolveSupport = {
							properties = { "documentation", "detail", "additionalTextEdits" },
						},
					},
				},
			},
		},
	}),
	init_options = {
		-- cargo = { allFeatures = true },
		runBuildScripts = { enable = true },
		procMacro = { enable = true },
		checkOnSave = true,
		imports = {
			granularity = {
				enforce = true,
				group = "module",
			},
			merge = {
				glob = false,
			},
			preferNoStd = true,
		},
		check = {
			command = "clippy",
			-- features = "all",
		},
		provideFormatter = true,
	},
	before_init = function(init_params, config)
		-- See https://github.com/rust-lang/rust-analyzer/blob/eb5da56d839ae0a9e9f50774fa3eb78eb0964550/docs/dev/lsp-extensions.md?plain=1#L26
		if config.settings and config.settings["rust-analyzer"] then
			init_params.initializationOptions = config.settings["rust-analyzer"]
		end
	end,
}
