local smart_tab = function()
	local node_ok, node = pcall(vim.treesitter.get_node)
	if not node_ok then
		vim.notify("TS not available")
		return false
	end
	-- if not node then
	-- 	vim.notify("parent not")
	-- 	return false
	-- end
	local row, col = node:end_()
	local ok = pcall(vim.api.nvim_win_set_cursor, 0, { row + 1, col })
	return ok
end

return {
	"hrsh7th/nvim-cmp",
	version = false,
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-path",
	},
	config = function()
		vim.opt.completeopt = { "menu", "menuone", "noselect" }

		local cmp = require("cmp")
		local icons = require("mini.icons")
		local compare = cmp.config.compare

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
					vim.snippet.expand(args.body)
				end,
			},

			mapping = cmp.mapping.preset.insert({
				["<C-u>"] = cmp.mapping.scroll_docs(-4),
				["<C-d>"] = cmp.mapping.scroll_docs(4),
				["<C-h>"] = cmp.mapping.abort(),
				["<CR>"] = cmp.mapping.confirm({ select = true }),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
				["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
				["<Tab>"] = cmp.mapping(function()
					if vim.snippet.active({ direction = 1 }) then
						vim.snippet.jump(1)
					else
						smart_tab()
					end
				end, { "i", "s" }),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if vim.snippet.active({ direction = -1 }) then
						vim.snippet.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
			}),

			sources = cmp.config.sources({
				{ name = "nvim_lsp", priority = 8 },
				{ name = "path", priority = 6 },
				-- { name = "buffer", priority = 5, keyword_length = 3 },
			}),

			formatting = {
				fields = { "kind", "abbr" },
				format = function(_, item)
					item.kind = " " .. icons.get("lsp", item.kind) .. " "
					item.menu = "" -- Removes empty space from completion menu
					return item
				end,
			},

			sorting = {
				priority_weight = 1.0,
				comparators = {
					compare.offset,
					compare.exact,
					compare.score,
					compare.recently_used,
					compare.sort_text,
					compare.length,
				},
			},
		})
	end,
}
