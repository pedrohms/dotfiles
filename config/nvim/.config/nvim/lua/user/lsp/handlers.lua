local M = {}

M.setup = function()
  local signs = {

    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  local config = {
    virtual_text = false, -- disable virtual text
    signs = {
      active = signs, -- show signs
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = true,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  })
end

local function lsp_keymaps(client, bufnr)
  local Remap = require("user.keymap")
  local nnoremap = Remap.nnoremap
  local inoremap = Remap.inoremap
  local vnoremap = Remap.vnoremap
  if client.name == "jdtls" then
    nnoremap("<leader>lpc", function() require("jdtls").update_project_config() end)
  end
  nnoremap("gd", function() vim.lsp.buf.definition() end)
  nnoremap("K", function() vim.lsp.buf.hover() end)
  nnoremap("<leader>lws", function() vim.lsp.buf.workspace_symbol() end)
  nnoremap("<leader>ld", function() vim.diagnostic.open_float() end)
  nnoremap("[d", function() vim.diagnostic.goto_next() end)
  nnoremap("]d", function() vim.diagnostic.goto_prev() end)
  nnoremap("<leader>lca", function() vim.lsp.buf.code_action() end)
  nnoremap("<leader>lrf", function() vim.lsp.buf.references() end)
  nnoremap("<leader>lrn", function() vim.lsp.buf.rename() end)
  inoremap("<C-h>", function() vim.lsp.buf.signature_help() end)
  inoremap("<C-K>", function() vim.lsp.buf.hover() end)
  nnoremap("<leader>lsf", function() require("telescope.builtin").lsp_document_symbols(require("telescope.themes")
      .get_dropdown { previewer = false })
  end)
  nnoremap("<leader>lf", function() vim.lsp.buf.format { async = true } end)
  vnoremap("<leader>lrf", function() vim.lsp.buf.range_formatting() end)
end

local disable_format = function(c)
  if c["server_capatilities"] ~= nil then
    c.server_capabilities.document_formatting = false
    c.server_capabilities.document_range_formatting = false
  end
end

local exclude_nullls = {
  "sumneko_lua",
  "astro"
}
M.on_init = function(client)
  if client.name == "jdtls" then
    local java_config = require("user.lsp.settings.java_config")
    client.config.settings = java_config.settings
    client.config.cmd = java_config.cmd
    disable_format(client)
  else
    for _, ft in pairs(exclude_nullls) do
      if ft == client.name then
        goto jump_disable
      end
    end
    disable_format(client)
    ::jump_disable::
  end
end
M.on_attach = function(client, bufnr)
  local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  if not status_cmp_ok then
    return
  end

  lsp_keymaps(client, bufnr)

  if client.name == "jdtls" then
    vim.lsp.codelens.refresh()
    require("jdtls").setup_dap { hotcodereplace = "auto" }
    require("jdtls.dap").setup_dap_main_class_configs()
  end

  M.capabilities = vim.lsp.protocol.make_client_capabilities()
  M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)
  M.capabilities.textDocument.completion.completionItem.snippetSupport = true
end

return M
