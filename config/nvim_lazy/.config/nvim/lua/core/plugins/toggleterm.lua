local M = {
  "akinsho/toggleterm.nvim",
  init = function()
    local ok, _ = pcall(require, "toggleterm")
    if ok then
      local terminal_ok, terminal = pcall(require, "core.utils.terminal")
      if terminal_ok then
        terminal.config()
        terminal.setup()
      end
    end
  end
}

return M
