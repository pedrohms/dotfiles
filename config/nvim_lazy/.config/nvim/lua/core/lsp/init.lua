local M = {}
M.servers = {
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
  "phpactor",
  -- "intelephense",
}
M.mason_packages = {
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

M.initCmp = function()
  require("core.lsp.cmp")
end
M.setupHandler = function()
  require("core.lsp.handlers").setup()

  vim.diagnostic.config({
    virtual_text = true
  })

  M.initCmp()
end
M.setup = function()
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

  require("core.lsp.download_packages")

  -- require("user.lsp.lsp-signature")

  mason.setup()
  mason_config.setup()

  require "core.lsp.dap"
  -- require "core.lsp.null-ls"
  -- require "user.lsp.formatter"
end

M.installer = function()
  local status_ok, lsp_installer = pcall(require, "mason-lspconfig")
  if not status_ok then
    return
  end

  table.insert(M.servers, "lua_ls")
  table.insert(M.servers, "emmet_ls")

  local settings = {
    ensure_installed = M.servers,
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
    for _, packageName in pairs(M.mason_packages) do
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

  local outside_config = {
    "dartls"
  }

  for _, server in pairs(M.servers) do
    local capabilities_temp = vim.lsp.protocol.make_client_capabilities()
    capabilities_temp = cmp_nvim_lsp.default_capabilities(capabilities_temp)
    capabilities_temp.textDocument.completion.completionItem.snippetSupport = true

    opts = {
      on_attach = require("core.lsp.handlers").on_attach,
      on_init = require("core.lsp.handlers").on_init,
      capabilities = capabilities_temp,
    }

    if server == "clangd" then
      if os.getenv("NIX_USER_PROFILE_DIR") ~= nil then
        local clangd_cmd = { cmd = { os.getenv("HOME") .. "/.nix-profile/bin/clangd" } }
        opts = vim.tbl_deep_extend("force", clangd_cmd, opts)
      end
    end

    if server == "lua_ls" then
      local sumneko_opts = require "core.lsp.settings.lua_ls"
      if os.getenv("NIX_USER_PROFILE_DIR") ~= nil then
        local sumneko_cmd = { cmd = { os.getenv("HOME") .. "/.nix-profile/bin/lua-language-server" } }
        opts = vim.tbl_deep_extend("force", sumneko_cmd, opts)
      end
      opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
    end

    if server == "pyright" then
      local pyright_opts = require "core.lsp.settings.pyright"
      opts = vim.tbl_deep_extend("force", pyright_opts, opts)
    end

    if server == "emmet_ls" then
      local emmet_ls_opts = require "core.lsp.settings.emmet_ls"
      opts = vim.tbl_deep_extend("force", emmet_ls_opts, opts)
    end

    if server == "gopls" then
      local gopls_opts = require "core.lsp.settings.gopls"
      opts = vim.tbl_deep_extend("force", gopls_opts, opts)
    end

    if server == "powershell_es" then
      local powershell_opts = {
        filetypes = { "ps1" },
      }
      opts = vim.tbl_deep_extend("force", powershell_opts, opts)
    end


    if server == "tsserver" then
      local tsserver_opts = {
        init_options = {
          plugins = {
            {
              name = "@vue/typescript-plugin",
              location = "/home/framework/.local/share/npm/dependencies/node_modules/@vue/typescript-plugin",
              languages = { "javascript", "typescript", "vue" },
            },
          },
        },
        filetypes = {
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
          "vue",
        },
      }
      opts = vim.tbl_deep_extend("force", tsserver_opts, opts)
    end

    if server == "intelephense" then
      local intelephense_opts = {
        filetypes = { "php", "blade", "blade.php" },
      }
      opts = vim.tbl_deep_extend("force", intelephense_opts, opts)
    end

    if server ~= "jdtls" then
      lspconfig[server].setup(opts)
    end
  end

  for _, server in pairs(outside_config) do
    local capabilities_temp = vim.lsp.protocol.make_client_capabilities()
    capabilities_temp = cmp_nvim_lsp.default_capabilities(capabilities_temp)
    capabilities_temp.textDocument.completion.completionItem.snippetSupport = true

    opts = {
      on_attach = require("core.lsp.handlers").on_attach,
      on_init = require("core.lsp.handlers").on_init,
      capabilities = capabilities_temp,
    }

    if server == "dartls" then
      local dart_opts = {
        settings = {
          dart = {
            analysisExcludedFolders = {
              vim.fn.expand("$HOME/.pub-cache"),
              vim.fn.expand("$HOME/tools/flutter/"),
              vim.fn.expand("$HOME/AppData/Local/Pub/Cache")
            },
          },
        },
      }
      vim.tbl_deep_extend("force", dart_opts, opts)
    end

    lspconfig[server].setup(opts)
  end
end

return M
