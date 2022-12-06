local bling_ok, bling = pcall(require, "bling")

if not bling_ok then
  return nil
end

bling.module.wallpaper.setup({
  wallpaper = { os.getenv("HOME") .. "/.local/wall/0001.jpg" },
  screen = screen
})

