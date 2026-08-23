vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end

vim.o.background = "dark"
vim.g.colors_name = "atom-dark"

local c = {
  bg = "#282c34",
  bg_alt = "#21252b",
  selection = "#3e4451",
  fg = "#abb2bf",
  muted = "#5c6370",
  red = "#e06c75",
  green = "#98c379",
  yellow = "#e5c07b",
  blue = "#61afef",
  purple = "#c678dd",
  cyan = "#56b6c2",
  orange = "#d19a66",
}

local function hi(group, spec)
  vim.api.nvim_set_hl(0, group, spec)
end

hi("Normal", { fg = c.fg, bg = c.bg })
hi("NormalFloat", { fg = c.fg, bg = c.bg_alt })
hi("FloatBorder", { fg = c.selection, bg = c.bg_alt })
hi("CursorLine", { bg = c.bg_alt })
hi("CursorLineNr", { fg = c.yellow, bold = true })
hi("LineNr", { fg = c.muted })
hi("Visual", { bg = c.selection })
hi("Search", { fg = c.bg, bg = c.yellow })
hi("IncSearch", { fg = c.bg, bg = c.orange })
hi("MatchParen", { fg = c.cyan, bold = true, underline = true })
hi("WinSeparator", { fg = c.selection })
hi("SignColumn", { bg = c.bg })
hi("ColorColumn", { bg = c.bg_alt })
hi("Folded", { fg = c.muted, bg = c.bg_alt })
hi("NonText", { fg = c.selection })
hi("Whitespace", { fg = c.selection })

hi("Comment", { fg = c.muted, italic = true })
hi("String", { fg = c.green })
hi("Character", { fg = c.green })
hi("Number", { fg = c.orange })
hi("Boolean", { fg = c.orange })
hi("Float", { fg = c.orange })
hi("Identifier", { fg = c.red })
hi("Function", { fg = c.blue })
hi("Statement", { fg = c.purple })
hi("Conditional", { fg = c.purple })
hi("Repeat", { fg = c.purple })
hi("Keyword", { fg = c.purple })
hi("Operator", { fg = c.cyan })
hi("Type", { fg = c.yellow })
hi("Structure", { fg = c.yellow })
hi("StorageClass", { fg = c.purple })
hi("PreProc", { fg = c.purple })
hi("Special", { fg = c.cyan })
hi("Delimiter", { fg = c.fg })
hi("Error", { fg = c.red })

hi("Pmenu", { fg = c.fg, bg = c.bg_alt })
hi("PmenuSel", { fg = c.bg, bg = c.blue, bold = true })
hi("PmenuSbar", { bg = c.bg_alt })
hi("PmenuThumb", { bg = c.selection })
hi("StatusLine", { fg = c.fg, bg = c.bg_alt })
hi("StatusLineNC", { fg = c.muted, bg = c.bg_alt })
hi("TabLine", { fg = c.muted, bg = c.bg_alt })
hi("TabLineSel", { fg = c.blue, bg = c.bg, bold = true })
hi("TabLineFill", { bg = c.bg_alt })

hi("DiagnosticError", { fg = c.red })
hi("DiagnosticWarn", { fg = c.yellow })
hi("DiagnosticInfo", { fg = c.blue })
hi("DiagnosticHint", { fg = c.cyan })
hi("DiagnosticUnderlineError", { undercurl = true, sp = c.red })
hi("DiagnosticUnderlineWarn", { undercurl = true, sp = c.yellow })

hi("DiffAdd", { fg = c.green, bg = "#2c3232" })
hi("DiffChange", { fg = c.yellow, bg = "#33322c" })
hi("DiffDelete", { fg = c.red, bg = "#342b2f" })
hi("GitSignsAdd", { fg = c.green })
hi("GitSignsChange", { fg = c.yellow })
hi("GitSignsDelete", { fg = c.red })

-- Treesitter and semantic tokens inherit the Atom palette.
hi("@variable", { fg = c.fg })
hi("@variable.builtin", { fg = c.red, italic = true })
hi("@constant", { fg = c.orange })
hi("@string", { link = "String" })
hi("@comment", { link = "Comment" })
hi("@function", { link = "Function" })
hi("@function.call", { fg = c.blue })
hi("@constructor", { fg = c.yellow })
hi("@keyword", { link = "Keyword" })
hi("@keyword.function", { fg = c.purple })
hi("@type", { link = "Type" })
hi("@type.builtin", { fg = c.yellow })
hi("@property", { fg = c.red })
hi("@operator", { link = "Operator" })
hi("@punctuation", { fg = c.fg })
hi("@module", { fg = c.yellow })

hi("MiniCompletionActiveParameter", { underline = true, sp = c.blue })
hi("MiniCursorword", { bg = c.selection })
hi("MiniIndentscopeSymbol", { fg = c.blue })
hi("MiniJump", { fg = c.bg, bg = c.red, bold = true })
hi("MiniPickMatchCurrent", { bg = c.selection })
hi("MiniPickMatchMarked", { fg = c.orange })
hi("MiniPickMatchRanges", { fg = c.cyan })
hi("MiniStatuslineModeNormal", { fg = c.bg, bg = c.blue, bold = true })
hi("MiniStatuslineModeInsert", { fg = c.bg, bg = c.green, bold = true })
hi("MiniStatuslineModeVisual", { fg = c.bg, bg = c.purple, bold = true })
hi("MiniStatuslineModeReplace", { fg = c.bg, bg = c.red, bold = true })
hi("MiniStatuslineModeCommand", { fg = c.bg, bg = c.yellow, bold = true })
