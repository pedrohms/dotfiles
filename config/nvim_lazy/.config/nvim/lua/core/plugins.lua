local M = {}
M.plugins = {}
M.loadPlugins = function(path)
  local utils_ok, utils = pcall( require, "core.utils")
  if utils_ok then
    M.plugins = utils.requireNvimPath(path, M.plugins)
  end
end
M.initLazy = function()
  local fn = vim.fn

  local install_path = fn.stdpath "data" .. "/lazy/lazy.nvim"

  if fn.empty(fn.glob(install_path)) > 0 then
    LAZY_BOOTSTRAP = fn.system {
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      install_path,
    }
    print "Installing lazy close and reopen Neovim..."
  end
  vim.opt.rtp:prepend(install_path)

  local jdtls_debug_path = vim.fn.stdpath "data" .. "/custom/dap/jdtls"
  if vim.fn.empty(vim.fn.glob(jdtls_debug_path)) > 0 then
    DAP_JDTLS_BOOTSTRAP = vim.fn.system {
      "git",
      "clone",
      "--depth",
      "1",
      "https://github.com/microsoft/java-debug",
      jdtls_debug_path,
    }
  end

  local jdtls_test_path = vim.fn.stdpath "data" .. "/custom/dap/jdtls-test"
  if vim.fn.empty(vim.fn.glob(jdtls_test_path)) > 0 then
    DAP_JDTLS_BOOTSTRAP = vim.fn.system {
      "git",
      "clone",
      "--depth",
      "1",
      "https://github.com/microsoft/vscode-java-test.git",
      jdtls_test_path,
    }
  end
  -- Autocommand that reloads neovim whenever you save the plugins.lua file
  -- vim.cmd [[
  --   augroup packer_user_config
  --     autocmd!
  --     autocmd BufWritePost plugins.lua source <afile> | Lazy
  --   augroup end
  -- ]]

  local status_ok, lazy = pcall(require, "lazy")
  if not status_ok then
    return
  end

  return lazy.setup ( M.plugins )
end

return M
