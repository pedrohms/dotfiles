local ensure_installed = {
  "c", "lua", "php", "javascript", "svelte", "vim", "vimdoc", "query", "typescript",
  "astro", "bash", "cmake", "comment", "commonlisp", "cpp", "css", "dart",
  "diff", "dockerfile", "fish", "git_config", "git_rebase", "gitattributes", "gitcommit",
  "gitignore", "go", "gomod", "gosum", "gowork", "gpg", "haskell", "html",
  "http", "ini", "java", "json", "jsdoc", "jq", "luadoc", "make", "ninja",
  "nix", "prisma", "pug", "python", "rust", "scss", "sql", "ssh_config", "sxhkdrc",
  "toml", "tsx", "vue", "xml", "yaml"
}
local M = {
  'nvim-treesitter/nvim-treesitter',
  init = function()
    require 'nvim-treesitter.configs'.setup {
      ensure_installed = ensure_installed,
      sync_install = false,
      ignore_install = { "phpdoc", "tflint", "markdown", "markdown_inline", "tla", "tla+", "tlaplus" },
      highlight = {
        enable = false,
        additional_vim_regex_highlighting = true,
      },
      indent = {
        enable = false,
        disable = { "python", "css" },
      },
      autopairs = {
        enable = false,
      },
      autotag = {
        enable = true,
        disable = { "xml" },
      },
      rainbow = {
        enable = true,
      },
    }
  end,
}

return M
