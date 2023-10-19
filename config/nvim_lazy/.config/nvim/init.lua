if os.getenv("NVIM_FULL") == "1" then
  require "user"
  require "core.keymap"
  require "user.utils.plugin.gitsigns"
  return
end

if os.getenv("NVIM_CLANGD") == "1" then
  require "minimal"

  local lsp = require "core.lsp"
  lsp.servers = {
    "clangd"
  }
  lsp.setup()
  lsp.installer()
  lsp.setupHandler()
  return
end

if os.getenv("NVIM_JAVA") == "1" then

  plugins_ok, core_plugins = pcall( require , "core.plugins")

  if plugins_ok == false then return end


  table.insert(core_plugins.plugins, { "mfussenegger/nvim-dap" })
  table.insert(core_plugins.plugins, { "theHamsta/nvim-dap-virtual-text" })
  table.insert(core_plugins.plugins, { "rcarriga/nvim-dap-ui" })
  table.insert(core_plugins.plugins, { "pedrohms/dap-install" })
  table.insert(core_plugins.plugins, { "rcarriga/cmp-dap" })
  table.insert(core_plugins.plugins, { "mfussenegger/nvim-jdtls" })

  table.insert(core_plugins.plugins, { "lunarvim/colorschemes" })

  core_plugins.loadPlugins("core/plugins")

  require "minimal"

  require "core.keymap"


  local lsp = require "core.lsp"
  lsp.servers = {
    "jdtls"
  }
  lsp.mason_packages = {
    "java-debug-adapter",
    "java-test",
    "google-java-format",
  }
  lsp.setup()
  lsp.installer()
  lsp.setupHandler()
  return
end

require "minimal"

local lsp = require "core.lsp"
lsp.setup()
lsp.installer()
lsp.setupHandler()
