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
}
