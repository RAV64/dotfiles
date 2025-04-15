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
		commit = "f80feb8a6706f965321aff24d0ed3849f02a7f77",
		config = true,
	},
	{
		"saghen/blink.cmp",
		commit = "cb5e346d9e0efa7a3eee7fd4da0b690c48d2a98e",
		dependencies = { "xzbdmw/colorful-menu.nvim" },
		event = "InsertEnter",
		version = "*",
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
					["<up>"] = { commands.select_prev, commands.fallback },
					["<down>"] = { commands.select_next, commands.fallback },
					["<left>"] = { commands.hide_documentation, commands.hide, commands.cancel },
					["<right>"] = { commands.show_documentation, commands.show },
					["<C-u>"] = { commands.scroll_documentation_up, commands.fallback },
					["<C-d>"] = { commands.scroll_documentation_down, commands.fallback },
					["<Tab>"] = { commands.snippet_forward, commands.fallback },
					["<S-Tab>"] = { commands.snippet_backward },
					["<CR>"] = { commands.select_and_accept, commands.fallback },
				},

				appearance = {
					nerd_font_variant = "mono",
				},

				cmdline = { enabled = false },

				sources = {
					default = { "lsp", "path", "snippets" },
				},
				completion = {
					menu = {
						draw = {
							columns = { { "kind_icon" }, { "label", gap = 1 } },
							components = {
								label = {
									text = function(ctx)
										return cm.blink_components_text(ctx)
									end,
									highlight = function(ctx)
										return cm.blink_components_highlight(ctx)
									end,
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

return M.plugin
