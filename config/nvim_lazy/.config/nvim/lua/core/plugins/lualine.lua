local M = {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons'
  },
  init = function()
    local status_ok, lualine = pcall(require, "lualine")
    if not status_ok then
      return
    end

    local customlualine = require("core.utils.lualine")
    lualine_user = { builtin = { lualine } }
    customlualine.config()
    customlualine.setup()
  end
}

return M
