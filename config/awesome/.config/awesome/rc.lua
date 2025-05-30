local awesome, client, mouse, screen, tag = awesome, client, mouse, screen, tag
local ipairs, string, os, table, tostring, tonumber, type = ipairs, string, os, table, tostring, tonumber, type

local utils = require("lib.utils")
local awful = require("awful") --Everything related to window managment
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
local gears = require("gears") --Utilities such as color parsing and objects

-- Theme handling library
local beautiful = require("beautiful")

-- Notification library
local naughty                        = require("naughty")
naughty.config.defaults['icon_size'] = 100

local lain        = require("lain")

local scratch = require("lib.scratch")
-- local freedesktop = require("freedesktop")

-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
local hotkeys_popup = require("awful.hotkeys_popup").widget
require("awful.hotkeys_popup.keys")
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility

if awesome.startup_errors then
  naughty.notify({ preset = naughty.config.presets.critical,
    title = "Oops, there were errors during startup!",
    text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
  local in_error = false
  awesome.connect_signal("debug::error", function(err)
    -- Make sure we don't go into an endless error loop
    if in_error then return end
    in_error = true

    naughty.notify({ preset = naughty.config.presets.critical,
      title = "Oops, an error happened!",
      text = tostring(err) })
    in_error = false
  end)
end

local function run_once(cmd_arr)
  for _, cmd in ipairs(cmd_arr) do
    awful.spawn.with_shell(string.format("pgrep -u $USER -fx '%s' > /dev/null || (%s)", cmd, cmd))
  end
end

run_once({ "unclutter -root" }) -- entries must be comma-separated

local themes = {
  "holo",
}

-- choose your theme here
local chosen_theme = themes[1]
local theme_path = string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), chosen_theme)
beautiful.init(theme_path)

-- local bling = require("bling")
-- local rubato = require("rubato")

local modkey      = "Mod4"
local altkey      = "Mod1"
local ctrlkey     = "Control"
local terminal    = "alacritty"
local browser     = "brave"
if os.getenv("USER") == "framework" then
  browser = "brave-browser"
end
local chrome      = "google-chrome-stable"
-- local browser     = "nvidia-offload vivaldi"
local editor      = "nvim"
local mediaplayer = "mpv"

if os.getenv("PH_NVIDIA") == "2" then
  browser = "nvidia-offload brave"
  chrome  = "nvidia-offload google-chrome-stable"
end

-- Example: Toggle between default sink and speakers
local device1 = "pactl set-default-sink alsa_output.pci-0000_01_00.1.hdmi-stereo"
local device2 = "pactl set-default-sink alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__Speaker__sink; \
                 pactl set-default-sink alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__Headphones__sink"
--local deviceHeadphone = "pactl set-default-sink alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__Headphones__sink"

-- local anim_y = rubato.timed {
--     pos = 1090,
--     rate = 60,
--     easing = rubato.quadratic,
--     intro = 0.1,
--     duration = 0.3,
--     awestore_compat = true -- This option must be set to true.
-- }
--
-- local anim_x = rubato.timed {
--     pos = -970,
--     rate = 60,
--     easing = rubato.quadratic,
--     intro = 0.1,
--     duration = 0.3,
--     awestore_compat = true -- This option must be set to true.
-- }

-- local term_scratch = bling.module.scratchpad {
--     command = "alacritty --class spad -e tmux",           -- How to spawn the scratchpad
--     rule = { instance = "spad" },                     -- The rule that the scratchpad will be searched by
--     sticky = true,                                    -- Whether the scratchpad should be sticky
--     autoclose = true,                                 -- Whether it should hide itself when losing focus
--     floating = true,                                  -- Whether it should be floating (MUST BE TRUE FOR ANIMATIONS)
--     geometry = {x=160, y=40, height=800, width=1100}, -- The geometry in a floating state
--     reapply = true,                                   -- Whether all those properties should be reapplied on every new opening of the scratchpad (MUST BE TRUE FOR ANIMATIONS)
--     dont_focus_before_close  = false,                 -- When set to true, the scratchpad will be closed by the toggle function regardless of whether its focused or not. When set to false, the toggle function will first bring the scratchpad into focus and only close it on a second call
--     rubato = {x = anim_x, y = anim_y}                 -- Optional. This is how you can pass in the rubato tables for animations. If you don't want animations, you can ignore this option.
-- }

