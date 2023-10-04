pcall(require, "luarocks.loader")
local awful = require("awful")
require("awful.autofocus")
local beautiful = require("beautiful")
local theme = require("themes.default.theme")

beautiful.init(os.getenv("HOME") .. "/.config/awesome/themes/default/theme.lua")

modkey = "Mod4"

require("signals")

-- {{{ Mouse bindings
awful.mouse.append_global_mousebindings({
    awful.button({ }, 4, awful.tag.viewprev),
    awful.button({ }, 5, awful.tag.viewnext),
})
-- }}} Mouse bindings


awful.screen.connect_for_each_screen(function(s) require("mywibox").initializeWibox(s, theme) end)

require("keybinds")

require("rules")

require("startup")
