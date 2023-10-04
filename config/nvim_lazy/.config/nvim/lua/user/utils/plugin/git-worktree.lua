if os.getenv('OS') == "Windows_NT" then return end

require("telescope").load_extension("git_worktree")
local worktree_ok, worktree = pcall(require, "git_worktree")
if not worktree_ok then
  return
end

worktree.setup({})


worktree.on_tree_change(function(op, metadata)
  if op == worktree.Operations.Switch then
    print("Switched from " .. metadata.prev_path .. " to " .. metadata.path)
  end
end)
