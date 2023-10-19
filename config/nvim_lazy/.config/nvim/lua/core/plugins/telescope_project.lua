
local M = {
  'nvim-telescope/telescope-project.nvim',
  dependencies = {
    'nvim-telescope/telescope.nvim'
  },
  init = function ()
    require'telescope'.load_extension('project')
  end
}

return M
