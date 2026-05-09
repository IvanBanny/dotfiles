-- Aperture colorscheme
-- Based on https://github.com/empr0r/neovim-ide-config/blob/main/lua/colors/themes/aperture.lua

vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then
    vim.cmd("syntax reset")
end
vim.o.background = "dark"
vim.g.colors_name = "aperture"

local colors = {
    bg = "#140B05",
    fg = "#FC9505",
    selection_bg = "#141415",
    selection_fg = "#FC9505",
    inactive_fg = "#8C8C8C",
    positive = "#6FDB88",
    negative = "#FF6F6F",
    neutral = "#EEBB44",
    link = "#6FABFF",
    bar_bg = "#2A1B0A",
    bar_fg = "#FC9505",
}

local hl = function(group, opts) vim.api.nvim_set_hl(0, group, opts) end

-- General UI
hl("Normal",        { bg = colors.bg, fg = colors.fg })
hl("NormalFloat",   { bg = colors.bg, fg = colors.fg })
hl("FloatBorder",   { bg = colors.bg, fg = colors.inactive_fg })
hl("Visual",        { bg = colors.selection_bg, fg = colors.selection_fg })
hl("VisualNOS",     { bg = colors.selection_bg, fg = colors.selection_fg })
hl("Search",        { bg = colors.neutral, fg = colors.bg })
hl("IncSearch",     { bg = colors.fg, fg = colors.bg })
hl("CurSearch",     { bg = colors.fg, fg = colors.bg })
hl("MatchParen",    { bg = colors.bar_bg, fg = colors.neutral, bold = true })
hl("Cursor",        { bg = colors.fg, fg = colors.bg })
hl("CursorLine",    { bg = colors.bar_bg })
hl("CursorColumn",  { bg = colors.bar_bg })
hl("ColorColumn",   { bg = colors.bar_bg })
hl("LineNr",        { fg = colors.inactive_fg, bg = colors.bg })
hl("CursorLineNr",  { fg = colors.fg, bg = colors.bg, bold = true })
hl("SignColumn",    { bg = colors.bg })
hl("FoldColumn",    { fg = colors.inactive_fg, bg = colors.bg })
hl("Folded",        { fg = colors.inactive_fg, bg = colors.bar_bg })
hl("VertSplit",     { fg = colors.bar_bg, bg = colors.bg })
hl("WinSeparator",  { fg = colors.bar_bg, bg = colors.bg })
hl("EndOfBuffer",   { fg = colors.bg, bg = colors.bg })
hl("NonText",       { fg = colors.inactive_fg })
hl("SpecialKey",    { fg = colors.inactive_fg })
hl("Whitespace",    { fg = colors.bar_bg })
hl("Directory",     { fg = colors.link })
hl("Title",         { fg = colors.fg, bold = true })
hl("Conceal",       { fg = colors.inactive_fg })

-- Messages
hl("ErrorMsg",      { fg = colors.negative, bg = colors.bg })
hl("WarningMsg",    { fg = colors.neutral, bg = colors.bg })
hl("ModeMsg",       { fg = colors.fg })
hl("MoreMsg",       { fg = colors.positive })
hl("Question",      { fg = colors.positive })

-- Popup menu
hl("Pmenu",         { bg = colors.bg, fg = colors.fg })
hl("PmenuSel",      { bg = colors.selection_bg, fg = colors.fg, bold = true })
hl("PmenuSbar",     { bg = colors.bar_bg })
hl("PmenuThumb",    { bg = colors.fg })
hl("WildMenu",      { bg = colors.selection_bg, fg = colors.fg })

-- Statusline / Tabline
hl("StatusLine",    { bg = colors.bar_bg, fg = colors.bar_fg })
hl("StatusLineNC",  { bg = colors.bar_bg, fg = colors.inactive_fg })
hl("TabLine",       { bg = colors.bar_bg, fg = colors.inactive_fg })
hl("TabLineSel",    { bg = colors.selection_bg, fg = colors.fg, bold = true })
hl("TabLineFill",   { bg = colors.bg })

