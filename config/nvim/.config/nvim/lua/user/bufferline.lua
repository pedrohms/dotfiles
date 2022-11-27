local status_ok, bufferline = pcall(require, "bufferline")
if status_ok and os.getenv('OS') == "Windows_NT" then
  vim.opt.termguicolors = true
  bufferline.setup {
    options = {
      offsets = {
        {
          filetype = "NvimTree",
          text = "",
          padding = 1
        }
      },
      show_close_icon = false
    }
  }
end
