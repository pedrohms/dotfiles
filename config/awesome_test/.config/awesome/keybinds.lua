local awful = require("awful")
local browser = "brave"
local chrome = "google-chrome-stable"
local terminal = "alacritty"
local spawnWithShell = function(cmd)
  awful.spawn.with_shell(cmd)
end
local keys = {
  awful.key({ modkey, }, "p", function()
    local grabber
    grabber = awful.keygrabber.run(
      function(_, key, event)
        if event == "release" then return end
        if key == "p" then
          awful.spawn.with_shell(os.getenv("HOME") .. "/.local/bin/dm-projects")
        elseif key == "o" then
          awful.spawn.with_shell(os.getenv("HOME") .. "/.local/bin/dm-offload")
        elseif key == "b" then
          awful.spawn.with_shell(os.getenv("HOME") .. "/.local/bin/dm-bookmark")
        end
        awful.keygrabber.stop(grabber)
      end
    )
  end),
  awful.key({ modkey, "Shift" }, "a", function()
    local grabber
    grabber = awful.keygrabber.run(
      function(_, key, event)
        if event == "release" then return end
        if key == "f" then
          awful.spawn("pcmanfm")
        elseif key == "w" then
          awful.spawn.with_shell("remote-viewer spice://localhost:5900")
        elseif key == "v" then
          awful.spawn("virt-manager")
        elseif key == "o" then
          awful.util.spawn(os.getenv("HOME") .. "/.local/bin/dm-offload")
        end
        awful.keygrabber.stop(grabber)
      end)
  end),
  awful.key({ modkey, }, "b", function()
    local grabber
    grabber = awful.keygrabber.run(
      function(_, key, event)
        if event == "release" then return end
        if key == "b" then
          awful.spawn(browser)
        elseif key == "c" then
          awful.spawn(chrome)
        end
        awful.keygrabber.stop(grabber)
      end)
  end),

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

  awful.key({ modkey, }, ".", function() awful.screen.focus_relative(1) end),
  awful.key({ modkey, }, ",", function() awful.screen.focus_relative(-1) end),
  awful.key({ modkey, }, "Return", function() spawnWithShell(terminal .. " -e tmux") end,
    { description = "open a terminal", group = "launcher" }),
  awful.key({ modkey, "Shift" }, "Return", function() spawnWithShell("dm-run") end,
    { description = "open a terminal", group = "launcher" }),

  awful.key({ modkey, "Shift" }, "r", awesome.restart,
    { description = "reload awesome", group = "awesome" }),
  awful.key({ modkey, "Shift" }, "q", function() spawnWithShell("dm-logout") end,
    { description = "quit awesome", group = "awesome" }),


  -- ALSA volume control
  --awful.key({ ctrlkey }, "Up",
  awful.key({}, "XF86AudioRaiseVolume",
    function()
      os.execute(string.format("wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 1%%+"))
    end),
  --awful.key({ ctrlkey }, "Down",
  awful.key({}, "XF86AudioLowerVolume",
    function()
      os.execute(string.format("wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 1%%-"))
    end),
  awful.key({}, "XF86AudioMute",
    function()
      os.execute(string.format("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
    end),

  awful.key({ modkey, }, "t", awful.client.floating.toggle,
    { description = "toggle floating", group = "client" }),
  awful.key({ modkey, }, "Tab", function() awful.layout.inc(1) end,
    { description = "select next", group = "layout" }),
  awful.key({ modkey, "Shift" }, "Tab", function() awful.layout.inc(-1) end,
    { description = "select previous", group = "layout" }),

  awful.key({ modkey, "Shift" }, "b", function()
    for s in screen do
      s.mywibox.visible = not s.mywibox.visible
      if s.mybottomwibox then
        s.mybottomwibox.visible = not s.mybottomwibox.visible
      end
    end
  end, { description = "Show/hide wibox (bar)", group = "awesome" }),
}

awful.keyboard.append_global_keybindings(keys)

