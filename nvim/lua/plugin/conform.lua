local conform = require("conform")

conform.setup({
	formatters = {
		sleek = {
			command = "sleek",
		},
	},
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "ruff_format", "ruff_fix" },
		html = { "djlint" },
		rust = { "rustfmt" },
		sql = { "sleek" },
		toml = { "taplo" },
		javascript = { "biome" },
		javascriptreact = { "biome" },
		typescript = { "biome" },
		typescriptreact = { "biome" },
		nix = { "nixfmt" },
		json = { "jq" },
		markdown = { "deno_fmt" },
		-- yml = { "yamlfmt" },
		-- yaml = { "yamlfmt" },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_fallback = true,
	},
})

vim.keymap.set("n", "gf", function()
	conform.format({ async = true, lsp_fallback = true })
end, {
	desc = "Format buffer",
})
