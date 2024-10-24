local p = {
	bg0 = "#2C2A2E",
	bg1 = "#29272B",
	bg2 = "#1F1D20",

	surface0 = "#3D3A40",
	surface1 = "#47444B",
	surface2 = "#524E56",

	overlay0 = "#ffffff",
	overlay1 = "#f2f4f8",
	overlay2 = "#dde1e6",

	text = "#FCFCFA",

	purple = "#D499FF",
	pink = "#F5C2E7",

	teal = "#94e2d5",
	flamingo = "#F2CDCD",
	maroon = "#ee5396",
	lavender = "#43D5EE",
	sapphire = "#74c7ec", -- REMOVE
	sky = "#89dceb",
	rosewater = "#ff99ff",

	orange = "#FC9867",
	red = "#FF6188",
	yellow = "#ffd966",
	green = "#A8DC76",
	blue = "#82A6ED",

	-- dirt = "#433021",
}

local hl = function(group, color)
	vim.api.nvim_set_hl(0, group, color)
end

-- EDITOR
hl("Normal", { fg = p.text, bg = p.bg0 })
hl("NormalFloat", { fg = p.text, bg = p.bg1 })
hl("Pmenu", { fg = p.overlay2, bg = p.bg1 })
hl("Visual", { bg = p.surface2 })

hl("Search", { bg = p.sapphire, fg = p.bg0 })
hl("IncSearch", { bg = p.sapphire, fg = p.bg0 }) -- Highlight on yank
hl("CurSearch", { bg = p.red, fg = p.text })

hl("CursorLine", { bg = p.surface1 })
hl("MacroCursorLine", { bg = "#603717" })
hl("LineNr", { fg = p.surface2 })
hl("CursorLineNr", { fg = p.flamingo })

hl("LazyNormal", { bg = p.bg1 })
hl("CmpGhostText", { italic = true })
hl("WinSeparator", { fg = p.bg1, bg = p.bg1 })

-- TELESCOPE
hl("TelescopePromptNormal", { bg = p.surface0 })
hl("TelescopePromptBorder", { bg = p.surface0 })
hl("TelescopePromptTitle", { bg = p.surface0 })
hl("TelescopeNormal", { bg = p.bg1 })
hl("TelescopeBorder", { bg = p.bg1 })
hl("TelescopePreviewNormal", { bg = p.bg2 })
hl("TelescopePreviewBorder", { bg = p.bg2 })
hl("TelescopeMatching", { fg = p.blue, italic = true })

-- SYNTAX
hl("Boolean", { fg = p.maroon })
hl("Number", { fg = p.orange })
hl("Character", { fg = p.teal })
hl("Comment", { fg = p.overlay0, italic = true })
hl("Conditional", { fg = p.purple })
hl("Constant", { fg = p.orange })
hl("Exception", { fg = p.purple })
hl("Float", { link = "Number" })
hl("Function", { fg = p.blue })
hl("Identifier", { fg = p.flamingo })
hl("Keyword", { fg = p.purple })
hl("Label", { fg = p.sapphire })
hl("Operator", { fg = p.sky })
hl("Repeat", { fg = p.purple })
hl("SpecialComment", { link = "Special" })
hl("Statement", { fg = p.purple })
hl("String", { fg = p.green })
hl("Type", { fg = p.yellow })
hl("Typedef", { link = "Type" })

hl("Define", { link = "PreProc" })
hl("Include", { fg = p.purple })
hl("Macro", { fg = p.purple })
hl("PreCondit", { link = "PreProc" })
hl("PreProc", { fg = p.pink })

hl("Debug", { link = "Special" })
hl("Delimiter", { fg = p.overlay2 })
hl("Special", { fg = p.flamingo })
hl("SpecialChar", { link = "Special" })
hl("StorageClass", { fg = p.yellow })
hl("Structure", { fg = p.yellow })
hl("Tag", { fg = p.lavender, bold = true })

hl("Struct", { fg = p.yellow })
hl("Interface", { fg = p.flamingo })
hl("Enum", { fg = p.yellow })
hl("EnumMember", { fg = p.orange })
hl("Module", { fg = p.lavender })
hl("Class", { fg = p.yellow })
hl("Variable", { fg = p.text })
hl("Field", { fg = p.lavender })

