-- LeapLabelPrimary = { bg = C.text, fg = base },
return {
	"ggandor/leap.nvim",
	keys = {
		{ "s", mode = { "n", "x", "o" }, desc = "Leap forward to" },
		{ "S", mode = { "n", "x", "o" }, desc = "Leap backward to" },
	},
	config = function()
		local leap = require("leap")
		leap.add_default_mappings(true)
		leap.opts.safe_labels = {}
	end,
}
