local p = {
	background = "#2C2A2E",
	float_background = "#29272B",
	results_background = "#1F1D20",

	surface0 = "#3D3A40",
	surface1 = "#47444B",
	surface2 = "#524E56",

	overlay = "#DDE1E6",

	purple = "#D499FF",
	teal = "#94E2D5",
	beige = "#F2CDCD",
	maroon = "#EE5396",
	light_blue = "#43D5EE",
	sky = "#89DCEB",
	orange = "#FC9867",
	red = "#FF6188",
	yellow = "#FFD966",
	green = "#A8DC76",
	blue = "#82A6ED",

	static = "#FDAB67",
	macro = "#603717",

	-- black = "#131418",
	-- blue = "#333799",
	-- brown = "#6f4527",
	-- cyan = "#15868d",
	-- gray = "#3d4245",
	-- green = "#51691a",
	-- light_blue = "#38abd4",
	-- light_gray = "#8a8a83",
	-- lime = "#6cb418",
	magenta = "#B841AE",
	-- orange = "#eb7111",
	pink = "#EA89A8",
	-- purple = "#7527a6",
	-- red = "#9c2521",
	white = "#E4E6E7",
	-- yellow = "#f3c125",
	--
	-- dirt = "#433021",
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
local inversed = function(color)
	return { fg = p.background, bg = color }
end

-- EDITOR
hl("Normal", { fg = p.white, bg = p.background })
hl("NormalFloat", { fg = p.white, bg = p.float_background })
hl("Visual", { bg = p.surface2 })

hl("Search", { bg = p.light_blue, fg = p.background })
hl("IncSearch", { bg = p.light_blue, fg = p.background }) -- Highlight on yank
hl("CurSearch", { bg = p.red, fg = p.white })

hl("CursorLine", { bg = p.surface1 })
hl("MacroCursorLine", { bg = p.macro })
hl("LineNr", { fg = p.surface2 })
hl("CursorLineNr", { fg = p.beige })

hl("LazyNormal", { bg = p.float_background })
hl("CmpGhostText", { italic = true })
hl("WinSeparator", { fg = p.float_background, bg = p.float_background })

-- TELESCOPE
hl("TelescopePromptNormal", { bg = p.surface0 })
hl("TelescopePromptBorder", { bg = p.surface0 })
hl("TelescopePromptTitle", { bg = p.surface0 })
hl("TelescopeNormal", { bg = p.float_background })
hl("TelescopeBorder", { bg = p.float_background })
hl("TelescopePreviewNormal", { bg = p.results_background })
hl("TelescopePreviewBorder", { bg = p.results_background })
hl("TelescopeMatching", { fg = p.blue, italic = true })

local boolean = colorize("Boolean", p.maroon)
local character = colorize("Character", p.teal)
local comment = colorize("Comment", { fg = p.white, italic = true })
local conditional = colorize("Conditional", p.purple)
local exception = colorize("Exception", p.magenta)
local func = colorize("Function", p.blue)
local keyword = colorize("Keyword", p.purple)
local label = colorize("Label", p.light_blue)
local operator = colorize("Operator", p.sky)
local rep = colorize("Repeat", p.purple) --repeat
local str = colorize("String", p.green)
local constant = colorize("Constant", p.orange)
local static = colorize("Static", p.static)
local number = colorize("Number", p.orange)
local float = colorize("Float", p.orange)
local type = colorize("Type", p.yellow)
local typedef = colorize("Typedef", p.yellow)
local class = colorize("Class", p.yellow)
local struct = colorize("Struct", p.yellow)
local interface = colorize("Interface", p.beige)
local constructur = colorize("Constructor", p.blue)
local enum = colorize("Enum", p.yellow)
local enumMember = colorize("EnumMember", p.orange)
local field = colorize("Field", p.light_blue)
local module = colorize("Module", p.light_blue)
local event = colorize("Event", p.purple)
local file = colorize("File", p.blue)
local folder = colorize("Foleder", p.blue)
local special = colorize("Special", p.beige)
local variable = colorize("Variable", p.white)
local macro = colorize("Macro", p.orange)
local parameter = colorize("Parameter", p.maroon)

local colors = {
	["Debug"] = link(special),
	["Define"] = { link = "PreProc" },
	["Delimiter"] = { fg = p.white },
	["Include"] = { fg = p.purple },
	["PreCondit"] = { link = "PreProc" },
	["PreProc"] = { fg = p.pink },
	["SpecialChar"] = link(special),
	["SpecialComment"] = link(special),
	["StorageClass"] = link(class),
	["Structure"] = link(struct),
	["Tag"] = { fg = p.light_blue, bold = true },
	["PmenuSel"] = { link = "CursorLine" },

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
	["BlinkCmpMenu"] = { bg = p.float_background },

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
	["@function.builtin"] = { bold = true },
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

	["@keyword.export"] = { fg = p.sky },

	["@punctuation.delimiter"] = { link = "Delimiter" },
	["@punctuation.bracket"] = { fg = p.white },
	["@punctuation.special"] = link(special),

	["@comment"] = link(comment),
	["@comment.documentation"] = link(comment),
	["@comment.error"] = { fg = p.background, bg = p.red },
	["@comment.warning"] = { fg = p.background, bg = p.yellow },
	["@comment.hint"] = { fg = p.background, bg = p.blue },
	["@comment.todo"] = { fg = p.background, bg = p.beige },
	["@comment.note"] = { fg = p.background, bg = p.beige },

	["@markup"] = { fg = p.white },
	["@markup.strong"] = { fg = p.maroon, bold = true },
	["@markup.italic"] = { fg = p.maroon, italic = true },
	["@markup.strikethrough"] = { fg = p.white, strikethrough = true },
	["@markup.underline"] = { underline = true },
	["@markup.heading"] = { fg = p.blue, bold = true },
	["@markup.math"] = { fg = p.blue },
	["@markup.quote"] = { fg = p.maroon, bold = true },
	["@markup.environment"] = { fg = p.pink },
	["@markup.environment.name"] = { fg = p.blue },
	["@markup.link"] = { link = "Tag" },
	["@markup.link.label"] = link(label),
	["@markup.link.url"] = { fg = p.beige, italic = true, underline = true },
	["@markup.raw"] = { fg = p.teal },
	["@markup.list"] = link(special),
	["@markup.list.checked"] = { fg = p.green },
	["@markup.list.unchecked"] = { fg = p.white },

	["@diff.plus"] = { fg = p.green },
	["@diff.minus"] = { fg = p.red },
	["@diff.delta"] = { fg = p.yellow },

	["@tag"] = { fg = p.purple },
	["@tag.attribute"] = { fg = p.teal, italic = true },
	["@tag.delimiter"] = { fg = p.sky },

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

	["@lsp.mod.defaultLibrary"] = { bold = true },
	["@lsp.type.builtinAttribute"] = { bold = true },

	["@lsp.typemod.operator.injected"] = link(operator),
	["@lsp.typemod.string.injected"] = link(str),
	["@lsp.typemod.variable.injected"] = link(variable),

	["@lsp.typemod.keyword.async"] = { link = "@keyword.coroutine" },

	["RustSigil"] = { fg = p.sky },

	-- DIAGNOSTIC
	["DiagnosticError"] = { bg = p.none, fg = p.red, italic = true },
	["DiagnosticWarn"] = { bg = p.none, fg = p.yellow, italic = true },
	["DiagnosticInfo"] = { bg = p.none, fg = p.sky, italic = true },
	["DiagnosticHint"] = { bg = p.none, fg = p.teal, italic = true },
	["DiagnosticOk"] = { bg = p.none, fg = p.green, italic = true },

	-- RAINBOW
	["RainbowDelimiterRed"] = { fg = p.red },
	["RainbowDelimiterYellow"] = { fg = p.yellow },
	["RainbowDelimiterBlue"] = { fg = p.blue },
	["RainbowDelimiterOrange"] = { fg = p.orange },
	["RainbowDelimiterGreen"] = { fg = p.green },
	["RainbowDelimiterViolet"] = { fg = p.purple },
	["RainbowDelimiterCyan"] = { fg = p.teal },

	["@markup.heading.1"] = { fg = p.red },
	["@markup.heading.2"] = { fg = p.yellow },
	["@markup.heading.3"] = { fg = p.blue },
	["@markup.heading.4"] = { fg = p.orange },
	["@markup.heading.5"] = { fg = p.green },
	["@markup.heading.6"] = { fg = p.purple },

	-- MINI
	["MiniIconsAzure"] = { fg = p.light_blue },
	["MiniIconsBlue"] = { fg = p.blue },
	["MiniIconsCyan"] = { fg = p.teal },
	["MiniIconsGreen"] = { fg = p.green },
	["MiniIconsGrey"] = { fg = p.white },
	["MiniIconsOrange"] = { fg = p.orange },
	["MiniIconsPurple"] = { fg = p.purple },
	["MiniIconsRed"] = { fg = p.red },
	["MiniIconsYellow"] = { fg = p.yellow },

	-- GITSIGNS
	["GitSignsAdd"] = { fg = p.green },
	["GitSignsChange"] = { fg = p.yellow },
	["GitSignsDelete"] = { fg = p.red },
	["GitSignsAddPreview"] = { link = "DiffAdd" },
	["GitSignsDeletePreview"] = { link = "DiffDelete" },
	["GitSignsCurrentLineBlame"] = { fg = p.surface1 },

	-- STATUSLINE
	["StatusLineGreen"] = { fg = p.green, bg = p.results_background },
	["StatusLineYellow"] = { fg = p.yellow, bg = p.results_background },
	["StatusLineRed"] = { fg = p.red, bg = p.results_background },
	["StatusLineBlue"] = { fg = p.blue, bg = p.results_background },

	["StatusLineModeNOR"] = { fg = p.float_background, bg = p.blue },
	["StatusLineModePEN"] = { fg = p.float_background, bg = p.beige },
	["StatusLineModeVIS"] = { fg = p.float_background, bg = p.purple },
	["StatusLineModeINS"] = { fg = p.float_background, bg = p.green },
	["StatusLineModeCOM"] = { fg = p.float_background, bg = p.beige },
	["StatusLineModeUNK"] = { fg = p.float_background, bg = p.orange },
	["StatusLine"] = { bg = p.results_background },

	--TSCONTEXT
	["TreesitterContextLineNumber"] = { bg = p.float_background, fg = p.surface2 },
}

for group, opts in pairs(colors) do
	hl(group, opts)
end