-- CMP
hl("CmpItemKindClass", { fg = p.bg0, bg = p.yellow })
hl("CmpItemKindColor", { fg = p.bg0, bg = p.red })
hl("CmpItemKindConstant", { fg = p.bg0, bg = p.orange })
hl("CmpItemKindConstructor", { fg = p.bg0, bg = p.blue })
hl("CmpItemKindEnum", { fg = p.bg0, bg = p.yellow })
hl("CmpItemKindEnumMember", { fg = p.bg0, bg = p.orange })
hl("CmpItemKindEvent", { fg = p.bg0, bg = p.purple })
hl("CmpItemKindField", { fg = p.bg0, bg = p.lavender })
hl("CmpItemKindFile", { fg = p.bg0, bg = p.blue })
hl("CmpItemKindFolder", { fg = p.bg0, bg = p.blue })
hl("CmpItemKindFunction", { fg = p.bg0, bg = p.blue })
hl("CmpItemKindInterface", { fg = p.bg0, bg = p.flamingo })
hl("CmpItemKindKeyword", { fg = p.bg0, bg = p.purple })
hl("CmpItemKindMethod", { fg = p.bg0, bg = p.blue })
hl("CmpItemKindModule", { fg = p.bg0, bg = p.lavender })
hl("CmpItemKindOperator", { fg = p.bg0, bg = p.sky })
hl("CmpItemKindProperty", { fg = p.bg0, bg = p.lavender })
hl("CmpItemKindReference", { fg = p.bg0, bg = p.red })
hl("CmpItemKindSnippet", { fg = p.bg0, bg = p.purple })
hl("CmpItemKindStruct", { fg = p.bg0, bg = p.yellow })
hl("CmpItemKindText", { fg = p.bg0, bg = p.green })
hl("CmpItemKindTypeParameter", { fg = p.bg0, bg = p.yellow })
hl("CmpItemKindUnit", { fg = p.bg0, bg = p.green })
hl("CmpItemKindValue", { fg = p.bg0, bg = p.orange })
hl("CmpItemKindVariable", { fg = p.bg0, bg = p.green })
hl("CmpBackground", { bg = p.bg2 })

-- TREESITTER
hl("@variable", { fg = p.text })
hl("@variable.builtin", { fg = p.red })
hl("@variable.parameter", { fg = p.maroon })
hl("@variable.member", { fg = p.lavender })

hl("@constant", { link = "Constant" })
hl("@constant.builtin", { fg = p.orange })
hl("@constant.macro", { link = "Macro" })

hl("@module", { fg = p.lavender })
hl("@label", { link = "Label" })

hl("@string", { link = "String" })
hl("@string.documentation", { fg = p.teal })
hl("@string.regexp", { fg = p.orange })
hl("@string.escape", { fg = p.pink })
hl("@string.special", { link = "Special" })
hl("@string.special.path", { link = "Special" })
hl("@string.special.symbol", { fg = p.flamingo })
hl("@string.special.url", { fg = p.rosewater })

hl("@character", { link = "Character" })
hl("@character.special", { link = "SpecialChar" })

hl("@boolean", { link = "Boolean" })
hl("@number", { link = "Number" })
hl("@number.float", { link = "Float" })

hl("@type", { link = "Type" })
hl("@type.builtin", { fg = p.yellow })
hl("@type.definition", { link = "Type" })

hl("@attribute", { link = "Constant" })
hl("@property", { fg = p.lavender })

hl("@function", { link = "Function" })
hl("@function.builtin", { fg = p.orange })
hl("@function.call", { link = "Function" })
hl("@function.macro", { fg = p.teal })

hl("@function.method", { link = "Function" })
hl("@function.method.call", { link = "Function" })

hl("@constructor", { fg = p.sapphire })
hl("@operator", { link = "Operator" })

hl("@keyword", { link = "Keyword" })
hl("@keyword.modifier", { link = "Keyword" })
hl("@keyword.type", { link = "Keyword" })
hl("@keyword.coroutine", { link = "Keyword" })
hl("@keyword.function", { fg = p.purple })
hl("@keyword.operator", { link = "Operator" })
hl("@keyword.import", { link = "Include" })
hl("@keyword.repeat", { link = "Repeat" })
hl("@keyword.return", { fg = p.purple })
hl("@keyword.debug", { link = "Exception" })
hl("@keyword.exception", { link = "Exception" })

hl("@keyword.conditional", { link = "Conditional" })
hl("@keyword.conditional.ternary", { link = "Operator" })

hl("@keyword.directive", { link = "PreProc" })
hl("@keyword.directive.define", { link = "Define" })

