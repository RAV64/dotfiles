return {
	{
		"ggandor/leap.nvim",
		keys = {
			{ "s", mode = { "n", "x", "o" }, desc = "Leap forward to" },
			{ "S", mode = { "n", "x", "o" }, desc = "Leap backward to" },
		},
		config = function()
			require("leap").add_default_mappings(true)
		end,
	},
	{ "boltlessengineer/smart-tab.nvim", keys = { { mode = "i", "<tab>" } }, opts = { skips = {} } },
}
