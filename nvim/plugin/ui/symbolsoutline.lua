local status, so = pcall(require, "symbols-outline")
if not status then
	print("ERROR: symbols-outline")
	return
end

so.setup({
	symbols = {
		Array = { icon = "", hl = "TSConstant" },
		Boolean = { icon = "⊨", hl = "TSBoolean" },
		Class = { icon = "ﴯ", hl = "TSType" },
		Constant = { icon = "", hl = "TSConstant" },
		Constructor = { icon = "", hl = "TSConstructor" },
		Enum = { icon = "", hl = "TSType" },
		EnumMember = { icon = "", hl = "TSField" },
		Event = { icon = "", hl = "TSType" },
		Field = { icon = "ﰠ", hl = "TSField" },
		File = { icon = "", hl = "TSURI" },
		Function = { icon = "", hl = "TSFunction" },
		Interface = { icon = "", hl = "TSType" },
		Key = { icon = "", hl = "TSType" },
		Method = { icon = "", hl = "TSMethod" },
		Module = { icon = "", hl = "TSNamespace" },
		Namespace = { icon = "", hl = "TSNamespace" },
		Null = { icon = "NULL", hl = "TSType" },
		Number = { icon = "#", hl = "TSNumber" },
		Object = { icon = "⦿", hl = "TSType" },
		Operator = { icon = "", hl = "TSOperator" },
		Package = { icon = "", hl = "TSNamespace" },
		Property = { icon = "ﰠ", hl = "TSMethod" },
		String = { icon = "𝓐", hl = "TSString" },
		Struct = { icon = "פּ", hl = "TSType" },
		TypeParameter = { icon = "", hl = "TSParameter" },
		Variable = { icon = "", hl = "TSConstant" },
	},
})

local nnoremap = require("rav64.keymaps").nnoremap
nnoremap("Å", function()
	so.toggle_outline()
end)