-- awesome variables
awful.util.terminal = terminal
-- awful.util.tagnames = {  " ", " ", " ", " ", " ", " ", " ", " ", " ", " "  }
-- awful.util.tagnames = { " DEV ", " WWW ", " SYS ", " DOC ", " VBOX ", " CHAT ", " MUS ", " VID ", " GFX " }
awful.util.tagnames = { " 1", " 2", " 3", " 4", " 5", " 6", " 7", " 8", " 9" }
awful.layout.suit.tile.left.mirror = true
awful.layout.layouts = {
  awful.layout.suit.tile,
  awful.layout.suit.max,
  awful.layout.suit.floating,
  awful.layout.suit.magnifier,
  --awful.layout.suit.tile.left,
  --awful.layout.suit.tile.bottom,
  --awful.layout.suit.tile.top,
  --awful.layout.suit.fair,
  --awful.layout.suit.fair.horizontal,
  --awful.layout.suit.spiral,
  --awful.layout.suit.spiral.dwindle,
  --awful.layout.suit.max.fullscreen,
  --awful.layout.suit.corner.nw,
  --awful.layout.suit.corner.ne,
  --awful.layout.suit.corner.sw,
  --awful.layout.suit.corner.se,
  --lain.layout.cascade,
  --lain.layout.cascade.tile,
  --lain.layout.centerwork,
  --lain.layout.centerwork.horizontal,
  --lain.layout.termfair,
  --lain.layout.termfair.center,
}

awful.util.taglist_buttons = my_table.join(
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
  awful.button({}, 4, function(t) awful.tag.viewnext(t.screen) end),
  awful.button({}, 5, function(t) awful.tag.viewprev(t.screen) end)
)

awful.util.tasklist_buttons = my_table.join(
  awful.button({}, 1, function(c)
    if c == client.focus then
      c.minimized = true
    else
      c:emit_signal("request::activate", "tasklist", { raise = true })
    end
  end),
  awful.button({}, 3, function()
    local instance = nil

    return function()
      if instance and instance.wibox.visible then
        instance:hide()
        instance = nil
      else
        instance = awful.menu.clients({ theme = { width = 250 } })
      end
    end
  end),
  awful.button({}, 4, function() awful.client.focus.byidx(1) end),
  awful.button({}, 5, function() awful.client.focus.byidx(-1) end)
)

lain.layout.termfair.nmaster           = 3
lain.layout.termfair.ncol              = 1
lain.layout.termfair.center.nmaster    = 3
lain.layout.termfair.center.ncol       = 1
lain.layout.cascade.tile.offset_x      = 2
lain.layout.cascade.tile.offset_y      = 32
lain.layout.cascade.tile.extra_padding = 5
lain.layout.cascade.tile.nmaster       = 5
lain.layout.cascade.tile.ncol          = 2

beautiful.init(string.format(gears.filesystem.get_configuration_dir() .. "/themes/%s/theme.lua", chosen_theme))

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
-- Create a wibox for each screen and add it
awful.screen.connect_for_each_screen(function(s) beautiful.at_screen_connect(s) end)

root.buttons(my_table.join(
  -- awful.button({}, 3, function() awful.util.mymainmenu:toggle() end),
  awful.button({}, 4, awful.tag.viewnext),
  awful.button({}, 5, awful.tag.viewprev)
))

