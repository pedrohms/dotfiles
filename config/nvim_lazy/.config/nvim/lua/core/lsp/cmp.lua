local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
  return
end

local snip_vscode_status_ok, luasnip_vscode = pcall(require, "luasnip.loaders.from_vscode")
if not snip_vscode_status_ok then
  return
end

local snippets_paths = function()
  local plugins = { "friendly-snippets" }
  local paths = {}
  local path
  local root_path = vim.fn.stdpath "data" .. "/site/pack/packer/start/"
  for _, plug in ipairs(plugins) do
    path = root_path .. plug
    if vim.fn.isdirectory(path) ~= 0 then
      table.insert(paths, path)
    end
  end
  return paths
end

luasnip_vscode.lazy_load({
  paths = snippets_paths(),
  include = nil, -- Load all languages
  exclude = { "pug" },
})

local check_backspace = function()
  local col = vim.fn.col(".") - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

local source_icons = {
  nvim_lsp = "[lsp]",
  nvim_lua = "[lua]",
  luasnip = "[luasnip]",
  buffer = "[buffer]",
  path = "[path]",
  emoji = "[emoji]",
}

-- local kind_icons = {
--   Text = "",
--   Method = "",
--   Function = "",
--   Constructor = "",
--   Field = "",
--   Variable = "",
--   Class = "",
--   Interface = "",
--   Module = "",
--   Property = "",
--   Unit = "",
--   Value = "",
--   Enum = "",
--   Keyword = "",
--   Snippet = "",
--   Color = "",
--   File = "",
--   Reference = "",
--   Folder = "",
--   EnumMember = "",
--   Constant = "",
--   Struct = "",
--   Event = "",
--   Operator = "",
--   TypeParameter = "",
-- }

local kind_icons = {
  Text = "Text",
  Method = "Method",
  Function = "Function",
  Constructor = "Constructor",
  Field = "Field",
  Variable = "Variable",
  Class = "Class",
  Interface = "Interface",
  Module = "Module",
  Property = "Property",
  Unit = "Unit",
  Value = "Value",
  Enum = "Enum",
  Keyword = "Keyword",
  Snippet = "Snippet",
  Color = "Color",
  File = "File",
  Reference = "Reference",
  Folder = "Folder",
  EnumMember = "EnumMember",
  Constant = "Constant",
  Struct = "Struct",
  Event = "Event",
  Operator = "Operator",
  TypeParameter = "TypeParametr",
}

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body) -- For `luasnip` users.
    end,
  },

  mapping = cmp.mapping.preset.insert({
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<C-e>"] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    -- Accept currently selected item. If none selected, `select` first item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expandable() then
        luasnip.expand()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif check_backspace() then
        fallback()
      else
        fallback()
      end
    end, {
    "i",
    "s",
  }),
  ["<S-Tab>"] = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_prev_item()
    elseif luasnip.jumpable(-1) then
      luasnip.jump(-1)
    else
      fallback()
    end
  end, {
  "i",
  "s",
}),
  }),
  formatting = {
    -- fields = { "kind", "abbr", "menu" },
    fields = { "abbr", "menu", "kind" },
    format = function(entry, vim_item)
    --   vim_item.kind = kind_icons[vim_item.kind]
    --   vim_item.menu = ({
    --     nvim_lsp = "",
    --     nvim_lua = "",
    --     luasnip = "",
    --     buffer = "",
    --     path = "",
    --     emoji = "",
    --   })[entry.source.name]
      vim_item.kind = source_icons[entry.source.name] .. " " .. kind_icons[vim_item.kind] .. " "
      vim_item.menu = ""
      vim_item.abbr = string.sub(vim_item.abbr, 1, 50)
      return vim_item
    end,
  },
  sources = {
    {
      name = "nvim_lsp",
      async = true,
      max_view_entries = 60,
    },
    { name = "nvim_lua" },
    { name = "luasnip" },
    {
      name = "buffer",
      async = true,
      max_view_entries = 600,
    },
    { name = "path" }
    -- { name = "copilot"}
  },
  performance = {
    async_budget = 100000,
    fetching_timeout = 50,
  },
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  experimental = {
    ghost_text = true,
  },
  completion = {
    completeopt = "menu,menuone,preview,noselect",
  },
})
