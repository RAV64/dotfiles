local present1, autopairs = pcall(require, "nvim-autopairs")
local present2, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")

if present1 and present2 then
	autopairs.setup({
		disable_filetype = { "TelescopePrompt" },
		disable_in_visualblock = false,
		ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]], "%s+", ""),
		enable_moveright = true,
		enable_afterquote = true,
		enable_check_bracket_line = true,
		check_ts = true,
		map_bs = true,
		map_c_h = true,
	})
end

local cmp = require("cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