-- Syntax
hl("Comment",       { fg = colors.inactive_fg, italic = true })
hl("Constant",      { fg = colors.neutral })
hl("String",        { fg = colors.positive })
hl("Character",     { fg = colors.positive })
hl("Number",        { fg = colors.neutral })
hl("Boolean",       { fg = colors.neutral })
hl("Float",         { fg = colors.neutral })
hl("Identifier",    { fg = colors.link })
hl("Function",      { fg = colors.fg, bold = true })
hl("Statement",     { fg = colors.negative })
hl("Conditional",   { fg = colors.negative })
hl("Repeat",        { fg = colors.negative })
hl("Label",         { fg = colors.neutral })
hl("Operator",      { fg = colors.fg })
hl("Keyword",       { fg = colors.negative })
hl("Exception",     { fg = colors.negative })
hl("PreProc",       { fg = colors.neutral })
hl("Include",       { fg = colors.negative })
hl("Define",        { fg = colors.negative })
hl("Macro",         { fg = colors.neutral })
hl("PreCondit",     { fg = colors.neutral })
hl("Type",          { fg = colors.link })
hl("StorageClass",  { fg = colors.negative })
hl("Structure",     { fg = colors.link })
hl("Typedef",       { fg = colors.link })
hl("Special",       { fg = colors.neutral })
hl("SpecialChar",   { fg = colors.neutral })
hl("Tag",           { fg = colors.link })
hl("Delimiter",     { fg = colors.fg })
hl("SpecialComment",{ fg = colors.inactive_fg, italic = true })
hl("Debug",         { fg = colors.negative })
hl("Underlined",    { fg = colors.link, underline = true })
hl("Error",         { fg = colors.negative, bg = colors.bg })
hl("Todo",          { fg = colors.neutral, bg = colors.bg, bold = true })

-- Diagnostics
hl("DiagnosticError", { fg = colors.negative })
hl("DiagnosticWarn",  { fg = colors.neutral })
hl("DiagnosticInfo",  { fg = colors.link })
hl("DiagnosticHint",  { fg = colors.positive })
hl("DiagnosticOk",    { fg = colors.positive })
hl("DiagnosticUnderlineError", { undercurl = true, sp = colors.negative })
hl("DiagnosticUnderlineWarn",  { undercurl = true, sp = colors.neutral })
hl("DiagnosticUnderlineInfo",  { undercurl = true, sp = colors.link })
hl("DiagnosticUnderlineHint",  { undercurl = true, sp = colors.positive })

-- Diff
hl("DiffAdd",       { fg = colors.positive, bg = colors.bg })
hl("DiffChange",    { fg = colors.neutral, bg = colors.bg })
hl("DiffDelete",    { fg = colors.negative, bg = colors.bg })
hl("DiffText",      { fg = colors.fg, bg = colors.bar_bg, bold = true })

-- Spell
hl("SpellBad",      { undercurl = true, sp = colors.negative })
hl("SpellCap",      { undercurl = true, sp = colors.link })
hl("SpellLocal",    { undercurl = true, sp = colors.neutral })
hl("SpellRare",     { undercurl = true, sp = colors.positive })

