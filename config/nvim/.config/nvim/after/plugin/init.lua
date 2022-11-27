vim.cmd [[ colorscheme onedarker ]]

local status_ok, comment = pcall(require, "Comment")
if status_ok then
    comment.setup()
end

require("telescope").load_extension("notify")

vim.api.nvim_set_hl(0, 'EyelinerPrimary', { fg='#ff00ff', bold = true, underline = false })
vim.api.nvim_set_hl(0, 'EyelinerSecondary', { fg='#00ffff', underline = false })
