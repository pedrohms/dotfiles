local status_ok, treesitter = pcall(require, "nvim-treesitter.configs")
if status_ok then
  treesitter.setup {
    ensure_installed = "all",
    sync_install = false,
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
      filetypes = {
        'html', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'svelte', 'vue', 'tsx', 'jsx',
        'rescript',
        'xml',
        'markdown',
        'astro', 'glimmer', 'handlebars', 'hbs'
      },
    }
  }
end
