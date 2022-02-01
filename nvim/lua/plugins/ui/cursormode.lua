function Pain()
	local colors = {
		bg = "#202328",
		fg = "#bbc2cf",
		yellow = "#ECBE7B",
		cyan = "#008080",
		darkblue = "#081633",
		green = "#3d5122",
		orange = "#FF8800",
		violet = "#a9a1e1",
		magenta = "#c678dd",
		blue = "#51afef",
		red = "#6f3328",
	}

	local mode_color = {
		n = colors.red,
		i = colors.green,
		v = colors.yellow,
		V = colors.blue,
		c = colors.magenta,
		no = colors.red,
		s = colors.orange,
		S = colors.orange,
		ic = colors.yellow,
		R = colors.violet,
		Rv = colors.violet,
		cv = colors.red,
		ce = colors.red,
		r = colors.cyan,
		rm = colors.cyan,
		tr= colors.red,
	}
  local color = mode_color[vim.api.nvim_get_mode().mode]
  if color == nil then
    color = "NONE"
  end
  vim.api.nvim_command("hi! CursorLine guifg=NONE guibg=".. color)
end

vim.api.nvim_command([[autocmd ModeChanged * lua Pain()]])
