local status_ok, treesitter = pcall(require, "nvim-treesitter.configs")
if status_ok then
  treesitter.setup {
    ensure_installed = {
      "c", "lua", "php", "javascript", "svelte", "vim", "vimdoc", "query", "typescript",
      "astro", "bash", "cairo", "cmake", "comment", "commonlisp", "cpp", "css", "dart",
      "diff", "dockerfile", "fish", "git_config", "git_rebase", "gitattributes", "gitcommit",
      "gitignore", "go", "gomod", "gosum", "gowork", "gpg", "graphql", "haskell", "html",
      "htmldjango", "http", "ini", "java", "json", "jsdoc", "jq", "luadoc", "make", "ninja",
      "nix", "prisma", "pug", "python", "rust", "scss", "sql", "ssh_config", "sxhkdrc",
      "toml", "tsx", "vue", "xml", "yaml"
    },
    sync_install = true,
    ignore_install = { "phpdoc", "tflint", "markdown", "markdown_inline", "tla", "tla+", "tlaplus" },
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
      disable = { "xml" },
    },
    rainbow = {
      enable = true,
    },
  }
end
