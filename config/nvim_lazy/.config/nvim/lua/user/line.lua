local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  return
end

local customlualine = require("user.lualine")
lualine_user = { builtin = { lualine } }
customlualine.config()
customlualine.setup()
