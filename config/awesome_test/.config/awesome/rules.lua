local awful = require("awful")
local gears = require("gears") --Utilities such as color parsing and objects

local beautiful = require("beautiful")

-- local keys = require("keybinds")
-- Rules to apply to new clients (through the "manage" signal).


local clientbuttons = gears.table.join(
  awful.button({}, 1, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
  end),
  awful.button({ modkey }, 1, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
    awful.mouse.client.move(c)
  end),
  awful.button({ modkey }, 3, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
    awful.mouse.client.resize(c)
  end)
)



awful.rules.rules = {

  { rule_any = {floating = true},
    properties = {placement = awful.placement.centered}
  },
  -- All clients will match this rule.
  { rule = {},
    properties = { border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      focus = awful.client.focus.filter,
      raise = true,
      buttons = clientbuttons,
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap + awful.placement.no_offscreen,
      size_hints_honor = false
    }
  },

  -- Titlebars
  { rule_any = { type = { "dialog", "normal" } },
    properties = { titlebars_enabled = false } },

  { rule = { class = "Gimp*", role = "gimp-image-window" },
    properties = { maximized = true } },

  { rule = { class = "inkscape" },
    properties = { maximized = true } },

  { rule = { class = "Vlc" },
    properties = { maximized = true } },

  { rule = { class = "VirtualBox Manager" },
    properties = { maximized = true } },

  { rule = { class = "VirtualBox Machine" },
    properties = { maximized = true } },

  { rule = { class = "Xfce4-settings-manager" },
    properties = { floating = false } },

  -- { rule = { class = "scratchpad", role = "scratchpad" },
  --   properties = { floating = true } },


  -- Floating clients.
  { rule_any = {
    instance = {
      "DTA", -- Firefox addon DownThemAll.
      "copyq", -- Includes session name in class.
    },
    class = {
      "Arandr",
      "Blueberry",
      "Galculator",
      "Gnome-font-viewer",
      "Gpick",
      "Imagewriter",
      "Font-manager",
      "Kruler",
      "MessageWin", -- kalarm.
      "Oblogout",
      "Peek",
      "Skype",
      "System-config-printer.py",
      "Sxiv",
      "Unetbootin.elf",
      "Wpa_gui",
      "pinentry",
      "veromix",
      "xtightvncviewer"
    },

    name = {
      "Event Tester", -- xev.
    },
    role = {
      "AlarmWindow", -- Thunderbird's calendar.
      "pop-up", -- e.g. Google Chrome's (detached) Developer Tools.
      "Preferences",
      "setup",
    }
  }, properties = { floating = true } },

}
