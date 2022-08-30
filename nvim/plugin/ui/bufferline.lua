local status, bufferline = pcall(require, "bufferline")
if not status then
	print("ERROR: bufferline")
	return
end

require("bufferline.constants").padding = ""
require("bufferline.constants").ELLIPSIS = "   "

bufferline.setup({
	options = {
		diagnostics = "nvim_lsp",
		enforce_regular_tabs = false,
		indicator = { icon = "" },
		max_name_length = 30,
		max_prefix_length = 6,
		modified_icon = "●",
		persist_buffer_sort = true,
		show_buffer_close_icons = false,
		show_buffer_icons = true,
		show_close_icon = false,
		name_formatter = function(opts)
			return string.format(" %s ", opts.name)
		end,
		numbers = function(opts)
			return string.format(" %s ", opts.ordinal)
		end,
		diagnostics_indicator = function(count, level)
			local icon = level:match("error") and "" or ""
			return icon .. count
		end,
		offsets = {
			{
				filetype = "NvimTree",
				text = vim.fn.fnamemodify(vim.fn.getcwd(), ":~") .. "/" .. string.rep(" ", 30),
				text_align = "left",
			},
		},
	},
})

local nnoremap = require("rav64.keymaps").nnoremap

for i = 1, 9 do
	nnoremap("<leader>" .. i, function()
		require("bufferline").go_to_buffer(i, true)
	end)
end

nnoremap("<leader>" .. 0, function()
	require("bufferline").go_to_buffer(-1, true)
end)

nnoremap("<Tab>", function()
	require("bufferline").cycle(1)
end)
nnoremap("<S-Tab>", function()
	require("bufferline").cycle(-1)
end)
