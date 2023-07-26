-- local onedarker_ok, onedarker  = pcall(require, "onedarker")
-- if onedarker_ok then
--   onedarker.setup({
--     transparent = true
--   }) 
--   onedarker.load()
-- else 
  vim.cmd [[ colorscheme onedarker ]]
-- end

local status_ok, comment = pcall(require, "Comment")
if status_ok then
  comment.setup()
end

local telescope = require("telescope")
local notify_ok, notify = pcall(require, "notify")
if notify_ok then
  telescope.load_extension("notify")
end

vim.api.nvim_set_hl(0, 'EyelinerPrimary', { fg = '#ff00ff', bold = true, underline = false })
vim.api.nvim_set_hl(0, 'EyelinerSecondary', { fg = '#00ffff', underline = false })
