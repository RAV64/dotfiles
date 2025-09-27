local cursor, line, set = vim.api.nvim_win_get_cursor, vim.api.nvim_get_current_line, vim.keymap.set
--              (     )    [     ]    {      }     <     >    "     "
local bmap = { [40] = 41, [91] = 93, [123] = 125, [60] = 62, [34] = 34 }

for ob, cb in pairs(bmap) do
	local open, close = string.char(ob), string.char(cb)
	local pair = open .. close .. "<C-g>U<Left>"
	set("i", open, function()
		local col, txt = cursor(0)[2] + 1, line()
		local char = txt:byte(col)
		if (char and char ~= 32) or (col > 1 and txt:byte(col - 1) == 92) then
			return open
		end
		return pair
	end, { expr = true, noremap = true })
end

for key, act in pairs({ ["<BS>"] = { "<BS><Del>", "<BS>" }, ["<CR>"] = { "\r<Esc>O", "\r" } }) do
	set("i", key, function()
		local col, txt = cursor(0)[2] + 1, line()
		local prev = col > 1 and txt:byte(col - 1) or nil
		local char = txt:byte(col)
		return (prev and char and bmap[prev] == char) and act[1] or act[2]
	end, { expr = true, noremap = true })
end
