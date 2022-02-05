function Pain()
  if vim.api.nvim_get_mode().mode == "i" then
    vim.api.nvim_command("hi! CursorLine guifg=NONE guibg=#3d5122")
  else
    vim.api.nvim_command("hi! CursorLine guifg=NONE guibg=#47535d")
  end
end
  --og #2F3243
	--local colors = {
	--	bg = "#202328",
	--	fg = "#bbc2cf",
	--	yellow = "#ECBE7B",
	--	cyan = "#008080",
	--	darkblue = "#081633",
	--	green = "#3d5122",
	--	orange = "#FF8800",
	--	violet = "#a9a1e1",
	--	magenta = "#c678dd",
	--	blue = "#51afef",
	--	red = "#6f3328",
	--}

	--local mode_color = {
	--	n = colors.red,
	--	i = colors.green,
	--	v = colors.yellow,
	--	V = colors.blue,
	--	c = colors.magenta,
	--	no = colors.red,
	--	s = colors.orange,
	--	S = colors.orange,
	--	ic = colors.yellow,
	--	R = colors.violet,
	--	Rv = colors.violet,
	--	cv = colors.red,
	--	ce = colors.red,
	--	r = colors.cyan,
	--	rm = colors.cyan,
	--	tr= colors.red,
	--}
  --local color = mode_color[vim.api.nvim_get_mode().mode]
  --vim.api.nvim_set_hl(0, 'Normal', { fg = "#ffffff", bg = "#333333" })
  --vim.api.nvim_command("hi! CursorLine guifg=NONE guibg=".. color)
