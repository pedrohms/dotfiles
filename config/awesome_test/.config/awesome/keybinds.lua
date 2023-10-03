local awful = require("awful")
local browser = "brave"
local chrome = "google-chrome-stable"
local terminal = "alacritty"
local spawnWithShell = function(cmd)
  awful.spawn.with_shell(cmd)
end
local keys = {
  awful.key({ modkey, }, "p", function() awful.spawn.with_shell(os.getenv("HOME").."/.local/bin/dm-offload") end),
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
  awful.key({ modkey, }, "b", function()
    local grabber
    grabber = awful.keygrabber.run(
      function(_, key, event)
        if event == "release" then return end
        if key == "b" then awful.spawn(browser)
        elseif key == "c" then awful.spawn(chrome)
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

  awful.key({modkey, }, ".", function() awful.screen.focus_relative(1) end),
  awful.key({modkey, }, ",", function() awful.screen.focus_relative(-1) end),

  awful.key({ modkey,           }, "Return", function () spawnWithShell(terminal .. " -e tmux") end,
            {description = "open a terminal", group = "launcher"}),
  awful.key({ modkey,  "Shift"  }, "Return", function () spawnWithShell("dm-run") end,
            {description = "open a terminal", group = "launcher"}),

  awful.key({ modkey, "Shift"   }, "r", awesome.restart,
            {description = "reload awesome", group = "awesome"}),
  awful.key({ modkey, "Shift"   }, "q",function() spawnWithShell("dm-logout") end,
            {description = "quit awesome", group = "awesome"}),


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

-- DEFAULT KEYBINDS FROM AWESOMEWM
awful.keyboard.append_global_keybindings({
    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),
    awful.key({ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                    c:activate { raise = true, context = "key.unminimize" }
                  end
              end,
              {description = "restore minimized", group = "client"}),
})

-- Layout related keybindings
awful.keyboard.append_global_keybindings({
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),
})

awful.keyboard.append_global_keybindings({
    awful.key {
        modifiers   = { modkey },
        keygroup    = "numrow",
        description = "only view tag",
        group       = "tag",
        on_press    = function (index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then
                tag:view_only()
            end
        end,
    },
    awful.key {
        modifiers   = { modkey, "Control" },
        keygroup    = "numrow",
        description = "toggle tag",
        group       = "tag",
        on_press    = function (index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then
                awful.tag.viewtoggle(tag)
            end
        end,
    },
    awful.key {
        modifiers = { modkey, "Shift" },
        keygroup    = "numrow",
        description = "move focused client to tag",
        group       = "tag",
        on_press    = function (index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:move_to_tag(tag)
                end
            end
        end,
    },
    awful.key {
        modifiers   = { modkey, "Control", "Shift" },
        keygroup    = "numrow",
        description = "toggle focused client on tag",
        group       = "tag",
        on_press    = function (index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:toggle_tag(tag)
                end
            end
        end,
    },
})
