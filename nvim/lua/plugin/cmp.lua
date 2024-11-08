local jump_out = function()
	local node_ok, node = pcall(vim.treesitter.get_node)
	if not node_ok or not node then
		vim.notify("TS not available")
		return
	end
	local row, col = node:end_()
	pcall(vim.api.nvim_win_set_cursor, 0, { row + 1, col })
end

vim.keymap.set({ "s", "i" }, "<Tab>", jump_out, { desc = "Smart tab (jump out)" })

return {
	"iguanacucumber/magazine.nvim",
	name = "nvim-cmp",
	version = false,
	event = "InsertEnter",
	dependencies = {
		{ "iguanacucumber/mag-nvim-lsp", name = "cmp-nvim-lsp", opts = {} },
		{ "https://codeberg.org/FelipeLema/cmp-async-path" },
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

			performance = {
				debounce = 20,
				throttle = 10,
			},

			snippet = {
				expand = function(args)
					vim.snippet.expand(args.body)
				end,
			},

			mapping = {
				["<C-u>"] = cmp.mapping.scroll_docs(-4),
				["<C-d>"] = cmp.mapping.scroll_docs(4),
				["<C-h>"] = cmp.mapping.abort(),
				["<C-l>"] = cmp.mapping.complete(),
				["<CR>"] = cmp.mapping.confirm({ select = true }),
				["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }, { "i", "s" }),
				["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }, { "i", "s" }),

				["<Tab>"] = cmp.mapping(function(fallback)
					if vim.snippet.active({ direction = 1 }) then
						-- local old_pos = vim.api.nvim_win_get_cursor(0)
						vim.snippet.jump(1)
						-- local new_pos = vim.api.nvim_win_get_cursor(0)

						-- if old_pos[1] == new_pos[1] and old_pos[2] == new_pos[2] then
						-- 	vim.snippet.stop()
						-- 	fallback()
						-- end
					else
						fallback()
					end
				end, { "i", "s" }),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if vim.snippet.active({ direction = -1 }) then
						vim.snippet.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
			},

			sources = cmp.config.sources({
				{ name = "nvim_lsp", priority = 8 },
				{ name = "async_path", priority = 6 },
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
