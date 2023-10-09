local awful = require("awful")
local gears = require("gears")
local is_restart

if not is_restart then
  awful.spawn.with_shell("lxsession")
  awful.spawn.with_shell("picom")
  awful.spawn.with_shell("nm-applet")
  awful.spawn.with_shell("volumeicon")
  awful.spawn.with_shell("conky -c $HOME/.config/conky/awesome/doom-one-01.conkyrc")
  awful.spawn.with_shell("LG3D")
  awful.spawn.with_shell("xset r rate 210 40")
  awful.spawn.with_shell("flameshot")

  if os.getenv("USER") == "framework" then
    awful.spawn.with_shell("setxkbmap -layout us -variant intl")
  else
    awful.spawn.with_shell("setxkbmap -layout br -variant abnt2")
  end

  if os.getenv("PH_MACHINE") == "g15" then
    gears.timer {
        timeout   = 5,
        call_now  = true,
        autostart = false,
        callback  = function()
          awful.spawn.with_shell("$HOME/.config/ph-autostart/awesome/autostart.sh")
          local clock = os.clock
          function sleep(n)  -- seconds
             local t0 = clock()
             while clock() - t0 <= n do
             end
          end
          sleep(2)
          awful.spawn.with_shell("feh  --bg-fill $HOME/.local/wall/0001.jpg")
        end
    }
  end
end


do
  local restart_detected
  is_restart = function()
    if restart_detected ~= nil then
      return restart_detected
    end

    awesome.register_xproperty("awesome_restart_check", "boolean")
    restart_detected = awesome.get_xproperty("awesome_restart_check") ~= nil
    awesome.set_xproperty("awesome_restart_check", true)
    return restart_detected
  end
end
