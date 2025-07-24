local p = {
	background0 = "#2C2A2E",
	background1 = "#2A2828",
	background2 = "#212020",

	surface0 = "#403D3B",
	surface1 = "#4A4745",
	surface2 = "#55514F",

	white = "#E0E2E3",

	gold = "#FFC764",
	orange = "#FF8C5C",
	pink = "#ff74b8",
	red = "#FF6A6A",
	emerald = "#4EDC88",
	green = "#A8E176",
	diamond = "#6bede4",
	blue = "#99BBFF",
	soft_pink = "#F4D2D5",
	purple = "#BE95FF",

	deep_purple = "#673AB7",

	static = "#FDAB67",
	lowlight = "#603717",
}

local hl = function(group, color)
	vim.api.nvim_set_hl(0, group, color)
end
local colorize = function(group, color)
	local opts = type(color) == "table" and color or { fg = color }
	hl(group, opts)
	return { group = group, color = color }
end
local link = function(color)
	return { link = color.group }
end

local disabled = function()
	return { fg = nil, bg = nil }
end

local class = colorize("Class", p.gold)
local enum = colorize("Enum", p.gold)
local type = colorize("Type", p.gold)
local struct = colorize("Struct", p.gold)
local typedef = colorize("Typedef", p.gold)

local boolean = colorize("Boolean", p.orange)
local constant = colorize("Constant", p.orange)
local enumMember = colorize("EnumMember", p.orange)
local float = colorize("Float", p.orange)
local macro = colorize("Macro", p.orange)
local number = colorize("Number", p.orange)

local character = colorize("Character", p.emerald)
local operator = colorize("Operator", p.emerald)

local str = colorize("String", p.green)

local conditional = colorize("Conditional", p.purple)
local event = colorize("Event", p.purple)
local keyword = colorize("Keyword", p.purple)
local rep = colorize("Repeat", p.purple)

local field = colorize("Field", p.diamond)
local label = colorize("Label", p.diamond)

local constructur = colorize("Constructor", p.blue)
local folder = colorize("Folder", p.blue)
local file = colorize("File", p.blue)
local func = colorize("Function", p.blue)

local exception = colorize("Exception", p.pink)
local parameter = colorize("Parameter", p.pink)

local interface = colorize("Interface", p.soft_pink)
local special = colorize("Special", p.soft_pink)

local comment = colorize("Comment", { fg = p.white, italic = true })
local variable = colorize("Variable", p.white)

local module = colorize("Module", p.static)
local static = colorize("Static", p.static)

