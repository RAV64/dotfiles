local status, bufferline = pcall(require, "bufferline")
if not status then
	print("ERROR lualine")
	return
end

bufferline.setup({
	options = {
		modified_icon = "✨",
		indicator_icon = "|",
		numbers = "ordinal",
		max_name_length = 15,
		max_prefix_length = 6,
		tab_size = 15,
		view = "multiwindow",
		diagnostics = "nvim_lsp",
		enforce_regular_tabs = false,
		diagnostics_indicator = function(count, level)
			local icon = level:match("error") and " " or ""
			return icon .. count
		end,
		show_buffer_icons = true,
		show_buffer_close_icons = false,
		show_close_icon = false,
		persist_buffer_sort = true,
	},
})

for i = 1, 10 do
	vim.keymap.set("n", "<A-" .. i .. ">", function()
		print(i)
	end)
end

