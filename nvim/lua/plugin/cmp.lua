return {
	"hrsh7th/nvim-cmp",
	version = false,
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-path",
	},
	config = function()
		local icons = require("config.util").icons
		local cmp = require("cmp")
		local compare = cmp.config.compare

		-- require("cmp.entry").get_documentation = function(self)
		-- 	local item = self:get_completion_item()
		--
		-- 	if item.documentation then
		-- 		return vim.lsp.util.convert_input_to_markdown_lines(item.documentation)
		-- 	end
		--
		-- 	if item.detail then
		-- 		local ft = self.context.filetype
		-- 		local dot_index = string.find(ft, "%.")
		-- 		if dot_index ~= nil then
		-- 			ft = string.sub(ft, 0, dot_index - 1)
		-- 		end
		-- 		return (vim.split(("```%s\n%s```"):format(ft, vim.trim(item.detail)), "\n"))
		-- 	end
		--
		-- 	return {}
		-- end

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
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
				["<CR>"] = cmp.mapping.confirm({ select = true }),
				["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
				["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
				["<Tab>"] = cmp.mapping(function(fallback)
					if vim.snippet.jumpable(1) then
						vim.snippet.jump(1)
					else
						fallback()
					end
				end, { "i", "s" }),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if vim.snippet.jumpable(-1) then
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
					item.kind = " " .. icons[item.kind] .. " "
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