hl("@keyword.export", { fg = p.sky })

hl("@punctuation.delimiter", { link = "Delimiter" })
hl("@punctuation.bracket", { fg = p.overlay2 })
hl("@punctuation.special", { link = "Special" })

hl("@comment", { link = "Comment" })
hl("@comment.documentation", { link = "Comment" })

hl("@comment.error", { fg = p.bg0, bg = p.red })
hl("@comment.warning", { fg = p.bg0, bg = p.yellow })
hl("@comment.hint", { fg = p.bg0, bg = p.blue })
hl("@comment.todo", { fg = p.bg0, bg = p.flamingo })
hl("@comment.note", { fg = p.bg0, bg = p.rosewater })

hl("@markup", { fg = p.text })
hl("@markup.strong", { fg = p.maroon, bold = true })
hl("@markup.italic", { fg = p.maroon, italic = true })
hl("@markup.strikethrough", { fg = p.text, strikethrough = true })
hl("@markup.underline", { underline = true })

hl("@markup.heading", { fg = p.blue, bold = true })

hl("@markup.math", { fg = p.blue })
hl("@markup.quote", { fg = p.maroon, bold = true })
hl("@markup.environment", { fg = p.pink })
hl("@markup.environment.name", { fg = p.blue })

hl("@markup.link", { link = "Tag" })
hl("@markup.link.label", { link = "Label" })
hl("@markup.link.url", { fg = p.rosewater, italic = true, underline = true })

hl("@markup.raw", { fg = p.teal })

hl("@markup.list", { link = "Special" })
hl("@markup.list.checked", { fg = p.green })
hl("@markup.list.unchecked", { fg = p.overlay1 })

hl("@diff.plus", { fg = p.green })
hl("@diff.minus", { fg = p.red })
hl("@diff.delta", { fg = p.yellow })

hl("@tag", { fg = p.purple })
hl("@tag.attribute", { fg = p.teal, italic = true })
hl("@tag.delimiter", { fg = p.sky })

hl("@error", { fg = p.red })

hl("@function.builtin.bash", { fg = p.red, italic = true })

hl("@markup.heading.1.markdown", { link = "rainbow1" })
hl("@markup.heading.2.markdown", { link = "rainbow2" })
hl("@markup.heading.3.markdown", { link = "rainbow3" })
hl("@markup.heading.4.markdown", { link = "rainbow4" })
hl("@markup.heading.5.markdown", { link = "rainbow5" })
hl("@markup.heading.6.markdown", { link = "rainbow6" })

hl("@constant.java", { fg = p.teal })

hl("@property.css", { fg = p.lavender })
hl("@property.id.css", { fg = p.blue })
hl("@property.class.css", { fg = p.yellow })
hl("@type.css", { fg = p.lavender })
hl("@type.tag.css", { fg = p.purple })
hl("@string.plain.css", { fg = p.orange })
hl("@number.css", { fg = p.orange })

hl("@property.toml", { fg = p.blue })

hl("@label.json", { fg = p.blue })

hl("@constructor.lua", { fg = p.flamingo })

hl("@property.typescript", { fg = p.lavender })
hl("@constructor.typescript", { fg = p.lavender })

hl("@constructor.tsx", { fg = p.lavender })
hl("@tag.attribute.tsx", { fg = p.teal, italic = true })

hl("@variable.member.yaml", { fg = p.blue })

hl("@string.special.symbol.ruby", { fg = p.flamingo })

hl("@function.method.php", { link = "Function" })
hl("@function.method.call.php", { link = "Function" })

hl("@type.builtin.c", { fg = p.yellow })
hl("@property.cpp", { fg = p.text })
hl("@type.builtin.cpp", { fg = p.yellow })

hl("@comment.warning.gitcommit", { fg = p.yellow })

hl("@string.special.path.gitignore", { fg = p.text })

hl("@codeblock", { bg = p.surface0 })
hl("@comment", { italic = true, fg = p.text })

