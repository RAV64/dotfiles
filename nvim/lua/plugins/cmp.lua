return {
	"hrsh7th/nvim-cmp",
	version = false, -- last release is way too old
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"saadparwaiz1/cmp_luasnip",
		{
			"Saecki/crates.nvim",
			event = { "BufRead Cargo.toml" },
			config = true,
		},
	},
	opts = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		return {
			completion = {
				completeopt = "menu,menuone,noinsert",
			},
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-k>"] = cmp.mapping.scroll_docs(-4),
				["<C-j>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.close(),
				["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					else
						fallback()
					end
				end, { "i", "s" }),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "buffer" },
				{ name = "path" },
			}),
			formatting = {
				format = function(entry, vim_item)
					local icons = {
						Class = "ﴯ",
						Color = "",
						Constant = "",
						Constructor = "",
						Enum = "",
						EnumMember = "",
						Event = "",
						Field = "ﰠ",
						File = "",
						Folder = "",
						Function = "",
						Interface = "",
						Keyword = "",
						Method = "",
						Module = "",
						Operator = "",
						Property = "ﰠ",
						Reference = "",
						Snippet = "",
						Struct = "פּ",
						Text = "",
						TypeParameter = "",
						Unit = "塞",
						Value = "",
						Variable = "",
					}
					vim_item.kind = string.format("%s", icons[vim_item.kind])
					vim_item.menu = ({})[entry.source.name]

					return vim_item
				end,
			},
			experimental = {
				ghost_text = {
					hl_group = "LspCodeLens",
				},
			},
		}
	end,
}
