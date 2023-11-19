local M = {}

function M.stringify_table(tbl, indent)
	if not indent then
		indent = 0
	end
	local toprint = string.rep(" ", indent) .. "{\n"
	indent = indent + 2
	for k, v in pairs(tbl) do
		toprint = toprint .. string.rep(" ", indent)
		if type(k) == "number" then
			toprint = toprint .. "[" .. k .. "] = "
		elseif type(k) == "string" then
			toprint = toprint .. k .. "= "
		end
		if type(v) == "number" then
			toprint = toprint .. v .. ",\n"
		elseif type(v) == "string" then
			toprint = toprint .. '"' .. v .. '",\n'
		elseif type(v) == "table" then
			toprint = toprint .. M.stringify_table(v, indent + 2) .. ",\n"
		else
			toprint = toprint .. '"' .. tostring(v) .. '",\n'
		end
	end
	toprint = toprint .. string.rep(" ", indent - 2) .. "}"
	return toprint
end

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
