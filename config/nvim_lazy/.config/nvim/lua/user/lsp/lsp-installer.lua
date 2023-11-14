local status_ok, lsp_installer = pcall(require, "mason-lspconfig")
if not status_ok then
  return
end

local servers = {
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

local mason_packages = {
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

local outside_config = {
  "dartls"
}

for _, server in pairs(servers) do
  local capabilities_temp = vim.lsp.protocol.make_client_capabilities()
  capabilities_temp = cmp_nvim_lsp.default_capabilities(capabilities_temp)
  capabilities_temp.textDocument.completion.completionItem.snippetSupport = true

  opts = {
    on_attach = require("user.lsp.handlers").on_attach,
    on_init = require("user.lsp.handlers").on_init,
    capabilities = capabilities_temp,
  }

  -- if server == "eslint" then
  --   local eslint_opts = {
  --     handlers = {
  --       ["eslint/probeFailed"] = function()
  --         return {}
  --       end,
  --       ["eslint/noLibrary"] = function()
  --         return {}
  --       end,
  --     }
  --   }
  --   opts = vim.tbl_deep_extend("force", eslint_opts, opts)
  -- end

  if server == "clangd" then
    if os.getenv("NIX_USER_PROFILE_DIR") ~= nil then
      local sumneko_cmd = { cmd = { os.getenv("HOME") .. "/.nix-profile/bin/clangd" } }
      opts = vim.tbl_deep_extend("force", sumneko_cmd, opts)
    end
  end

  if server == "phpactor" then
    if os.getenv("PHPACTOR_PATH") ~= nil then
      local phpactor_cmd = { cmd = { os.getenv("PHPACTOR_PATH") .. "/bin/phpactor", "language-server" } }
      opts = vim.tbl_deep_extend("force", phpactor_cmd, opts)
    end
  end

  if server == "lua_ls" then
    local sumneko_opts = require "user.lsp.settings.lua_ls"
    if os.getenv("NIX_USER_PROFILE_DIR") ~= nil then
      local sumneko_cmd = { cmd = { os.getenv("HOME") .. "/.nix-profile/bin/lua-language-server" } }
      opts = vim.tbl_deep_extend("force", sumneko_cmd, opts)
    end
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
      filetypes = { "ps1" },
    }
    opts = vim.tbl_deep_extend("force", powershell_opts, opts)
  end

  if server == "intelephense" then
    local intelephense_opts = {
      filetypes = { "php", "blade", "blade.php" },
    }
    opts = vim.tbl_deep_extend("force", intelephense_opts, opts)
  end

  if server == "kotlin_language_server" then
    if os.getenv("KOTLIN_LSP_HOME") ~= nil then
      local kotlin_opts = {
        cmd = { os.getenv("KOTLIN_LSP_HOME") .. "/bin/kotlin-language-server" }
      }
      opts = vim.tbl_deep_extend("force", kotlin_opts, opts)
    end
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

for _, server in pairs(outside_config) do
  local capabilities_temp = vim.lsp.protocol.make_client_capabilities()
  capabilities_temp = cmp_nvim_lsp.default_capabilities(capabilities_temp)
  capabilities_temp.textDocument.completion.completionItem.snippetSupport = true

  opts = {
    on_attach = require("user.lsp.handlers").on_attach,
    on_init = require("user.lsp.handlers").on_init,
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

    if os.getenv("NIX_PATH") ~= nil then
      if os.getenv("DART_PATH") ~= nil then
        local dart_cmd_opts = {
          cmd = { os.getenv("DART_PATH") .. "/bin/dart", "language-server", "--protocol=lsp" },
        }
        vim.tbl_deep_extend("force", dart_cmd_opts, opts)
      end
    end
  end

  lspconfig[server].setup(opts)
end
