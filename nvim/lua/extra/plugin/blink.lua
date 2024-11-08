local smart_tab = function()
	local node_ok, node = pcall(vim.treesitter.get_node)
	if not node_ok or not node then
		vim.notify("TS not available")
		return
	end
	local row, col = node:end_()
	pcall(vim.api.nvim_win_set_cursor, 0, { row + 1, col })
end

vim.keymap.set("i", "<tab>", function()
	smart_tab()
end)

return {
	"saghen/blink.cmp",
	version = "*",
	opts_extend = { "sources.completion.enabled_providers" },
	event = "InsertEnter",

	opts = {
		windows = {
			autocomplete = {
				draw = function(ctx)
					return {
						{
							" " .. ctx.kind_icon .. " ",
							hl_group = "BlinkCmpKind" .. ctx.kind,
						},
						" ",
						{
							ctx.label,
							ctx.kind == "Snippet" and "~" or nil,
							hl_group = ctx.deprecated and "Comment" or "BlinkCmpLabel",
							max_width = 50,
						},
					}
				end,
				selection = "auto_insert",
				winhighlight = "NormalFloat:CmpBackground",
			},

			documentation = {
				auto_show = true,
			},
			ghost_text = {
				enabled = false,
			},
		},

		accept = { auto_brackets = { enabled = true } },

		sources = {
			completion = {
				enabled_providers = { "lsp", "path", "snippets" },
			},
		},

		keymap = {
			["<C-l>"] = { "show", "show_documentation", "hide_documentation" },
			["<C-h>"] = { "hide" },
			["<C-k>"] = { "select_prev" },
			["<C-j>"] = { "select_next" },
			["<CR>"] = { "accept" },
			["<C-u>"] = { "scroll_documentation_up", "fallback" },
			["<C-d>"] = { "scroll_documentation_down", "fallback" },
			["<Tab>"] = { "snippet_forward", "fallback" },
			["<S-Tab>"] = { "snippet_backward", "fallback" },
		},
	},
}
