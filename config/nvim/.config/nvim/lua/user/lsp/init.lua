local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

local status_ok_mason, mason = pcall(require, "mason")
if not status_ok_mason then
  return
end

local status_ok_mason_config, mason_config = pcall(require, "mason-lspconfig")
if not status_ok_mason_config then
  return
end

require("user.lsp.download_packages")

require("user.lsp.lsp-signature")

mason.setup()
mason_config.setup()

require "user.lsp.lsp-installer"
require("user.lsp.handlers").setup()
require "user.lsp.null-ls"

vim.diagnostic.config({
  virtual_text = true
})

-- local l_status_ok, lsp_lines = pcall(require, "lsp_lines")
-- if not l_status_ok then
--   return
-- end
--
-- lsp_lines.setup()
--
-- vim.diagnostic.config({ virtual_lines = { only_current_line = false } })
