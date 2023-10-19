require "core.options"

if core_plugins == nil then
  plugins_ok, core_plugins = pcall( require , "core.plugins")
  core_plugins.loadPlugins("core/plugins")
end
