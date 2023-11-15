if os.getenv("NVIM_FULL") == "1" then
  require "user"
  require "core.keymap"
  require "user.utils.plugin.gitsigns"
  return
end

require "minimal"
