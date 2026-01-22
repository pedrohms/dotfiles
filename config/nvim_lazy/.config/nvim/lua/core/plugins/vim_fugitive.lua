return {
  "tpope/vim-fugitive",
  event = "BufReadPost",
  keys = {
    { "<leader>gs", "<cmd>G<cr>", desc = "Git Status (Fugitive)" },
  }
}