-- SEMANTIC TOKENS
hl("@lsp.type.boolean", { link = "@boolean" })
hl("@lsp.type.builtinType", { link = "@type.builtin" })
hl("@lsp.type.comment", { link = "@comment" })
hl("@lsp.type.enum", { link = "@type" })
hl("@lsp.type.enumMember", { link = "@constant" })
hl("@lsp.type.escapeSequence", { link = "@string.escape" })
hl("@lsp.type.formatSpecifier", { link = "@punctuation.special" })
hl("@lsp.type.interface", { link = "Interface" })
hl("@lsp.type.keyword", { link = "@keyword" })
hl("@lsp.type.namespace", { link = "@module" })
hl("@lsp.type.number", { link = "@number" })
hl("@lsp.type.operator", { link = "@operator" })
hl("@lsp.type.parameter", { link = "@parameter" })
hl("@lsp.type.property", { link = "@property" })
hl("@lsp.type.selfKeyword", { link = "@variable.builtin" })
hl("@lsp.type.typeAlias", { link = "@type.definition" })
hl("@lsp.type.unresolvedReference", { link = "@error" })
hl("@lsp.type.variable", {})
hl("@lsp.typemod.class.defaultLibrary", { link = "@type.builtin" })
hl("@lsp.typemod.enum.defaultLibrary", { link = "@type.builtin" })
hl("@lsp.typemod.enumMember.defaultLibrary", { link = "@constant.builtin" })
hl("@lsp.typemod.function.defaultLibrary", { link = "@function.builtin" })
hl("@lsp.typemod.keyword.async", { link = "@keyword.coroutine" })
hl("@lsp.typemod.macro.defaultLibrary", { link = "@function.builtin" })
hl("@lsp.typemod.method.defaultLibrary", { link = "@function.builtin" })
hl("@lsp.typemod.operator.injected", { link = "@operator" })
hl("@lsp.typemod.string.injected", { link = "@string" })
hl("@lsp.typemod.type.defaultLibrary", { link = "@type.builtin" })
hl("@lsp.typemod.variable.defaultLibrary", { link = "@variable.builtin" })
hl("@lsp.typemod.variable.injected", { link = "@variable" })

-- DIAGNOSTIC
hl("DiagnosticError", { bg = p.none, fg = p.red, italic = true })
hl("DiagnosticWarn", { bg = p.none, fg = p.yellow, italic = true })
hl("DiagnosticInfo", { bg = p.none, fg = p.sky, italic = true })
hl("DiagnosticHint", { bg = p.none, fg = p.teal, italic = true })
hl("DiagnosticOk", { bg = p.none, fg = p.green, italic = true })

-- RAINBOW
hl("RainbowDelimiterRed", { fg = p.red })
hl("RainbowDelimiterYellow", { fg = p.yellow })
hl("RainbowDelimiterBlue", { fg = p.blue })
hl("RainbowDelimiterOrange", { fg = p.orange })
hl("RainbowDelimiterGreen", { fg = p.green })
hl("RainbowDelimiterViolet", { fg = p.purple })
hl("RainbowDelimiterCyan", { fg = p.teal })

-- MINI
hl("MiniIconsAzure", { fg = p.sapphire })
hl("MiniIconsBlue", { fg = p.blue })
hl("MiniIconsCyan", { fg = p.teal })
hl("MiniIconsGreen", { fg = p.green })
hl("MiniIconsGrey", { fg = p.text })
hl("MiniIconsOrange", { fg = p.orange })
hl("MiniIconsPurple", { fg = p.purple })
hl("MiniIconsRed", { fg = p.red })
hl("MiniIconsYellow", { fg = p.yellow })

-- GITSIGNS
hl("GitSignsAdd", { fg = p.green })
hl("GitSignsChange", { fg = p.yellow })
hl("GitSignsDelete", { fg = p.red })
hl("GitSignsAddPreview", { link = "DiffAdd" })
hl("GitSignsDeletePreview", { link = "DiffDelete" })
hl("GitSignsCurrentLineBlame", { fg = p.surface1 })

-- STATUSLINE
hl("StatusLineGreen", { fg = p.green, bg = p.bg2 })
hl("StatusLineYellow", { fg = p.yellow, bg = p.bg2 })
hl("StatusLineRed", { fg = p.red, bg = p.bg2 })
hl("StatusLineBlue", { fg = p.blue, bg = p.bg2 })

hl("StatusLineModeNOR", { fg = p.bg1, bg = p.blue })
hl("StatusLineModePEN", { fg = p.bg1, bg = p.flamingo })
hl("StatusLineModeVIS", { fg = p.bg1, bg = p.purple })
hl("StatusLineModeINS", { fg = p.bg1, bg = p.green })
hl("StatusLineModeCOM", { fg = p.bg1, bg = p.flamingo })
hl("StatusLineModeUNK", { fg = p.bg1, bg = p.orange })
hl("StatusLine", { bg = p.bg2 })
