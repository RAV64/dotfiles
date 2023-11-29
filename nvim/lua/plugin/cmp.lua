local luasnip

return {
	"hrsh7th/nvim-cmp",
	version = false,
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-path",
		{
			"saadparwaiz1/cmp_luasnip",
			dependencies = {
				"L3MON4D3/LuaSnip",
				dependencies = { "rafamadriz/friendly-snippets" },
				config = function()
					require("luasnip.loaders.from_vscode").lazy_load()
					luasnip = require("luasnip")
					vim.api.nvim_create_autocmd("InsertLeave", {
						callback = function()
							if
								luasnip.session.current_nodes[vim.api.nvim_get_current_buf()]
								and not luasnip.session.jump_active
							then
								luasnip.unlink_current()
							end
						end,
					})
				end,
			},
		},
	},
	config = function()
		local icons = require("config.util").icons
		local cmp = require("cmp")
		local default = require("cmp.config.default")()
		cmp.setup({
			window = {
				completion = {
					col_offset = -3,
					side_padding = 0,
					winhighlight = "NormalFloat:CmpBackground",
				},
				documentation = {
					winhighlight = "Normal:CmpBackground",
				},
			},
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-u>"] = cmp.mapping.scroll_docs(-4),
				["<C-d>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
				["<CR>"] = cmp.mapping.confirm({ select = true }),
				["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
				["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
				["<Tab>"] = cmp.mapping(function(fallback)
					if luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					else
						fallback()
					end
				end, { "i", "s" }),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "path" },
				-- { name = "buffer" },
			}),
			formatting = {
				fields = { "kind", "abbr" },
				format = function(_, item)
					item.kind = " " .. icons[item.kind] .. " "
					item.menu = "" -- Removes empty space from completion menu
					return item
				end,
			},
			sorting = default.sorting,
		})
	end,
}
