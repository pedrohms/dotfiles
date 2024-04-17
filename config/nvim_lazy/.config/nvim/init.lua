if os.getenv("NVIM_FULL") == "1" then
  require "user"
  require "core.keymap"
  require "user.utils.plugin.gitsigns"
  return
end

require "minimal"

vim.cmd [[autocmd FileType markdown setlocal wrap spell]]
vim.cmd [[autocmd FileType markdown setlocal spell]]
vim.cmd [[autocmd FileType markdown setlocal spell spelllang=pt_br]]
vim.cmd [[autocmd FileType org setlocal wrap spell]]
vim.cmd [[autocmd FileType org setlocal spell]]
vim.cmd [[autocmd FileType org setlocal spell spelllang=pt_br]]
