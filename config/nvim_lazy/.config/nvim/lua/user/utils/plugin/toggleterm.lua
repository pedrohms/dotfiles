local ok, _ = pcall(require, "toggleterm")
if ok then
  local terminal_ok, terminal = pcall(require, "user.terminal")
  if terminal_ok then
    terminal.config()
    terminal.setup()
  end
end
