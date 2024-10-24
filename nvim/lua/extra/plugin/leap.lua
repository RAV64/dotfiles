-- LeapLabelPrimary = { bg = C.text, fg = base },
return {
	"ggandor/leap.nvim",
	keys = {
		{ "t", mode = { "n", "x", "o" }, desc = "Leap forward to" },
		{ "T", mode = { "n", "x", "o" }, desc = "Leap backward to" },
	},
	config = function()
		local leap = require("leap")
		leap.add_default_mappings(true)
		leap.opts.safe_labels = {}
	end,
}
