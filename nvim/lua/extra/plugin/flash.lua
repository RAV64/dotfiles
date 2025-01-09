return {
	"folke/flash.nvim",
	event = "VeryLazy",
	opts = {
		highlight = {
			backdrop = false,
			matches = false,
		},
		modes = {
			char = { enabled = false },
			prompt = { enabled = false },
		},
	},
	keys = {
		{
			"s",
			mode = { "n", "x", "o" },
			function()
				UTIL.func("flash", "jump")
			end,
			desc = "Flash",
		},
	},
}
