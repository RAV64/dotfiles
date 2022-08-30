local cmp_status, cmp = pcall(require, "cmp")
if not cmp_status then
	print("Error: cmp")
	return
end

local luasnip_status, luasnip = pcall(require, "luasnip")
if not luasnip_status then
	print("Error: luasnip")
	return
end

require("luasnip/loaders/from_vscode").lazy_load()

cmp.setup({
	mapping = {
		["<C-k>"] = cmp.mapping.scroll_docs(-4),
		["<C-j>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		["<Tab>"] = function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end,
		["<S-Tab>"] = function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end,
	},
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
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
				Struct = "פּ",
				Text = "",
				TypeParameter = "",
				Unit = "塞",
				Value = "",
				Variable = "",
			}
			vim_item.kind = string.format("%s", icons[vim_item.kind])
			vim_item.menu = ({})[entry.source.name]

			return vim_item
		end,
	},

	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "buffer" },
		{ name = "nvim_lua" },
		{ name = "path" },
	},
	-- confirm_opts = {
	-- 	behavior = cmp.ConfirmBehavior.Replace,
	-- 	select = false,
	-- },

	experimental = {
		native_menu = false,
		ghost_text = true,
	},
})
