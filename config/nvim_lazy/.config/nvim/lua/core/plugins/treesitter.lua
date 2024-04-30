local ensure_installed = {
  "c", "lua", "php", "javascript", "svelte", "vim", "vimdoc", "query", "typescript",
  "astro", "bash", "cmake", "comment", "commonlisp", "cpp", "css", "dart",
  "diff", "dockerfile", "fish", "git_config", "git_rebase", "gitattributes", "gitcommit",
  "gitignore", "go", "gomod", "gosum", "gowork", "gpg", "haskell", "html",
  "http", "ini", "java", "json", "jsdoc", "jq", "luadoc", "make", "ninja",
  "nix", "prisma", "pug", "python", "rust", "scss", "sql", "ssh_config", "sxhkdrc",
  "toml", "tsx", "vue", "xml", "yaml", "markdown"
}
local M = {
  'nvim-treesitter/nvim-treesitter',
  init = function()
    local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
    parser_config.blade = {
      install_info = {
        url = "https://github.com/EmranMR/tree-sitter-blade",
        files = {
          "src/parser.c",
        },
        branch = "main",
        generate_requires_npm = true,
        requires_generate_from_grammar = true,
      },
      filetype = "blade",
    }
    require 'nvim-treesitter.configs'.setup {
      ensure_installed = ensure_installed,
      sync_install = false,
      ignore_install = { "phpdoc", "tflint",  "tla", "tla+", "tlaplus" },
      highlight = {
        enable = true,
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
        disable = { "xml", "blade", "php" },
      },
      rainbow = {
        enable = true,
      },
    }
  end,
}

return M
