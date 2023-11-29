local M = {}

function M.update_lead()
	local lead_chr = string.gsub(vim.opt_local.listchars:get().leadmultispace, "%s+", "")
	local cache = {}

	local function update_cache(int)
		cache[int] = lead_chr .. string.rep(" ", int - 1)
		return cache[int]
	end

	return function()
		local lead = cache[vim.bo.shiftwidth] or update_cache(vim.bo.shiftwidth)
		vim.opt_local.listchars:append({ leadmultispace = lead })
	end
end

M.icons = {
	Array = "󰅪",
	Boolean = "◩",
	Class = "",
	Color = "",
	Constant = "󰏿",
	Constructor = "󱌢",
	Enum = "󰕘",
	EnumMember = "",
	Event = "",
	Field = "",
	File = "󰈙",
	Folder = "",
	Function = "󰊕",
	Interface = "",
	Keyword = "󰌋",
	Method = "",
	Module = "󰕳",
	Namespace = "󰌗",
	Null = "󰟢",
	Number = "󰎠",
	Operator = "",
	Object = "󰅩",
	Package = "",
	Property = "",
	Reference = "",
	Snippet = "",
	Struct = "",
	Text = "",
	TypeParameter = "",
	Unit = "",
	Value = "",
	Variable = "󰫧",
}

return M
