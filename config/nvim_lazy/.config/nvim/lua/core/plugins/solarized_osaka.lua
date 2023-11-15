local M = {
  "craftzdog/solarized-osaka.nvim",
  lazy = true,
  opts = function()
    return {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      }
    }
  end
}
return M
