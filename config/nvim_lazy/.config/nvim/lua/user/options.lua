vim.opt.clipboard = "unnamedplus"
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.background = "dark"
vim.opt.relativenumber = true
vim.opt.hlsearch = false
vim.opt.hidden = true
vim.opt.errorbells = false
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.smartcase = true
vim.opt.nu = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = (vim.fn.stdpath "data" .. "/undodir") or nil
vim.opt.undofile = true
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.cmdheight = 1
vim.opt.updatetime = 50
vim.opt.colorcolumn = "80"
vim.opt.cursorline = true
vim.opt.fileencoding = "utf-8"
vim.opt.isfname:append("@-@")
vim.opt.shortmess:append("c")
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.splitbelow = true
vim.opt.splitright = true

if os.getenv("OS") == "Windows_NT" then
  -- vim.o.shell = "pwsh.exe -NoLogo"
  vim.o.shellcmdflag =
  "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
  vim.cmd [[
		let &shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
		let &shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
		set shellquote= shellxquote=
  ]]
else
  vim.o.shell = "fish"
end

vim.g.mapleader = " "


-- local onedarker_ok, onedarker = pcall(require, "onedarker")
-- if onedarker_ok then
--   onedarker.setup({
--     transparent = true
--   })
--   onedarker.load()
-- else
vim.o.background = "dark"   -- or "light" for light mode
-- local catppuccin_ok, _ = pcall(require, "catppuccin")
-- if catppuccin_ok then
--   vim.cmd [[ colorscheme catppuccin ]]
vim.cmd [[ colorscheme gruvbox ]]
-- end
-- vim.cmd("let g:gruvbox_material_background= 'hard'")
-- vim.cmd("let g:gruvbox_material_transparent_background=0")
-- vim.cmd([[colorscheme gruvbox-material]])   -- Set color scheme
-- end

local status_ok, comment = pcall(require, "Comment")
if status_ok then
  comment.setup()
end

local telescope_ok, telescope = pcall(require, "telescope")
if telescope_ok then
  local notify_ok, _ = pcall(require, "notify")
  if notify_ok then
    telescope.load_extension("notify")
  end
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
      "NormalFloat",   -- plugins which have float panel such as Lazy, Mason, LspInfo
      "NvimTreeNormal" -- NvimTree
    },
    transparent = vim.g.transparent_enabled
  }
end
