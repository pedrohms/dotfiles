local M = {
  'nvimtools/none-ls.nvim',
  init = function()
    local null_ls_status_ok, null_ls = pcall(require, "null-ls")
    if not null_ls_status_ok then
      return
    end
    local formatting = null_ls.builtins.formatting
    local diagnostics = null_ls.builtins.diagnostics

    -- https://github.com/prettier-solidity/prettier-plugin-solidity
    -- npm install --save-dev prettier prettier-plugin-solidity
    null_ls.setup {
      debug = false,
      sources = {
        formatting.prettier.with {
          extra_filetypes = { "toml", "solidity", "blade", "blade.php" },
          extra_args = { "--no-semi" },
        },
        formatting.black.with { extra_args = { "--fast" } },
        formatting.google_java_format,
        formatting.phpcsfixer
      },
    }
  end
}

return M
