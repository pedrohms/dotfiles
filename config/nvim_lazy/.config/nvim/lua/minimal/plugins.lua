if core_plugins == nil then
  plugins_ok, core_plugins = pcall( require , "core.plugins")
end

if plugins_ok then
  core_plugins.loadPlugins("minimal/plugins")
end
