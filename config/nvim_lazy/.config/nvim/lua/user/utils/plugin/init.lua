local catppuccin_ok, catppuccin  = pcall(require, "catppuccin")
if catppuccin_ok then
  catppuccin.setup({
    transparent = true
  })
  catppuccin.load()
else
  vim.cmd [[ colorscheme catppuccin ]]
end

local status_ok, comment = pcall(require, "Comment")
if status_ok then
  comment.setup()
end

local telescope = require("telescope")
local notify_ok, notify = pcall(require, "notify")
if notify_ok then
  telescope.load_extension("notify")
end

vim.api.nvim_set_hl(0, 'EyelinerPrimary', { fg = '#ff00ff', bold = true, underline = false })
vim.api.nvim_set_hl(0, 'EyelinerSecondary', { fg = '#00ffff', underline = false })

local transparent_ok, transparent = pcall(require, "transparent")
if transparent_ok then
  transparent.setup {
    groups = { -- table: default groups
      'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
      'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
      'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
      'SignColumn', 'CursorLineNr', 'EndOfBuffer',
    },
    extra_groups = {
      "NormalFloat", -- plugins which have float panel such as Lazy, Mason, LspInfo
      "NvimTreeNormal" -- NvimTree
    },
    transparent = vim.g.transparent_enabled
  }
end
