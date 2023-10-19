local M = {
  'nvim-tree/nvim-tree.lua',
  dependencies = {
    'nvim-tree/nvim-web-devicons'
  },
  init = function()
    local status_ok, nvimtree = pcall(require, "nvim-tree")
    if status_ok then
      nvimtree.setup({
        auto_reload_on_write = true,
        view = {
          width = 30,
          side = "left",
          number = true,
          relativenumber = true,
        },
        filters = {
          dotfiles = true,
        },
        actions = {
          open_file = {
            quit_on_open = true,
          }
        },
        update_focused_file = {
          enable = true,
          update_cwd = true
        },
        renderer = {
          add_trailing = false,
          group_empty = false,
          highlight_git = false,
          full_name = false,
          highlight_opened_files = "none",
          highlight_modified = "none",
          root_folder_label = ":~:s?$?/..?",
          indent_width = 2,

          indent_markers = {
            enable = true, -- enables the tree like line
            inline_arrows = true,
            icons = {
              corner = "└",
              edge = "│",
              item = "│",
              bottom = "─",
              none = " ",
            },
          },

          icons = {
            webdev_colors = true,
            git_placement = "before",
            modified_placement = "after",
            padding = " ",
            symlink_arrow = " ➛ ",
            show = {
              file = true,
              folder = true,
              folder_arrow = true,
              git = true,
              modified = true,
            },

            glyphs = {
              default = "",
              symlink = "",
              bookmark = "",
              modified = "●",
              folder = {
                arrow_closed = "",
                arrow_open = "",
                default = "",
                open = "",
                empty = "",
                empty_open = "",
                symlink = "",
                symlink_open = "",
              },

              git = {
                unstaged = "✗",
                staged = "✓",
                unmerged = "",
                renamed = "➜",
                untracked = "★",
                deleted = "",
                ignored = "◌",
              },
            },
          }, -- end of icons rendering

          special_files = {
            "Cargo.toml",
            "Makefile",
            "README.md",
            "readme.md",
          },
          symlink_destination = true,
        }, -- end of rendering

        ui = {
          confirm = {
            remove = true,
            trash = true,
          },
        },
      })
    end
  end
}

return M
