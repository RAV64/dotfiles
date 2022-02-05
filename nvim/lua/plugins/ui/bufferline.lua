local status, bufferline = pcall(require, "bufferline")
if not status then
	print("ERROR: bufferline")
	return
end

bufferline.setup({
	options = {
		modified_icon = "✨ ",
		max_name_length = 15,
		max_prefix_length = 6,
		view = "multiwindow",
		diagnostics = "nvim_lsp",
		enforce_regular_tabs = false,
		diagnostics_indicator = function(count, level)
			local icon = level:match("error") and " " or ""
			return " " .. icon .. count
		end,
		offsets = {
			{ filetype = "CHADTree", text = "🔮 File Explorer 🔮" },
			{ filetype = "tagbar", text = "🔍 Navigator 🔎" },
		},
		show_buffer_icons = true,
		show_buffer_close_icons = false,
		show_close_icon = false,
		persist_buffer_sort = true,
		custom_filter = function(buf_number)
			local present_type, type = pcall(function()
				return vim.api.nvim_buf_get_var(buf_number, "term_type")
			end)

			if present_type then
				if type == "vert" then
					return false
				elseif type == "hori" then
					return false
				end
				return true
			end

			return true
		end,
	},
})
