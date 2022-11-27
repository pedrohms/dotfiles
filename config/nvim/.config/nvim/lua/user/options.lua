local options = {
  clipboard = "unnamedplus",
  mouse = "a",
  number = true,
  background = "dark",
  relativenumber = true,
  hlsearch = true,
  hidden = true,
  errorbells = false,
  tabstop = 2,
  softtabstop = 2,
  shiftwidth = 2,
  expandtab = true,
  smartindent = true,
  smartcase = true,
  nu = true,
  wrap = false,
  swapfile = false,
  backup = false,
  undodir = (vim.fn.stdpath "data" .. "/undodir") or nil,
  undofile = true,
  incsearch = true,
  termguicolors = true,
  scrolloff = 8,
  signcolumn = "yes",
  cmdheight = 1, updatetime = 50,
  colorcolumn = "80",
  cursorline = true,
  fileencoding = "utf-8",
}
vim.opt.isfname:append("@-@")
vim.opt.shortmess:append("c")

if os.getenv("OS") == "Windows_NT" then
  -- vim.o.shell = "pwsh.exe -NoLogo"
  vim.o.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
  vim.cmd [[
		let &shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
		let &shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
		set shellquote= shellxquote=
  ]]
else
  vim.o.shell = "/bin/bash"
end

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.g.mapleader = " "
