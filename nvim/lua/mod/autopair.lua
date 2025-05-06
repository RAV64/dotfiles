local cursor, line, set = vim.api.nvim_win_get_cursor, vim.api.nvim_get_current_line, vim.keymap.set
local replace = function(s)
	return vim.api.nvim_replace_termcodes(s, true, true, true)
end

local pairs_map = { ["("] = ")", ["["] = "]", ["{"] = "}", ["<"] = ">", ['"'] = '"' }
local codes = { BS = replace("<BS>"), DEL = replace("<Del>"), U = replace("<C-g>U<Left>"), N = replace("<Esc>O") }

for open, close in pairs(pairs_map) do
	set("i", open, function()
		local col, txt = cursor(0)[2] + 1, line()
		if txt:sub(col - 1, col - 1) == "\\" or txt:sub(col, col):match("%w") then
			return open
		end
		return open .. close .. codes.U
	end, { expr = true, noremap = true, replace_keycodes = false })
end

for key, act in pairs({
	["<BS>"] = { codes.BS .. codes.DEL, "\b" },
	["<CR>"] = { "\r" .. codes.N, "\r" },
}) do
	set("i", key, function()
		local col, txt = cursor(0)[2] + 1, line()
		if pairs_map[txt:sub(col - 1, col - 1)] == txt:sub(col, col) then
			return act[1]
		end
		return act[2]
	end, { expr = true, noremap = true, replace_keycodes = false })
end
