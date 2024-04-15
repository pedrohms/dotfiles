local keymap = require("core.utils.keymap")
local nopreview_ok, nopreview = pcall( require, "telescope.themes")
if nopreview_ok then
  nopreview.get_dropdown { previewer = false }
end
local silent = { silent = true }

keymap.nnoremap("d", "\"0d")
keymap.vnoremap("d", "\"0d")
keymap.xnoremap("d", "\"0d")
keymap.nnoremap("D", "\"0D")
keymap.vnoremap("D", "\"0D")
keymap.xnoremap("D", "\"0D")

keymap.nnoremap("dd", "\"0dd")
keymap.vnoremap("dd", "\"0dd")
keymap.xnoremap("dd", "\"0dd")

keymap.nnoremap("yy", "\"0yy")
keymap.vnoremap("yy", "\"0yy")
keymap.xnoremap("yy", "\"0yy")

keymap.nnoremap("p", "\"0p")
keymap.vnoremap("p", "\"0p")
keymap.xnoremap("p", "\"0p")
keymap.nnoremap("P", "\"0P")
keymap.vnoremap("P", "\"0P")
keymap.xnoremap("P", "\"0P")

keymap.nnoremap("y", "\"0y")
keymap.vnoremap("y", "\"0y")
keymap.xnoremap("y", "\"0y")
keymap.nnoremap("Y", "\"0Y")
keymap.vnoremap("Y", "\"0Y")
keymap.xnoremap("Y", "\"0Y")

keymap.vnoremap("<leader>cc", "\"+y")
keymap.xnoremap("<leader>cc", "\"+y")

keymap.vnoremap("<leader>cv", "\"+p")
keymap.nnoremap("<leader>cv", "\"+p")
keymap.xnoremap("<leader>cv", "\"+p")

keymap.nnoremap("<leader>qq", ":qa<CR>")
keymap.nnoremap("<leader>qa", ":qa!<CR>")
keymap.nnoremap("<leader>qw", ":wqa<CR>")
keymap.nnoremap("<C-s>", ":w<CR>")

keymap.inoremap("<C-s>", "<Esc>:w<CR>a")
-- Better window navigation
keymap.nnoremap("<C-h>", "<C-w>h")
keymap.nnoremap("<C-j>", "<C-w>j")
keymap.nnoremap("<C-k>", "<C-w>k")
keymap.nnoremap("<C-l>", "<C-w>l")
keymap.nnoremap("<C-Up>", ":resize -2<CR>")
keymap.nnoremap("<C-Down>", ":resize +2<CR>")
keymap.nnoremap("<C-Left>", ":vertical resize -2<CR>")
keymap.nnoremap("<C-Right>", ":vertical resize +2<CR>")

keymap.nnoremap("<C-A-k>", ":resize -2<CR>")
keymap.nnoremap("<C-A-j>", ":resize +2<CR>")
keymap.nnoremap("<C-A-h>", ":vertical resize -2<CR>")
keymap.nnoremap("<C-A-l>", ":vertical resize +2<CR>")

keymap.inoremap("jk", "<Esc>")
keymap.inoremap("<A-j>", "<Esc>:m .+1<CR>==$A")
keymap.inoremap("<A-k>", "<Esc>:m .-2<CR>==$A")
keymap.nnoremap("<A-k>", ":m .-2<CR>==")
keymap.nnoremap("<A-j>", ":m .+1<CR>==")
keymap.xnoremap("<A-j>", ":move '>+1<CR>gv-gv")
keymap.xnoremap("<A-k>", ":move '<-2<CR>gv-gv")
keymap.vnoremap("<", "<gv")
keymap.vnoremap(">", ">gv")

keymap.nnoremap("<S-l>", ":bnext<CR>")
keymap.nnoremap("<S-h>", ":bprevious<CR>")

keymap.nnoremap("<leader>bc", "<cmd>Bdelete!<CR>")
keymap.nnoremap("<leader>sh", "<cmd>nohlsearch<cr>")


-- Telescope
-- Telescope find_files find_command=rg,--ignore,--hidden,--files,-L
local telescope_ok, _ = pcall( require, "telescope" )
if telescope_ok then
  keymap.nnoremap("<leader>sf", function()
    require("telescope.builtin").find_files(
      { find_command = { "rg", "--ignore", "--hidden", "--files", "-L" }, previewer = false })
  end)
  keymap.nnoremap("<leader>sF", function()
    require("telescope.builtin").git_files(
      { find_command = { "rg", "--ignore", "--hidden", "--files", "-L" }, previewer = false })
  end)
  keymap.nnoremap("<leader>sp", "<cmd>Telescope projects<CR>")
  keymap.nnoremap("<leader>sg", function() 
    require("telescope.builtin").live_grep({ find_command = { "rg", "--ignore", "--hidden", "--text", "-L" } })
  end)
  keymap.nnoremap("<leader>sk", "<cmd>Telescope keymaps<CR>")
  keymap.nnoremap("<leader>sc", "<cmd>Telescope commands<CR>")
  if nopreview_ok then
    keymap.nnoremap("<leader>sb", function() require("telescope.builtin").buffers(nopreview) end)
  end
end
-- keymap.nnoremap("<leader>srp", function() require('spectre').open_visual({ select_word = true }) end)
-- keymap.nnoremap("<leader>srr", function() require('spectre').open_file_search() end)

local nvim_tree_ok, _ = pcall(require, "nvim-tree")
if nvim_tree_ok then
  keymap.nnoremap("<leader>e", ":NvimTreeToggle<CR>")
else
  keymap.nnoremap("<leader>e", ":Lexplore<CR>")
end

-- Bookmark
keymap.nnoremap("<leader>mm", "<cmd>BookmarkToggle<CR>")
keymap.nnoremap("<leader>mn", "<cmd>BookmarkNext<CR>")
keymap.nnoremap("<leader>mp", "<cmd>BookmarkPrev<CR>")
keymap.nnoremap("<leader>mca", "<cmd>BookmarkClearAll<CR>")
keymap.nnoremap("<leader>ma", function() require("telescope").extensions.vim_bookmarks.all() end)
keymap.nnoremap("<leader>mf", function() require("telescope").extensions.vim_bookmarks.current_file(nopreview) end)

-- Git
keymap.nnoremap("<leader>gwt", function() require('telescope').extensions.git_worktree.git_worktrees() end)
keymap.nnoremap("<leader>gwtc", function() require('telescope').extensions.git_worktree.create_git_worktree() end)
keymap.nnoremap("<leader>gg", "<cmd>Neogit<CR>")
keymap.nnoremap("<leader>gnh", function() require('gitsigns').next_hunk() end)
keymap.nnoremap("<leader>gph", function() require('gitsigns').prev_hunk() end)
keymap.nnoremap("<leader>gvh", function() require('gitsigns').preview_hunk() end)
keymap.nnoremap("<leader>gts", "<cmd>Telescope git_status<CR>")
keymap.nnoremap("<leader>gtc", "<cmd>Telescope git_commits<CR>")
keymap.nnoremap("<leader>gtb", "<cmd>Telescope git_branches<CR>")
keymap.nnoremap("<leader>gdv", "<cmd>DiffviewFileHistory<CR>")
keymap.nnoremap("<leader>gdc", "<cmd>DiffviewClose<CR>")
