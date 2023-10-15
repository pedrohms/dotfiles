local awful = require("awful")
local naughty = require("naughty")
local ruled = require("ruled")
local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears") --Utilities such as color parsing and objects


-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
naughty.connect_signal("request::display_error", function(message, startup)
  naughty.notification {
    urgency = "critical",
    title   = "Oops, an error happened" .. (startup and " during startup!" or "!"),
    message = message
  }
end)
-- }}}

tag.connect_signal("request::default_layouts", function()
  awful.layout.append_default_layouts({
    awful.layout.suit.tile,
    awful.layout.suit.max,
    awful.layout.suit.floating,
    awful.layout.suit.magnifier,
    awful.layout.suit.corner.nw,
  })
end)

tag.connect_signal("property::layout", function(t)
  local c = client.focus
  if c ~= nil then
    if t.layout == awful.layout.suit.max then
      c.border_width = 0
    else
      if #awful.screen.focused().clients > 1 then
        c.border_width = beautiful.border_width
        c.border_color = beautiful.border_focus
      else
        c.border_width = 0
    end
    end
  end
end)

-- }}}

-- {{{ Wallpaper
screen.connect_signal("request::wallpaper", function(s)
  awful.wallpaper {
    screen = s,
    widget = {
      {
        image     = beautiful.wallpaper,
        upscale   = true,
        downscale = true,
        widget    = wibox.widget.imagebox,
      },
      valign = "center",
      halign = "center",
      tiled  = false,
      widget = wibox.container.tile,
    }
  }
end)
-- }}}


-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
  c:activate { context = "mouse_enter", raise = false }
end)


-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", function(s)
  -- Wallpaper
  if beautiful.wallpaper then
    local wallpaper = beautiful.wallpaper
    -- If wallpaper is a function, call it with the screen
    if type(wallpaper) == "function" then
      wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)
  end
end)

local function border_adjust(c)
  if c.maximized then -- no borders if only 1 client visible
    c.border_width = 0
  elseif #awful.screen.focused().clients > 1 then
    c.border_width = beautiful.border_width
    c.border_color = beautiful.border_focus
  end
end

client.connect_signal("focus",
  function(c)
    if awful.screen.focused().selected_tag.layout == awful.layout.suit.max then
      c.border_width = 0
    elseif c.maximized then  -- no borders if only 1 client visible
      c.border_width = 0
    elseif #awful.screen.focused().clients > 1 then
      c.border_width = beautiful.border_width
      c.border_color = beautiful.border_focus
    end
  end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
client.connect_signal("property::maximized", border_adjust)

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)
