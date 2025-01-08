local M = {}

local commands = {
	select_next = "select_next",
	select_prev = "select_prev",
	snippet_forward = "snippet_forward",
	snippet_backward = "snippet_backward",
	select_and_accept = "select_and_accept",
	fallback = "fallback",
	hide = "hide",
	show = "show",
	cancel = "cancel",
	show_documentation = "show_documentation",
	hide_documentation = "hide_documentation",
	scroll_documentation_up = "scroll_documentation_up",
	scroll_documentation_down = "scroll_documentation_down",
}

M.plugin = {
	{
		"xzbdmw/colorful-menu.nvim",
		opts = {
			ls = {
				lua_ls = { arguments_hl = "@comment" },
				gopls = { add_colon_before_type = false },
				ts_ls = { extra_info_hl = "@comment" },
				vtsls = { extra_info_hl = "@comment" },
				["rust-analyzer"] = { extra_info_hl = "@comment" },
				clangd = { extra_info_hl = "@comment" },
				roslyn = { extra_info_hl = "@comment" },
				basedpyright = { extra_info_hl = "@comment" },
				fallback = true,
			},
			fallback_highlight = "@variable",
			max_width = 60,
		},
	},
	{
		"saghen/blink.cmp",
		dependencies = { "xzbdmw/colorful-menu.nvim", "echasnovski/mini.icons" },

		event = "InsertEnter",
		version = "*",
		enabled = function()
			return not vim.bo.buftype ~= "prompt" and vim.b.completion ~= false
		end,

		config = function()
			local cm = require("colorful-menu")
			local icons = require("mini.icons")
			require("blink.cmp").setup({
				keymap = {
					preset = "none",
					["<C-k>"] = { commands.select_prev, commands.fallback },
					["<C-j>"] = { commands.select_next, commands.fallback },
					["<C-h>"] = { commands.hide_documentation, commands.hide, commands.cancel },
					["<C-l>"] = { commands.show_documentation, commands.show },
					["<C-u>"] = { commands.scroll_documentation_up, commands.fallback },
					["<C-d>"] = { commands.scroll_documentation_down, commands.fallback },
					["<Tab>"] = { commands.snippet_forward, commands.fallback },
					["<S-Tab>"] = { commands.snippet_backward },
					["<CR>"] = { commands.select_and_accept, commands.fallback },
				},

				appearance = {
					nerd_font_variant = "mono",
				},

				sources = { default = { "lsp", "path", "snippets" } },
				completion = {
					menu = {
						auto_show = function(ctx)
							return ctx.mode ~= "cmdline"
						end,
						draw = {
							columns = { { "kind_icon" }, { "label", gap = 1 } },
							components = {
								label = {
									text = cm.blink_components_text,
									highlight = cm.blink_components_highlight,
								},
								kind_icon = {
									ellipsis = false,
									text = function(ctx)
										local kind_icon, _, _ = icons.get("lsp", ctx.kind)
										return kind_icon
									end,
								},
							},
						},
					},
				},
			})
		end,
		opts_extend = { "sources.default" },
	},
}

-- M.plugin = {
-- 	"iguanacucumber/magazine.nvim",
-- 	name = "nvim-cmp",
-- 	version = false,
-- 	event = "InsertEnter",
-- 	dependencies = {
-- 		{ "iguanacucumber/mag-nvim-lsp", name = "cmp-nvim-lsp", opts = {} },
-- 		{ "https://codeberg.org/FelipeLema/cmp-async-path" },
-- 	},
-- 	config = function()
-- 		vim.opt.completeopt = { "menu", "menuone", "noselect" }
--
-- 		local cmp = require("cmp")
-- 		local icons = require("mini.icons")
-- 		local compare = cmp.config.compare
--
-- 		cmp.setup({
--
-- 			window = {
-- 				completion = {
-- 					col_offset = -3,
-- 					side_padding = 0,
-- 					winhighlight = "NormalFloat:CmpBackground",
-- 				},
-- 				documentation = {
-- 					winhighlight = "Normal:CmpBackground",
-- 				},
-- 			},
--
-- 			performance = {
-- 				debounce = 20,
-- 				throttle = 10,
-- 			},
--
-- 			snippet = {
-- 				expand = function(args)
-- 					vim.snippet.expand(args.body)
-- 				end,
-- 			},
--
-- 			mapping = {
-- 				["<C-u>"] = cmp.mapping.scroll_docs(-4),
-- 				["<C-d>"] = cmp.mapping.scroll_docs(4),
-- 				["<C-h>"] = cmp.mapping.abort(),
-- 				["<C-l>"] = cmp.mapping.complete(),
-- 				["<CR>"] = cmp.mapping.confirm({ select = true }),
-- 				["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }, { "i", "s" }),
-- 				["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }, { "i", "s" }),
--
-- 				["<Tab>"] = cmp.mapping(function(fallback)
-- 					if vim.snippet.active({ direction = 1 }) then
-- 						-- local old_pos = vim.api.nvim_win_get_cursor(0)
-- 						vim.snippet.jump(1)
-- 						-- local new_pos = vim.api.nvim_win_get_cursor(0)
--
-- 						-- if old_pos[1] == new_pos[1] and old_pos[2] == new_pos[2] then
-- 						-- 	vim.snippet.stop()
-- 						-- 	fallback()
-- 						-- end
-- 					else
-- 						fallback()
-- 					end
-- 				end, { "i", "s" }),
-- 				["<S-Tab>"] = cmp.mapping(function(fallback)
-- 					if vim.snippet.active({ direction = -1 }) then
-- 						vim.snippet.jump(-1)
-- 					else
-- 						fallback()
-- 					end
-- 				end, { "i", "s" }),
-- 			},
--
-- 			sources = cmp.config.sources({
-- 				{ name = "nvim_lsp", priority = 8 },
-- 				{ name = "async_path", priority = 6 },
-- 			}),
--
-- 			formatting = {
-- 				fields = { "kind", "abbr" },
-- 				format = function(_, item)
-- 					item.kind = " " .. icons.get("lsp", item.kind) .. " "
-- 					item.menu = "" -- Removes empty space from completion menu
-- 					return item
-- 				end,
-- 			},
--
-- 			sorting = {
-- 				priority_weight = 1.0,
-- 				comparators = {
-- 					compare.offset,
-- 					compare.exact,
-- 					compare.score,
-- 					compare.recently_used,
-- 					compare.sort_text,
-- 					compare.length,
-- 				},
-- 			},
-- 		})
-- 	end,
-- }

return M.plugin