local colors = {
	-- EDITOR
	["Normal"] = { fg = p.white, bg = p.background0 },
	["NormalFloat"] = { fg = p.white, bg = p.background1 },
	["Visual"] = { bg = p.surface2 },

	["Search"] = { bg = p.soft_pink, fg = p.background0 },
	["IncSearch"] = { bg = p.diamond, fg = p.background0 }, -- Highlight on yank
	["CurSearch"] = { bg = p.red, fg = p.white },

	["CursorLine"] = { bg = p.surface1 },
	["MacroCursorLine"] = { bg = p.lowlight },
	["LineNr"] = { fg = p.surface2 },
	["CursorLineNr"] = { fg = p.soft_pink },

	["CmpGhostText"] = { italic = true },
	["WinSeparator"] = { fg = p.background1, bg = p.background1 },

	["Debug"] = link(special),
	["Delimiter"] = { fg = p.white },
	["Include"] = { fg = p.purple },
	["PreProc"] = { fg = p.pink },
	["PreCondit"] = { link = "PreProc" },
	["Define"] = { link = "PreProc" },
	["SpecialChar"] = link(special),
	["SpecialComment"] = link(special),
	["StorageClass"] = link(class),
	["Structure"] = link(struct),
	["Tag"] = { fg = p.diamond, bold = true },
	["PmenuSel"] = { link = "CursorLine" },

	["FlashLabel"] = { fg = p.white, bold = true },
	["FlashCurrent"] = { fg = p.static },
	["FlashPrompt"] = { link = "NormalFloat" },

	--- FZF-LUA ---
	["FzfLuaNormal"] = { bg = p.background1 },
	["FzfLuaPreviewNormal"] = { bg = p.background2 },
	["FzfLuaFzfQuery"] = { bg = p.red },
	["FzfLuaFzfPrompt"] = { bg = p.red },
	["FzfLuaBackdrop"] = { link = "Normal" },

	["FzfLuaBorder"] = { fg = p.background1, bg = p.background1 },
	["FzfLuaPreviewBorder"] = { fg = p.background2, bg = p.background2 },

	["FzfLuaHeaderBind"] = { fg = p.gold },
	["FzfLuaBufNr"] = { fg = p.gold },
	["FzfLuaTabMarker"] = { fg = p.gold },

	-- 2) Replacements for "*Brown1"
	["FzfLuaHeaderText"] = { fg = p.orange },
	["FzfLuaBufFlagCur"] = { fg = p.orange },

	-- 3) Replacements for "*CadetBlue1"
	["FzfLuaPathColNr"] = { fg = p.blue },
	["FzfLuaBufFlagAlt"] = { fg = p.blue },

	-- 4) Replacement for "*LightGreen"
	["FzfLuaPathLineNr"] = { fg = p.emerald },

	-- 5) Replacement for "*LightSkyBlue1"
	["FzfLuaTabTitle"] = { fg = p.blue },

	-- 6) Replacements for "*PaleVioletRed1"
	["FzfLuaLivePrompt"] = { fg = p.pink },
	["FzfLuaLiveSym"] = { fg = p.pink },
	--- /FZF-LUA ---

	-- CMP
	["BlinkCmpKindClass"] = link(class),
	["BlinkCmpKindConstant"] = link(constant),
	["BlinkCmpKindConstructor"] = link(constructur),
	["BlinkCmpKindEnum"] = link(enum),
	["BlinkCmpKindEnumMember"] = link(enumMember),
	["BlinkCmpKindEvent"] = link(event),
	["BlinkCmpKindField"] = link(field),
	["BlinkCmpKindFile"] = link(file),
	["BlinkCmpKindFolder"] = link(folder),
	["BlinkCmpKindFunction"] = link(func),
	["BlinkCmpKindInterface"] = link(interface),
	["BlinkCmpKindKeyword"] = link(keyword),
	["BlinkCmpKindMethod"] = link(func),
	["BlinkCmpKindModule"] = link(module),
	["BlinkCmpKindOperator"] = link(operator),
	["BlinkCmpKindProperty"] = link(field),
	["BlinkCmpKindStruct"] = link(struct),
	["BlinkCmpKindText"] = link(str),
	["BlinkCmpKindTypeParameter"] = link(type),
	["BlinkCmpKindVariable"] = link(variable),
	["BlinkCmpKindReference"] = { fg = p.red },
	["BlinkCmpKindSnippet"] = { fg = p.purple },
	["BlinkCmpKindUnit"] = { fg = p.green },
	["BlinkCmpKindValue"] = { fg = p.orange },
	["BlinkCmpKindColor"] = { fg = p.red },
	["BlinkCmpMenu"] = { bg = p.background1 },

	-- TREESITTER
	["@variable"] = link(variable), -- Any variable name that does not have another highlight.
	["@variable.parameter"] = link(parameter), -- For parameters of a function.
	["@variable.member"] = link(field), -- For fields.

	["@constant"] = link(constant),
	["@constant.macro"] = link(constant),

	["@module"] = link(module),
	["@label"] = link(label),

	["@string"] = link(str),

	["@character"] = link(character),
	["@character.special"] = { link = "SpecialChar" },

	["@boolean"] = link(boolean),
	["@number"] = link(number),
	["@number.float"] = link(float),

	["@type"] = link(type),
	["@type.builtin"] = link(type),
	["@type.definition"] = link(type),

	["@attribute"] = link(constant),
	["@property"] = link(field),

	["@function"] = link(func),
	-- ["@function.builtin"] = { bold = true },
	-- ["@lsp.mod.defaultLibrary"] = { bold = true },
	-- ["@lsp.type.builtinAttribute"] = { bold = true },
	["@function.call"] = link(func),
	["@function.macro"] = link(macro),

	["@function.method"] = link(func),
	["@function.method.call"] = link(func),

	["@constructor"] = link(constructur),
	["@operator"] = link(operator),

	["@keyword"] = link(keyword),
	["@keyword.modifier"] = link(keyword),
	["@keyword.type"] = link(keyword),
	["@keyword.coroutine"] = link(keyword),
	["@keyword.function"] = link(keyword),
	["@keyword.operator"] = link(operator),
	["@keyword.import"] = { link = "Include" },
	["@keyword.repeat"] = link(rep),
	["@keyword.return"] = link(keyword),
	["@keyword.debug"] = link(exception),
	["@keyword.exception"] = link(exception),

	["@keyword.conditional"] = link(conditional),
	["@keyword.conditional.ternary"] = link(operator),

	["@keyword.directive"] = { link = "PreProc" },
	["@keyword.directive.define"] = { link = "Define" },

	["@keyword.export"] = { fg = p.emerald },

	["@punctuation.delimiter"] = { link = "Delimiter" },
	["@punctuation.bracket"] = { fg = p.purple },
	["@punctuation.special"] = link(special),

	["@comment"] = link(comment),
	["@comment.documentation"] = link(comment),
	["@comment.error"] = { fg = p.background0, bg = p.red },
	["@comment.warning"] = { fg = p.background0, bg = p.gold },
	["@comment.hint"] = { fg = p.background0, bg = p.emerald },
	["@comment.todo"] = { fg = p.background0, bg = p.soft_pink },
	["@comment.note"] = { fg = p.background0, bg = p.soft_pink },

	["@markup"] = { fg = p.white },
	["@markup.strong"] = { fg = p.pink, bold = true },
	["@markup.italic"] = { fg = p.pink, italic = true },
	["@markup.strikethrough"] = { fg = p.white, strikethrough = true },
	["@markup.underline"] = { underline = true },
	["@markup.heading"] = { fg = p.blue, bold = true },
	["@markup.math"] = { fg = p.blue },
	["@markup.quote"] = { fg = p.pink, bold = true },
	["@markup.environment"] = { fg = p.pink },
	["@markup.environment.name"] = { fg = p.blue },
	["@markup.link"] = { link = "Tag" },
	["@markup.link.label"] = link(label),
	["@markup.link.url"] = { fg = p.soft_pink, italic = true, underline = true },
	["@markup.raw"] = { fg = p.emerald },
	["@markup.list"] = link(special),
	["@markup.list.checked"] = { fg = p.green },
	["@markup.list.unchecked"] = { fg = p.white },

	["@diff.plus"] = { fg = p.green },
	["@diff.minus"] = { fg = p.red },
	["@diff.delta"] = { fg = p.gold },

	["@tag"] = { fg = p.purple },
	["@tag.attribute"] = { fg = p.emerald, italic = true },
	["@tag.delimiter"] = { fg = p.emerald },

	["@error"] = { fg = p.red },

	["@codeblock"] = { bg = p.surface0 },

	-- SEMANTIC TOKENS
	["@lsp.type.boolean"] = link(boolean),
	["@lsp.type.comment"] = link(comment),
	["@lsp.type.enum"] = link(enum),
	["@lsp.type.enumMember"] = link(enumMember),
	["@lsp.type.static"] = link(static),
	["@lsp.type.const"] = link(constant),
	["@lsp.type.escapeSequence"] = { link = "@string.escape" },
	["@lsp.type.formatSpecifier"] = { link = "@punctuation.special" },
	["@lsp.type.interface"] = link(interface),
	["@lsp.type.keyword"] = link(keyword),
	["@lsp.type.namespace"] = link(module),
	["@lsp.type.number"] = link(number),
	["@lsp.type.operator"] = link(operator),
	["@lsp.type.parameter"] = link(parameter),
	["@lsp.type.property"] = link(field),
	["@lsp.type.selfKeyword"] = { fg = p.pink },
	["@lsp.type.typeAlias"] = link(typedef),
	["@lsp.type.unresolvedReference"] = { link = "@error" },
	["@lsp.type.variable"] = link(variable),
	["@lsp.typemod.generic"] = link(str),
	["@lsp.typemod.derive"] = link(interface),
	["@lsp.typemod.attributeBracket"] = { fg = p.pink },
	["@lsp.mod.attribute"] = link(constant),
	-- ["@lsp.mod.controlFlow"] = { fg = p.red },
	["@lsp.mod.global"] = link(static),
	["@lsp.mod.crateRoot"] = link(module),

	["@lsp.typemod.operator.injected"] = link(operator),
	["@lsp.typemod.string.injected"] = link(str),
	["@lsp.typemod.variable.injected"] = link(variable),

	["@lsp.typemod.keyword.async"] = { link = "@keyword.coroutine" },
	["@lsp.type.string"] = disabled(),
	["@lsp.type.macro"] = disabled(),

	["RustSigil"] = { fg = p.emerald },

	-- DIAGNOSTIC
	["DiagnosticError"] = { fg = p.red, italic = true },
	["DiagnosticWarn"] = { fg = p.gold, italic = true },
	["DiagnosticInfo"] = { fg = p.diamond, italic = true },
	["DiagnosticHint"] = { fg = p.emerald, italic = true },
	["DiagnosticOk"] = { fg = p.green, italic = true },

	-- RAINBOW
	["RainbowDelimiterRed"] = { fg = p.pink },
	["RainbowDelimiterYellow"] = { fg = p.gold },
	["RainbowDelimiterBlue"] = { fg = p.blue },
	["RainbowDelimiterOrange"] = { fg = p.orange },
	["RainbowDelimiterGreen"] = { fg = p.green },
	["RainbowDelimiterViolet"] = { fg = p.purple },
	["RainbowDelimiterCyan"] = { fg = p.emerald },

	["@markup.heading.1"] = { fg = p.red },
	["@markup.heading.2"] = { fg = p.gold },
	["@markup.heading.3"] = { fg = p.blue },
	["@markup.heading.4"] = { fg = p.orange },
	["@markup.heading.5"] = { fg = p.green },
	["@markup.heading.6"] = { fg = p.purple },

	-- MINI
	["MiniIconsAzure"] = { fg = p.diamond },
	["MiniIconsBlue"] = { fg = p.blue },
	["MiniIconsCyan"] = { fg = p.emerald },
	["MiniIconsGreen"] = { fg = p.green },
	["MiniIconsGrey"] = { fg = p.white },
	["MiniIconsOrange"] = { fg = p.orange },
	["MiniIconsPurple"] = { fg = p.purple },
	["MiniIconsRed"] = { fg = p.red },
	["MiniIconsYellow"] = { fg = p.gold },

	["DiffAdd"] = { fg = nil, bg = "#41493a" },
	["DiffDelete"] = { fg = nil, bg = "#4f3538" },

	-- GITSIGNS
	["GitSignsAdd"] = { fg = p.green },
	["GitSignsChange"] = { fg = p.gold },
	["GitSignsDelete"] = { fg = p.red },
	["GitSignsAddPreview"] = { link = "DiffAdd" },
	["GitSignsDeletePreview"] = { link = "DiffDelete" },
	["GitSignsCurrentLineBlame"] = { fg = p.surface1 },
	["GitSignsDeleteInline"] = { bg = p.red, fg = p.background0 },
	["GitSignsChangeInline"] = { bg = p.green, fg = p.background0 },

	-- STATUSLINE
	["StatusLineGreen"] = { fg = p.emerald, bg = p.background2 },
	["StatusLineYellow"] = { fg = p.gold, bg = p.background2 },
	["StatusLineRed"] = { fg = p.red, bg = p.background2 },
	["StatusLineBlue"] = { fg = p.blue, bg = p.background2 },

	["StatusLineModeNOR"] = { fg = p.background1, bg = p.blue },
	["StatusLineModePEN"] = { fg = p.background1, bg = p.soft_pink },
	["StatusLineModeVIS"] = { fg = p.background1, bg = p.purple },
	["StatusLineModeINS"] = { fg = p.background1, bg = p.green },
	["StatusLineModeCOM"] = { fg = p.background1, bg = p.soft_pink },
	["StatusLineModeUNK"] = { fg = p.background1, bg = p.orange },
	["StatusLine"] = { bg = p.background2 },
}

for group, opts in pairs(colors) do
	hl(group, opts)
end
