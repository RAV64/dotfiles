-- LeapLabelPrimary = { bg = C.text, fg = base },
return {
	"ggandor/leap.nvim",
	lazy = false,
	config = function()
		local leap = require("leap")
		leap.add_default_mappings(true)
		leap.opts = { safe_labels = {}, equivalence_classes = { " \t\r\n" } }
	end,
}