globalkeys = my_table.join(

  awful.key({ modkey, }, "[", function() scratch.toggle("alacritty --class scratch2,scratch2", utils.scratchRule("scratch2")) end),
  awful.key({ modkey, }, "]", function() scratch.toggle("alacritty --class scratch,scratch", utils.scratchRule("scratch")) end),
-- {{{ Personal keybindings
  -- awful.key({ modkey, ctrlkey }, "Return", function() if Term_scratch then Term_scratch:toggle() end end),
  -- awful.key({ modkey, "Shift" }, "w",
  --   function() awful.spawn.with_shell("scrot -u ~/scrot/%Y-%m-%d-@%H-%M-%S-scrot.png -e 'xclip -selection clipboard -target image/png -i $f'") end)
  -- ,
  -- Appplication
  awful.key({ modkey, "Shift" }, "a", function()
    local grabber
    grabber = awful.keygrabber.run(
      function(_, key, event)
        if event == "release" then return end
        if key == "f" then awful.spawn("pcmanfm")
        elseif key == "w" then awful.spawn.with_shell("remote-viewer spice://localhost:5900")
        elseif key == "v" then awful.spawn("virt-manager")
        elseif key == "o" then awful.util.spawn(os.getenv("HOME").."/.local/bin/dm-offload")
        end
        awful.keygrabber.stop(grabber)
      end)
  end),
  -- Develop IDEs
  awful.key({ modkey, "Ctrl" }, "d", function()
    local grabber
    grabber = awful.keygrabber.run(
      function(_, key, event)
        if event == "release" then return end
        if key == "v" then awful.spawn.with_shell(terminal .. " -e " .. editor)
        elseif key == "c" then awful.spawn.with_shell("$HOME/Applications/VSCode-linux-x64/bin/code")
        elseif key == "a" then awful.spawn.with_shell("$HOME/Applications/android-studio/bin/studio.sh")
        elseif key == "s" then awful.spawn.with_shell("$HOME/Applications/azuredatastudio-linux-x64/bin/azuredatastudio")
        end
        awful.keygrabber.stop(grabber)
      end)
  end),
  -- Screenshot
  awful.key({ modkey, "Ctrl" }, "s", function()
    local grabber
    grabber = awful.keygrabber.run(
      function(_, key, event)
        if event == "release" then return end
        if key == "s" then
          awful.spawn.with_shell("flameshot gui")
        end
        -- if key == "s" then awful.spawn.with_shell("scrot -s ~/scrot/%Y-%m-%d-@%H-%M-%S-scrot.png -e 'xclip -selection clipboard -target image/png -i $f'")
        -- elseif key == "w" then awful.spawn.with_shell("scrot -u ~/scrot/%Y-%m-%d-@%H-%M-%S-scrot.png -e 'xclip -selection clipboard -target image/png -i $f'")
        -- end
        awful.keygrabber.stop(grabber)
      end)
  end),
  -- Awesome keybindings
  awful.key({ modkey, }, "Return", function() awful.spawn.with_shell(terminal .. " -e tmux") end,
    { description = "Launch terminal", group = "awesome" }),

  awful.key({ modkey, "Shift" }, "F1", function ()
    os.execute(device1)
  end, { description = "Change audio device", group = "awesome" }),
  awful.key({ modkey, "Shift" }, "F2", function ()
    os.execute(device2)
  end, { description = "Change audio device", group = "awesome" }),
  awful.key({ modkey, "Shift" }, "F3", function ()
    os.execute(deviceHeadphone)
  end, { description = "Change audio device to headphone", group = "awesome" }),
  awful.key({ modkey, "Shift" }, "k", function()
    local grabber
    grabber = awful.keygrabber.run(
      function(_, key, event)
        if event == "release" then return end
        if key == "u" then awful.spawn.with_shell("setxkbmap -layout us -variant intl &")
        elseif key == "b" then awful.spawn.with_shell("setxkbmap -layout br -variant abnt2 &")
        end
        awful.keygrabber.stop(grabber)
      end)
  end , { description = "Change keyboard layout", group = "awesome" }),
  awful.key({ modkey, }, "b", function()
    local grabber
    grabber = awful.keygrabber.run(
      function(_, key, event)
        if event == "release" then return end
        if key == "b" then awful.spawn.with_shell(browser)
        elseif key == "c" then awful.spawn.with_shell(chrome)
        end
        awful.keygrabber.stop(grabber)
      end)
  end,
    { description = "Launch brave", group = "awesome" }),
  awful.key({ modkey, "Shift" }, "r", awesome.restart,
    { description = "Reload awesome", group = "awesome" }),
  awful.key({ modkey, "Shift" }, "q", function() awful.spawn.with_shell("bash "..os.getenv("HOME").."/.local/bin/dm-logout") end,
    { description = "Quit awesome", group = "awesome" }),
  awful.key({ modkey, }, "s", function() term_scratch:toggle() end,
    { description = "Show help", group = "awesome" }),
  -- awful.key({ modkey, "Shift" }, "w", function() awful.util.mymainmenu:show() end,
  --   { description = "Show main menu", group = "awesome" }),
  awful.key({ modkey, "Shift" }, "b", function()
    for s in screen do
      s.mywibox.visible = not s.mywibox.visible
      if s.mybottomwibox then
        s.mybottomwibox.visible = not s.mybottomwibox.visible
      end
    end
  end,
    { description = "Show/hide wibox (bar)", group = "awesome" }),

  -- Run launcher
  -- awful.key({ modkey, "Shift" }, "Return", function() awful.util.spawn(os.getenv("HOME").."/.config/rofi/launchers/type-6/launcher.sh") end,
  --   { description = "Run launcher", group = "hotkeys" }),
  awful.key({ modkey, "Shift" }, "Return", function() awful.util.spawn(os.getenv("HOME").."/.local/bin/dm-run") end,
    { description = "Run launcher", group = "hotkeys" }),

  -- Dmscripts (Super + p followed by KEY)
  awful.key({ modkey }, "d", function()
    local grabber
    grabber = awful.keygrabber.run(
      function(_, key, event)
        if event == "release" then return end

        if key == "i" then awful.spawn.with_shell("dm-maim")
        elseif key == "k" then awful.spawn.with_shell("dm-kill")
        elseif key == "m" then awful.spawn.with_shell("dm-man")
        elseif key == "n" then awful.spawn.with_shell("dm-note")
        elseif key == "o" then awful.spawn.with_shell("dm-bookman")
        elseif key == "p" then awful.spawn.with_shell("dm-offload")
        end
        awful.keygrabber.stop(grabber)
      end
    )
  end,
    { description = "followed by KEY", group = "Dmscripts" }
  ),

  -- Power profile
  awful.key({ modkey }, "p", function()
    local grabber
    grabber = awful.keygrabber.run(
      function(_, key, event)
        if event == "release" then return end

        if key == "b" then awful.spawn.with_shell("powerprofilesctl set balanced")
        elseif key == "s" then awful.spawn.with_shell("powerprofilesctl set power-saver")
        elseif key == "p" then awful.spawn.with_shell("powerprofilesctl set performance")
        end
        awful.keygrabber.stop(grabber)
      end
    )
  end,
    { description = "followed by KEY", group = "Power profile" }
  ),

  -- Editors (Super + e followed by KEY)
  awful.key({ modkey }, "e", function()
    local grabber
    grabber = awful.keygrabber.run(
      function(_, key, event)
        if event == "release" then return end

        if key == "e" then awful.spawn.with_shell(terminal .. " -e " .. editor)
        elseif key == "v" then awful.spawn.with_shell("neovide")
        end
        awful.keygrabber.stop(grabber)
      end
    )
  end,
    { description = "followed by KEY", group = "Emacs" }
  ),

  -- Tag browsing ALT+TAB (ALT+SHIFT+TAB)
  -- awful.key({ altkey, }, "Tab", awful.tag.viewnext,
  --   { description = "view next", group = "tag" }),
  -- awful.key({ altkey, "Shift" }, "Tab", awful.tag.viewprev,
  --   { description = "view previous", group = "tag" }),

  -- -- Non-empty tag browsing CTRL+TAB (CTRL+SHIFT+TAB)
  -- awful.key({ ctrlkey }, "Tab", function() lain.util.tag_view_nonempty(-1) end,
  --   { description = "view  previous nonempty", group = "tag" }),
  -- awful.key({ ctrlkey, "Shift" }, "Tab", function() lain.util.tag_view_nonempty(1) end,
  --   { description = "view  previous nonempty", group = "tag" }),

  -- Default client focus
  awful.key({ modkey, }, "j", function() awful.client.focus.byidx(1) end,
    { description = "Focus next by index", group = "client" }),
  awful.key({ modkey, }, "k", function() awful.client.focus.byidx(-1) end,
    { description = "Focus previous by index", group = "client" }),

  -- By direction client focus
  -- awful.key({ altkey }, "j", function() awful.client.focus.global_bydirection("down")
  --   if client.focus then client.focus:raise() end
  -- end,
  --   { description = "Focus down", group = "client" }),
  -- awful.key({ altkey }, "k", function() awful.client.focus.global_bydirection("up")
  --   if client.focus then client.focus:raise() end
  -- end,
  --   { description = "Focus up", group = "client" }),
  -- awful.key({ altkey }, "h", function() awful.client.focus.global_bydirection("left")
  --   if client.focus then client.focus:raise() end
  -- end,
  --   { description = "Focus left", group = "client" }),
  -- awful.key({ altkey }, "l", function() awful.client.focus.global_bydirection("right")
  --   if client.focus then client.focus:raise() end
  -- end,
  --   { description = "Focus right", group = "client" }),

  -- By direction client focus with arrows
  awful.key({ ctrlkey, modkey }, "Down", function() awful.client.focus.global_bydirection("down")
    if client.focus then client.focus:raise() end
  end,
    { description = "Focus down", group = "client" }),
  awful.key({ ctrlkey, modkey }, "Up", function() awful.client.focus.global_bydirection("up")
    if client.focus then client.focus:raise() end
  end,
    { description = "Focus up", group = "client" }),
  awful.key({ ctrlkey, modkey }, "Left", function() awful.client.focus.global_bydirection("left")
    if client.focus then client.focus:raise() end
  end,
    { description = "Focus left", group = "client" }),
  awful.key({ ctrlkey, modkey }, "Right", function() awful.client.focus.global_bydirection("right")
    if client.focus then client.focus:raise() end
  end,
    { description = "Focus right", group = "client" }),

  -- Layout manipulation
  awful.key({ modkey, "Shift" }, "j", function() awful.client.swap.byidx(1) end,
    { description = "swap with next client by index", group = "client" }),
  awful.key({ modkey, "Shift" }, "k", function() awful.client.swap.byidx(-1) end,
    { description = "swap with previous client by index", group = "client" }),
  awful.key({ modkey }, ".", function() awful.screen.focus_relative(1) end,
    { description = "focus the next screen", group = "screen" }),
  awful.key({ modkey }, ",", function() awful.screen.focus_relative(-1) end,
    { description = "focus the previous screen", group = "screen" }),
  awful.key({ modkey, }, "u", awful.client.urgent.jumpto,
    { description = "jump to urgent client", group = "client" }),
  awful.key({ ctrlkey, }, "Tab", function() awful.client.focus.history.previous()
    if client.focus then client.focus:raise() end
  end,
    { description = "go back", group = "client" }),

  -- On the fly useless gaps change
  awful.key({ modkey, ctrlkey }, "j", function() lain.util.useless_gaps_resize(1) end,
    { description = "increment useless gaps", group = "tag" }),
  awful.key({ modkey, ctrlkey }, "k", function() lain.util.useless_gaps_resize(-1) end,
    { description = "decrement useless gaps", group = "tag" }),

  -- Dynamic tagging
  awful.key({ modkey, "Shift" }, "n", function() lain.util.add_tag() end,
    { description = "add new tag", group = "tag" }),
  awful.key({ modkey, ctrlkey }, "r", function() lain.util.rename_tag() end,
    { description = "rename tag", group = "tag" }),
  awful.key({ modkey, "Shift" }, "Left", function() lain.util.move_tag(-1) end,
    { description = "move tag to the left", group = "tag" }),
  awful.key({ modkey, "Shift" }, "Right", function() lain.util.move_tag(1) end,
    { description = "move tag to the right", group = "tag" }),
  awful.key({ modkey, "Shift" }, "d", function() lain.util.delete_tag() end,
    { description = "delete tag", group = "tag" }),

  awful.key({ modkey }, "l", function() awful.tag.incmwfact(0.05) end,
    { description = "increase master width factor", group = "layout" }),
  awful.key({ modkey }, "h", function() awful.tag.incmwfact(-0.05) end,
    { description = "decrease master width factor", group = "layout" }),
  awful.key({ modkey, "Shift" }, "Up", function() awful.tag.incnmaster(1, nil, true) end,
    { description = "increase the number of master clients", group = "layout" }),
  awful.key({ modkey, "Shift" }, "Down", function() awful.tag.incnmaster(-1, nil, true) end,
    { description = "decrease the number of master clients", group = "layout" }),
  awful.key({ modkey, ctrlkey }, "h", function() awful.tag.incncol(1, nil, true) end,
    { description = "increase the number of columns", group = "layout" }),
  awful.key({ modkey, ctrlkey }, "l", function() awful.tag.incncol(-1, nil, true) end,
    { description = "decrease the number of columns", group = "layout" }),
  awful.key({ modkey, }, "Tab", function() awful.layout.inc(1) end,
    { description = "select next", group = "layout" }),
  awful.key({ modkey, "Shift" }, "Tab", function() awful.layout.inc(-1) end,
    { description = "select previous", group = "layout" }),

  awful.key({ modkey, ctrlkey }, "n",
    function()
      local c = awful.client.restore()
      -- Focus restored client
      if c then
        client.focus = c
        c:raise()
      end
    end,
    { description = "restore minimized", group = "client" }),

  -- Dropdown application

  -- awful.key({ modkey, }, "F12", function() awful.spawn.with_shell(terminal .. " -e " .. editor) end,
  -- { description = "Open Neovide", group = "super" }),
  awful.key({ modkey, }, "F12", function() scratch.toggle("neovide --x11-wm-class scratch3 --x11-wm-class-instance scratch3 " .. os.getenv("HOME") .. "/.scratch.md", utils.scratchRule("scratch3")) end),

  -- Widgets popups
  -- awful.key({ altkey, }, "c", function () lain.widget.cal.show(7) end,
  --     {description = "show calendar", group = "widgets"}),
  -- awful.key({ altkey, }, "h", function () if beautiful.fs then beautiful.fs.show(7) end end,
  --     {description = "show filesystem", group = "widgets"}),
  -- awful.key({ altkey, }, "w", function () if beautiful.weather then beautiful.weather.show(7) end end,
  --     {description = "show weather", group = "widgets"}),

  -- Brightness
  awful.key({}, "XF86MonBrightnessUp", function() os.execute("light -A 10") end,
    { description = "+10%", group = "hotkeys" }),
  awful.key({}, "XF86MonBrightnessDown", function() os.execute("light -U 10") end,
    { description = "-10%", group = "hotkeys" }),

  -- Media controller
  awful.key({}, "XF86AudioPlay",
    function()
      os.execute("playerctl play-pause")
    end),

  awful.key({}, "XF86AudioNext",
    function()
      os.execute("playerctl next")
    end),

  awful.key({}, "XF86AudioPrev",
    function()
      os.execute("playerctl previous")
    end),
  -- ALSA volume control
  --awful.key({ ctrlkey }, "Up",
  awful.key({}, "XF86AudioRaiseVolume",
    function()
      os.execute(string.format("wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 1%%+", beautiful.volume.channel))
      beautiful.volume.update()
    end),
  --awful.key({ ctrlkey }, "Down",
  awful.key({}, "XF86AudioLowerVolume",
    function()
      os.execute(string.format("wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 1%%-", beautiful.volume.channel))
      beautiful.volume.update()
    end),
  awful.key({}, "XF86AudioMute",
    function()
      os.execute(string.format("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle", beautiful.volume.togglechannel or beautiful.volume.channel))
      beautiful.volume.update()
    end),
  awful.key({ ctrlkey, "Shift" }, "m",
    function()
      os.execute(string.format("amixer -q set %s 100%%", beautiful.volume.channel))
      beautiful.volume.update()
    end),
  awful.key({ ctrlkey, "Shift" }, "0",
    function()
      os.execute(string.format("amixer -q set %s 0%%", beautiful.volume.channel))
      beautiful.volume.update()
    end),

  -- Copy primary to clipboard (terminals to gtk)
  awful.key({ modkey }, "c", function() awful.spawn.with_shell("xsel | xsel -i -b") end,
    { description = "copy terminal to gtk", group = "hotkeys" }),
  -- Copy clipboard to primary (gtk to terminals)
  awful.key({ modkey }, "v", function() awful.spawn.with_shell("xsel -b | xsel") end,
    { description = "copy gtk to terminal", group = "hotkeys" }),
  awful.key({ altkey, "Shift" }, "x",
    function()
      awful.prompt.run {
        prompt       = "Run Lua code: ",
        textbox      = awful.screen.focused().mypromptbox.widget,
        exe_callback = awful.util.eval,
        history_path = awful.util.get_cache_dir() .. "/history_eval"
      }
    end,
    { description = "lua execute prompt", group = "awesome" })
--]]
)

clientkeys = my_table.join(
  awful.key({ altkey, "Shift" }, "m", lain.util.magnify_client,
    { description = "magnify client", group = "client" }),
  awful.key({ modkey, }, "space",
    function(c)
      c.fullscreen = not c.fullscreen
      c:raise()
    end,
    { description = "toggle fullscreen", group = "client" }),
  awful.key({ modkey, "Shift" }, "c", function(c) c:kill() end,
    { description = "close", group = "hotkeys" }),
  awful.key({ modkey, }, "t", awful.client.floating.toggle,
    { description = "toggle floating", group = "client" }),
  awful.key({ modkey, ctrlkey }, "Return", function(c) c:swap(awful.client.getmaster()) end,
    { description = "move to master", group = "client" }),
  awful.key({ modkey, "Shift" }, "t", function(c) c.ontop = not c.ontop end,
    { description = "toggle keep on top", group = "client" }),
  awful.key({ modkey, }, "o", function(c) c:move_to_screen() end,
    { description = "move to screen", group = "client" }),
  awful.key({ modkey, }, "n",
    function(c)
      -- The client currently has the input focus, so it cannot be
      -- minimized, since minimized clients can't have the focus.
      c.minimized = true
    end,
    { description = "minimize", group = "client" }),
  awful.key({ modkey, }, "m",
    function(c)
      c.maximized = not c.maximized
      c:raise()
    end,
    { description = "maximize", group = "client" })
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
  -- Hack to only show tags 1 and 9 in the shortcut window (mod+s)
  local descr_view, descr_toggle, descr_move, descr_toggle_focus
  if i == 1 or i == 9 then
    descr_view = { description = "view tag #", group = "tag" }
    descr_toggle = { description = "toggle tag #", group = "tag" }
    descr_move = { description = "move focused client to tag #", group = "tag" }
    descr_toggle_focus = { description = "toggle focused client on tag #", group = "tag" }
  end
  globalkeys = my_table.join(globalkeys,
    -- View tag only.
    awful.key({ modkey }, "#" .. i + 9,
      function()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
          tag:view_only()
        end
      end,
      descr_view),
    -- Toggle tag display.
    awful.key({ modkey, ctrlkey }, "#" .. i + 9,
      function()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
          awful.tag.viewtoggle(tag)
        end
      end,
      descr_toggle),
    -- Move client to tag.
    awful.key({ modkey, "Shift" }, "#" .. i + 9,
      function()
        if client.focus then
          local tag = client.focus.screen.tags[i]
          if tag then
            client.focus:move_to_tag(tag)
          end
        end
      end,
      descr_move),
    -- Toggle tag on focused client.
    awful.key({ modkey, ctrlkey, "Shift" }, "#" .. i + 9,
      function()
        if client.focus then
          local tag = client.focus.screen.tags[i]
          if tag then
            client.focus:toggle_tag(tag)
          end
        end
      end,
      descr_toggle_focus)
  )
end

clientbuttons = gears.table.join(
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

-- Set keys
root.keys(globalkeys)

-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
  -- All clients will match this rule.
  { rule = {},
    properties = { border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      focus = awful.client.focus.filter,
      raise = true,
      keys = clientkeys,
      buttons = clientbuttons,
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap + awful.placement.no_offscreen,
      size_hints_honor = false
    }
  },
  -- Titlebars
  { rule_any = { type = { "dialog", "normal" } },
    properties = { titlebars_enabled = false } },

  { rule = { class = "gnome-calculator"},
    properties = { floating = true, placement = awful.placement.centered }},

  { rule = { class = "Gimp*", role = "gimp-image-window" },
    properties = { maximized = true } },

  { rule = { class = "inkscape" },
    properties = { maximized = true } },

  { rule = { class = mediaplayer },
    properties = { maximized = true } },

  { rule = { class = "Vlc" },
    properties = { maximized = true } },

  { rule = { class = "VirtualBox Manager" },
    properties = { maximized = true } },

  { rule = { class = "VirtualBox Machine" },
    properties = { maximized = true } },

  { rule = { class = "Xfce4-settings-manager" },
    properties = { floating = false } },

  { rule = { name = "Picture in Picture" },
    properties = { floating = true } },

  { rule = { class = "scratch"},
    properties = { floating = true, placement = awful.placement.centered } },


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

-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
  -- Set the windows at the slave,
  -- i.e. put it at the end of others instead of setting it master.
  if not awesome.startup then awful.client.setslave(c) end

  if awesome.startup and
      not c.size_hints.user_position
      and not c.size_hints.program_position then
    -- Prevent clients from being unreachable after screen count changes.
    awful.placement.no_offscreen(c)
  end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
  -- Custom
  if beautiful.titlebar_fun then
    beautiful.titlebar_fun(c)
    return
  end

  -- Default
  -- buttons for the titlebar
  local buttons = my_table.join(
    awful.button({}, 1, function()
      c:emit_signal("request::activate", "titlebar", { raise = true })
      awful.mouse.client.move(c)
    end),
    awful.button({}, 3, function()
      c:emit_signal("request::activate", "titlebar", { raise = true })
      awful.mouse.client.resize(c)
    end)
  )

  awful.titlebar(c, { size = 21 }):setup {
    { -- Left
      awful.titlebar.widget.iconwidget(c),
      buttons = buttons,
      layout  = wibox.layout.fixed.horizontal
    },
    { -- Middle
      { -- Title
        align  = "center",
        widget = awful.titlebar.widget.titlewidget(c)
      },
      buttons = buttons,
      layout  = wibox.layout.flex.horizontal
    },
    { -- Right
      awful.titlebar.widget.floatingbutton(c),
      awful.titlebar.widget.maximizedbutton(c),
      awful.titlebar.widget.stickybutton(c),
      awful.titlebar.widget.ontopbutton(c),
      awful.titlebar.widget.closebutton(c),
      layout = wibox.layout.fixed.horizontal()
    },
    layout = wibox.layout.align.horizontal
  }
end)

client.connect_signal("mouse::enter", function(c)
  c:emit_signal("request::activate", "mouse_enter", {  })
  -- c:emit_signal("request::activate", "mouse_enter", { raise = true })
end)

-- No border for maximized clients
local function border_adjust(c)
  if c.maximized then -- no borders if only 1 client visible
    c.border_width = 0
  elseif #awful.screen.focused().clients > 1 then
    c.border_width = beautiful.border_width
    c.border_color = beautiful.border_focus
  end
end

client.connect_signal("focus", border_adjust)
client.connect_signal("property::maximized", border_adjust)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

require("startup")
