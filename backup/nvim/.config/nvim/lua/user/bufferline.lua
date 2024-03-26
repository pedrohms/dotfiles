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

  vim.g.transparent_groups = vim.list_extend(
    vim.g.transparent_groups or {},
    vim.tbl_map(function(v)
      return v.hl_group
    end, vim.tbl_values(require('bufferline.config').highlights))
  )
end
