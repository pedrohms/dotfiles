local status_ok, lsp_installer = pcall(require, "mason-lspconfig")
if not status_ok then
  return
end

local servers = {
  "emmet_ls",
  "eslint",
  "cssls",
  "html",
  "jdtls",
  "solc",
  "sumneko_lua",
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
  "intelephense"
}

local mason_packages = {
  "solidity-ls",
  "rustfmt",
  "delve",
  "go-debug-adapter",
  "java-debug-adapter",
  "java-test",
  "js-debug-adapter",
  "node-debug2-adapter",
  "php-debug-adapter",
  "php-cs-fixer",
  "prettier",
  "rustfmt"
}

local settings = {
  ensure_installed = servers,
  ui = {
    icons = {},
    keymaps = {
      toggle_server_expand = "<CR>",
      install_server = "i",
      update_server = "u",
      check_server_version = "c",
      update_all_servers = "U",
      check_outdated_servers = "C",
      uninstall_server = "X",
    },
  },

  log_level = vim.log.levels.INFO,
}

local status_ok_mason_registry, mason_registry = pcall(require, "mason-registry")
if status_ok_mason_registry then
  for _, packageName in pairs(mason_packages) do
    if not mason_registry.is_installed(packageName) then
      vim.cmd(":MasonInstall " .. packageName)
    end
  end
end

lsp_installer.setup(settings)

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

local opts = {}

local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
  return
end

for _, server in pairs(servers) do

  local capabilities_temp = vim.lsp.protocol.make_client_capabilities()
  capabilities_temp = cmp_nvim_lsp.default_capabilities(capabilities_temp)
  capabilities_temp.textDocument.completion.completionItem.snippetSupport = true

  opts = {
    on_attach = require("user.lsp.handlers").on_attach,
    on_init = require("user.lsp.handlers").on_init,
    capabilities = capabilities_temp,
  }

  if server == "eslint" then
    local eslint_opts = {
      handlers = {
        ["eslint/probeFailed"] = function()
          return {}
        end,
        ["eslint/noLibrary"] = function()
          return {}
        end,
      }
    }
    opts = vim.tbl_deep_extend("force", eslint_opts, opts)
  end

  if server == "sumneko_lua" then
    local sumneko_opts = require "user.lsp.settings.sumneko_lua"
    opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
  end

  if server == "pyright" then
    local pyright_opts = require "user.lsp.settings.pyright"
    opts = vim.tbl_deep_extend("force", pyright_opts, opts)
  end

  if server == "emmet_ls" then
    local emmet_ls_opts = require "user.lsp.settings.emmet_ls"
    opts = vim.tbl_deep_extend("force", emmet_ls_opts, opts)
  end

  if server == "gopls" then
    local gopls_opts = require "user.lsp.settings.gopls"
    opts = vim.tbl_deep_extend("force", gopls_opts, opts)
  end

  if server == "powershell_es" then
    local powershell_opts = {
      filetype = { "ps1" },
    }
    opts = vim.tbl_deep_extend("force", powershell_opts, opts)
  end

  -- if server == "jdtls" then
  --   local function on_language_status(_, result)
  --     -- local command = vim.api.nvim_command
  --     -- command 'echohl ModeMsg'
  --     -- command(string.format('echo "%s"', result.message))
  --     -- command 'echohl None'
  --   end
  --
  --   local java_config = require("user.lsp.settings.java_config")
  --
  --   java_config.handlers = {
  --       ['$/progress'] = vim.schedule_wrap(on_language_status),
  --   }
  --
  --   opts = vim.tbl_deep_extend("force", java_config, opts)
  -- end

  -- if server == "volar" then
  --   local volar_config = require("user.lsp.settings.volar")
  --   opts = vim.tbl_deep_extend("force", volar_config, opts)
  -- end

  if server ~= "jdtls" then
    lspconfig[server].setup(opts)
  end
end
