require "core"
require "minimal.plugins"

core_plugins.initLazy()

require "core.keymap"

vim.o.background = "dark" -- or "light" for light mode
local gruvbox_ok, _ = pcall( require, "gruvbox")
if gruvbox_ok then
  vim.cmd [[ colorscheme gruvbox ]]
end
