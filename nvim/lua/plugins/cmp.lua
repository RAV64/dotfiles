return {
	"hrsh7th/nvim-cmp",
	version = false,
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
		vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
		local cmp = require("cmp")
		local cmp_autopairs = require("nvim-autopairs.completion.cmp")
		local luasnip = require("luasnip")
		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		return {
			window = {
				completion = {
					col_offset = -3,
					side_padding = 0,
					winhighlight = "NormalFloat:TablineActive",
				},
			},
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-k>"] = cmp.mapping.scroll_docs(-4),
				["<C-j>"] = cmp.mapping.scroll_docs(4),
				---@diagnostic disable-next-line: missing-parameter
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
				fields = { "kind", "abbr" },
				format = function(_, vim_item)
					local icons = {
						Class = "",
						Color = "",
						Constant = "",
						Constructor = "󱌢",
						Enum = "",
						EnumMember = "",
						Event = "",
						Field = "",
						File = "",
						Folder = "",
						Function = "󰊕",
						Interface = "",
						Keyword = "",
						Method = "",
						Module = "󰕳",
						Operator = "",
						Property = "",
						Reference = "",
						Snippet = "",
						Struct = "",
						Text = "",
						TypeParameter = "",
						Unit = "",
						Value = "",
						Variable = "󰫧",
					}
					vim_item.kind = string.format("%s", " " .. icons[vim_item.kind] .. " ")
					return vim_item
				end,
			},
			sorting = require("cmp.config.default")().sorting,
			experimental = {
				ghost_text = {
					hl_group = "CmpGhostText",
				},
			},
		}
	end,
}
