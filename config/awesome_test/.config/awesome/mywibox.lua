local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears") --Utilities such as color parsing and objects

local mywibox = {}
mywibox.initializeWibox = function(s, theme)


  local wallpaper = theme.wallpaper
  if type(wallpaper) == "function" then
      wallpaper = wallpaper(s)
  end
  gears.wallpaper.maximized(wallpaper, s, true)

  awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

  local buttonsOnTagClick = {
    awful.button({}, 1, function(t) t:view_only() end),
    awful.button({ modkey }, 1, function(t)
      if client.focus then
        client.focus:move_to_tag(t)
      end
    end),
    awful.button({}, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, function(t)
      if client.focus then
        client.focus:toggle_tag(t)
      end
    end),
    awful.button({}, 4, function(t) awful.tag.viewprev(t.screen) end),
    awful.button({}, 5, function(t) awful.tag.viewnext(t.screen) end),
  }
  local buttonsOnTaskClick = {
    awful.button({}, 1, function(c)
      c:activate { context = "tasklist", action = "toggle_minimization" }
    end),
    awful.button({}, 3, function() awful.menu.client_list { theme = { width = 250 } } end),
    awful.button({}, 4, function() awful.client.focus.byidx(-1) end),
    awful.button({}, 5, function() awful.client.focus.byidx(1) end),
  }

  s.mypromptbox = awful.widget.prompt()

  s.mylayoutbox = awful.widget.layoutbox {
    screen = s,
  }

  -- Create a taglist widget
  s.mytaglist = awful.widget.taglist {
    screen  = s,
    filter  = awful.widget.taglist.filter.all,
    buttons = buttonsOnTagClick
  }

  -- Create a tasklist widget
  s.mytasklist = awful.widget.tasklist {
    screen  = s,
    filter  = awful.widget.tasklist.filter.currenttags,
    buttons = buttonsOnTaskClick
  }

  -- Create the wibox
  s.mywibox = awful.wibar {
    position = "top",
    screen   = s,
    widget   = {
      layout = wibox.layout.align.horizontal,
      {   -- Left widgets
        layout = wibox.layout.fixed.horizontal,
        s.mytaglist,
        s.mypromptbox,
      },
      s.mytasklist,   -- Middle widget
      {               -- Right widgets
        layout = wibox.layout.fixed.horizontal,
        wibox.widget.systray(),
        mytextclock,
        s.mylayoutbox,
      },
    }
  }
end

return mywibox
