local status_ok, telescope = pcall(require, "telescope")
if status_ok then
    telescope.load_extension("vim_bookmarks")
end
vim.g.bookmark_no_default_key_mappings = 1
vim.g.bookmark_auto_save = 1
vim.g.bookmark_auto_close = 0
vim.g.bookmark_manage_per_buffer = 0
vim.g.bookmark_save_per_working_dir = 0
vim.g.bookmark_highlight_lines = 0
vim.g.bookmark_show_warning = 0
vim.g.bookmark_center = 1
vim.g.bookmark_location_list = 0
vim.g.bookmark_disable_ctrlp = 1
vim.g.bookmark_display_annotation = 0
vim.g.bookmark_auto_save_file = vim.fn.stdpath "data" .. '/bookmarks'
