require "core"
require "minimal.plugins"

core_plugins.initLazy()

require "core.keymap"

vim.o.background = "dark" -- or "light" for light mode
-- vim.cmd("let g:gruvbox_material_background= 'hard'")
-- vim.cmd("let g:gruvbox_material_transparent_background=0")
-- vim.cmd([[colorscheme gruvbox-material]])   -- Set color scheme
vim.cmd([[colorscheme catppuccin-mocha]])
vim.g.remember_window_size = true

local lsp = require "core.lsp"

lsp.servers = {
  "emmet_ls",
  -- "eslint",
  "cssls",
  "html",
  "jdtls",
  "solc",
  "lua_ls",
  "tsserver",
  "pyright",
  "yamlls",
  "bashls",
  "clangd",
  "gopls",
  "volar",
  "svelte",
  "tailwindcss",
  "kotlin_language_server",
  "lemminx",
  "astro",
  "dockerls",
  "rust_analyzer",
  "solidity",
  -- "phpactor",
  "intelephense",
}
lsp.mason_packages = {
  "solidity-ls",
  "delve",
  "go-debug-adapter",
  "java-debug-adapter",
  "java-test",
  "google-java-format",
  "js-debug-adapter",
  "node-debug2-adapter",
  "php-debug-adapter",
  "php-cs-fixer",
  "prettier",
  "blade-formatter",
  "black",
}
lsp.setup()
lsp.installer()
lsp.setupHandler()
