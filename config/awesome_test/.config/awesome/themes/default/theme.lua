local theme_assets = require("beautiful.theme_assets")
local dpi = require("beautiful.xresources").apply_dpi
local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()
local gtk = require("beautiful.gtk")

-- inherit xresources theme:
local theme = dofile(themes_path.."xresources/theme.lua")
-- load and prepare for use gtk theme:
theme.gtk = gtk.get_theme_variables()
if not theme.gtk then
    local gears_debug = require("gears.debug")
    gears_debug.print_warning("Can't load GTK+3 theme. Using 'xresources' theme as a fallback.")
    return theme
end
theme.wibar_bg      = theme.gtk.menubar_bg_color
theme.wibar_fg      = theme.gtk.menubar_fg_color

theme = theme_assets.recolor_layout(theme, theme.wibar_fg)
theme.icon_dir                                  = os.getenv("HOME") .. "/.config/awesome/themes/holo/icons"
theme.wallpaper                                 = os.getenv("HOME") .. "/.local/wall/0001.jpg"
theme.font                                      = "Roboto Bold 10"
theme.taglist_font                              = "Roboto Condensed Regular 10"
theme.fg_normal                                 = "#FFFFFF"
theme.fg_focus                                  = "#0099CC"
theme.bg_focus                                  = "#303030"
theme.bg_normal                                 = "#242424"
theme.fg_urgent                                 = "#CC9393"
theme.bg_urgent                                 = "#006B8E"
theme.border_width                              = dpi(3)
theme.border_normal                             = "#252525"
theme.border_focus                              = "#0099CC"
theme.taglist_fg_focus                          = "#FFFFFF"
theme.tasklist_bg_normal                        = "#222222"
theme.tasklist_fg_focus                         = "#4CB7DB"
theme.menu_height                               = dpi(24)
theme.menu_width                                = dpi(150)
theme.menu_icon_size                            = dpi(32)

return theme
