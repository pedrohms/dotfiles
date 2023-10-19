local M = {
  "nvim-treesitter/nvim-treesitter-context",
  init = function()
    vim.keymap.set("n", "[c", function()
      require("treesitter-context").go_to_context()
    end, { silent = true })
  end
}
return M
