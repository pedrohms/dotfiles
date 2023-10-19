local M = {}
M.config = function()
  lualine_user.builtin.lualine = {
    active = true,
    style = "lvim",
    options = {
      icons_enabled = nil,
      component_separators = nil,
      section_separators = nil,
      theme = nil,
      disabled_filetypes = nil,
      globalstatus = false,
    },
    sections = {
      lualine_a = nil,
      lualine_b = nil,
      lualine_c = nil,
      lualine_x = nil,
      lualine_y = nil,
      lualine_z = nil,
    },
    inactive_sections = {
      lualine_a = nil,
      lualine_b = nil,
      lualine_c = nil,
      lualine_x = nil,
      lualine_y = nil,
      lualine_z = nil,
    },
    tabline = nil,
    extensions = nil,
    on_config_done = nil,
  }
end

M.setup = function()
  -- avoid running in headless mode since it's harder to detect failures
  if #vim.api.nvim_list_uis() == 0 then
    return
  end

  require("core.utils.lualine.styles").update()

  local lualine_ok, lualine = pcall(require, "lualine")
  if lualine_ok then
    lualine.setup(lualine_user.builtin.lualine)

    if lualine_user.builtin.lualine.on_config_done then
      lualine_user.builtin.lualine.on_config_done(lualine)
    end
  end
end

return M
