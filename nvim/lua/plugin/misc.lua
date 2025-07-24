local mini_icons = require("mini.icons")

package.preload["nvim-web-devicons"] = function()
	mini_icons.mock_nvim_web_devicons()
	return package.loaded["nvim-web-devicons"]
end

mini_icons.setup()

local mini_files = require("mini.files")

mini_files.setup({
	mappings = {
		go_in = "",
		go_in_plus = "<CR>",
		go_out = "<BS>",
		go_out_plus = "",
		reset = "",
	},
})

vim.keymap.set("n", "-", function()
	mini_files.open(vim.api.nvim_buf_get_name(0), false)
end)

local flash = require("flash")

flash.setup({
	highlight = {
		backdrop = false,
		matches = false,
	},
	modes = {
		char = { enabled = false },
		prompt = { enabled = false },
	},
})

vim.keymap.set({ "n", "x", "o" }, "s", function()
	flash.jump()
end, { desc = "Flash" })
