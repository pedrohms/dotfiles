local status_ok, treesitter = pcall(require, "nvim-treesitter.configs")
-- local status_ctx_ok, treesitter_ctx = pcall(require, "tree-sitter-context")
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
      disable = { "xml" },
    },
    rainbow = {
      enable = true,
    },
  }
end

-- if status_ctx_ok then
--   treesitter_ctx.setup {
--     enable = true,          -- Enable this plugin (Can be enabled/disabled later via commands)
--     max_lines = 0,          -- How many lines the window should span. Values <= 0 mean no limit.
--     min_window_height = 0,  -- Minimum editor window height to enable context. Values <= 0 mean no limit.
--     line_numbers = true,
--     multiline_threshold = 20, -- Maximum number of lines to show for a single context
--     trim_scope = 'outer',   -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
--     mode = 'cursor',        -- Line used to calculate context. Choices: 'cursor', 'topline'
--     -- Separator between context and content. Should be a single character string, like '-'.
--     -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
--     separator = nil,
--     zindex = 20,   -- The Z-index of the context window
--     on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
--   }
-- end