-- Treesitter
hl("@comment",         { link = "Comment" })
hl("@string",          { link = "String" })
hl("@number",          { link = "Number" })
hl("@boolean",         { link = "Boolean" })
hl("@function",        { link = "Function" })
hl("@function.call",   { fg = colors.fg })
hl("@function.builtin",{ fg = colors.neutral })
hl("@method",          { fg = colors.fg, bold = true })
hl("@keyword",         { link = "Keyword" })
hl("@keyword.return",  { fg = colors.negative, italic = true })
hl("@conditional",     { link = "Conditional" })
hl("@repeat",          { link = "Repeat" })
hl("@operator",        { link = "Operator" })
hl("@type",            { link = "Type" })
hl("@type.builtin",    { fg = colors.link, italic = true })
hl("@variable",        { fg = colors.fg })
hl("@variable.builtin",{ fg = colors.neutral, italic = true })
hl("@parameter",       { fg = colors.fg, italic = true })
hl("@property",        { fg = colors.link })
hl("@field",           { fg = colors.link })
hl("@constant",        { link = "Constant" })
hl("@constant.builtin",{ fg = colors.neutral, italic = true })
hl("@namespace",       { fg = colors.link })
hl("@punctuation",     { fg = colors.fg })
hl("@punctuation.bracket", { fg = colors.fg })
hl("@punctuation.delimiter", { fg = colors.inactive_fg })
hl("@tag",             { link = "Tag" })
hl("@tag.attribute",   { fg = colors.neutral })
hl("@tag.delimiter",   { fg = colors.inactive_fg })

-- LSP semantic tokens
hl("@lsp.type.class",     { link = "Type" })
hl("@lsp.type.function",  { link = "Function" })
hl("@lsp.type.method",    { link = "@method" })
hl("@lsp.type.variable",  { link = "@variable" })
hl("@lsp.type.parameter", { link = "@parameter" })
hl("@lsp.type.property",  { link = "@property" })

-- GitSigns
hl("GitSignsAdd",    { fg = colors.positive })
hl("GitSignsChange", { fg = colors.neutral })
hl("GitSignsDelete", { fg = colors.negative })

-- NvimTree
hl("NvimTreeNormal",           { bg = colors.bg, fg = colors.fg })
hl("NvimTreeFolderName",       { fg = colors.link })
hl("NvimTreeOpenedFolderName", { fg = colors.positive })
hl("NvimTreeIndentMarker",     { fg = colors.inactive_fg })
hl("NvimTreeFolderIcon",       { fg = colors.fg })
hl("NvimTreeExecFile",         { fg = colors.positive })
hl("NvimTreeSpecialFile",      { fg = colors.negative, bold = true })

-- Telescope
hl("TelescopeNormal",         { bg = colors.bg, fg = colors.fg })
hl("TelescopeBorder",         { bg = colors.bg, fg = colors.bar_bg })
hl("TelescopePromptNormal",   { bg = colors.bar_bg, fg = colors.fg })
hl("TelescopePromptBorder",   { bg = colors.bar_bg, fg = colors.bar_bg })
hl("TelescopePromptTitle",    { bg = colors.fg, fg = colors.bg, bold = true })
hl("TelescopePreviewTitle",   { bg = colors.positive, fg = colors.bg, bold = true })
hl("TelescopeResultsTitle",   { bg = colors.bg, fg = colors.bg })
hl("TelescopeSelection",      { bg = colors.selection_bg, fg = colors.fg })
hl("TelescopeMatching",       { fg = colors.neutral, bold = true })

-- nvim-cmp
hl("CmpItemAbbr",            { fg = colors.fg })
hl("CmpItemAbbrMatch",       { fg = colors.neutral, bold = true })
hl("CmpItemAbbrMatchFuzzy",  { fg = colors.neutral, bold = true })
hl("CmpItemAbbrDeprecated",  { fg = colors.inactive_fg, strikethrough = true })
hl("CmpItemKindFunction",    { fg = colors.fg })
hl("CmpItemKindMethod",      { fg = colors.fg })
hl("CmpItemKindVariable",    { fg = colors.link })
hl("CmpItemKindKeyword",     { fg = colors.negative })
hl("CmpItemKindClass",       { fg = colors.link })
hl("CmpItemKindSnippet",     { fg = colors.positive })
hl("CmpItemMenu",            { fg = colors.inactive_fg })

-- Oil
hl("OilDir",      { fg = colors.link })
hl("OilFile",     { fg = colors.fg })
hl("OilLink",     { fg = colors.neutral })
hl("OilSocket",   { fg = colors.negative })
