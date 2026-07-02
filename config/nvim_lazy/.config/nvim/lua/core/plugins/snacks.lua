return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  init = function()
    require("snacks").setup({
      notifier = { enabled = true },
      input = { enabled = true },
      -- O módulo 'bigfile' é excelente para os seus projetos Java/Spring grandes
      bigfile = { enabled = true },
    })
  end,
}
