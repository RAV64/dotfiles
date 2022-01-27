local status, bufferline = pcall(require, "bufferline")
if not status then
  print("ERROR: bufferline")
  return
end

require("bufferline").setup{
  options = {
    numbers = function(opts)
    return string.format('%s|%s.', opts.id, opts.raise(opts.ordinal))
  end,
    modified_icon = '✨ ',
    max_name_length = 15,
    max_prefix_length = 6,
    tab_size = 1,
    diagnostics = "nvim_lsp",
    diagnostics_indicator = function(count, level)
        local icon = level:match("error") and " " or ""
        return " " .. icon .. count
    end,
    offsets = {
      {filetype = "CHADTree", text = "🔮 File Explorer 🔮"},
      {filetype = "tagbar", text = "🔍 Navigator 🔎"},
    },
    show_buffer_icons = true,
    show_buffer_close_icons = false,
    show_close_icon = false,
    persist_buffer_sort = true,
  }
}
