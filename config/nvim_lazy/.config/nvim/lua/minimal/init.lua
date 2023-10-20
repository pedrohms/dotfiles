require "core"
require "minimal.plugins"

core_plugins.initLazy()

require "core.keymap"

vim.o.background = "dark" -- or "light" for light mode
vim.cmd [[ colorscheme gruvbox-material ]]
