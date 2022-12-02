require("user.lsp.null-ls")
require("flutter-tools").setup{}

local Remap = require("user.keymap")
local nnoremap = Remap.nnoremap
local inoremap = Remap.inoremap
local vnoremap = Remap.vnoremap

nnoremap("gd", function() vim.lsp.buf.definition() end)
nnoremap("K", function() vim.lsp.buf.hover() end)
nnoremap("<leader>lws", function() vim.lsp.buf.workspace_symbol() end)
nnoremap("<leader>ld", function() vim.diagnostic.open_float() end)
nnoremap("[d", function() vim.diagnostic.goto_next() end)
nnoremap("]d", function() vim.diagnostic.goto_prev() end)
nnoremap("<leader>lca", function() vim.lsp.buf.code_action() end)
nnoremap("<leader>lrf", function() vim.lsp.buf.references() end)
nnoremap("<leader>lrn", function() vim.lsp.buf.rename() end)
inoremap("<C-h>", function() vim.lsp.buf.signature_help() end)
inoremap("<C-K>", function() vim.lsp.buf.hover() end)
-- nnoremap("<leader>lds", "<cmd>Telescope lsp_document_symbols<cr>")
nnoremap("<leader>lsf", function() require("telescope.builtin").lsp_document_symbols(require("telescope.themes")
    .get_dropdown { previewer = false })
end)
-- if vim.lsp.buf["format"] == nil then
--   nnoremap("<leader>lf", function() vim.lsp.buf.formatting() end)
-- else
nnoremap("<leader>lf", function() vim.lsp.buf.format { async = true } end)
vnoremap("<leader>lrf", function() vim.lsp.buf.range_formatting() end)
