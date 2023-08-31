# Justine Smithies
# https://github.com/justinesmithies/qtile-wayland-dotfiles

# Key configuration

import os
from libqtile.config import Key
from libqtile.command import lazy

home = os.path.expanduser('~')
terminal = os.environ.get("TERMINAL")
mod = "mod4"

keys = [
    # Move focus to next screen
    Key([mod, "control"], "period",
        lazy.next_screen(),
        desc="Move focus to next screen",
        ),
    Key([mod], "g",
        lazy.screen.next_group(skip_empty=True),
        desc="Move to next active group"
        ),
    Key([mod, "shift"], "g",
        lazy.screen.prev_group(skip_empty=True),
        desc="Move to previous active group"
        ),
    # Switch between windows in current stack pane
    Key([mod], "h",
        lazy.layout.left(),
        desc="Move focus left in stack pane"
        ),
    Key([mod], "l",
        lazy.layout.right(),
        desc="Move focus right in stack pane"
        ),
    Key([mod], "k",
        lazy.layout.down(),
        desc="Move focus down in stack pane"
        ),
    Key([mod], "j",
        lazy.layout.up(),
        desc="Move focus up in stack pane"
        ),
    # Move window on the current screen
    Key([mod, "shift"], "h",
        lazy.layout.shuffle_left(),
        desc='Shuffle left'
        ),
    Key([mod, "shift"], "l",
        lazy.layout.shuffle_right(),
        desc='Shuffle right'
        ),
    Key([mod, "shift"], "k",
        lazy.layout.shuffle_down(),
        desc='Shuffle down'
        ),
    Key([mod, "shift"], "j",
        lazy.layout.shuffle_up(),
        desc='Shuffle up'
        ),
    # For the BSP layout
    Key([mod, "mod1"], "j",
        lazy.layout.flip_down(),
        desc='Flip down'
        ),
    Key([mod, "mod1"], "k",
        lazy.layout.flip_up(),
        desc='Flip up'
        ),
    Key([mod, "mod1"], "h",
        lazy.layout.flip_left(),
        desc='Flip left'
        ),
    Key([mod, "mod1"], "l",
        lazy.layout.flip_right(),
        desc='Flip right'
        ),
    Key([mod, "control"], "j",
        lazy.layout.grow_down(),
        desc='Grow down'
        ),
    Key([mod, "control"], "k",
        lazy.layout.grow_up(),
        desc='Grow up'
        ),
    Key([mod, "control"], "h",
        lazy.layout.grow_left(),
        desc='Grow left'
        ),
    Key([mod, "control"], "l",
        lazy.layout.grow_right(),
        desc='Grow right'
        ),
    Key([mod], "n",
        lazy.layout.normalize(),
        desc='normalize window size ratios'
        ),
    Key([mod], "m",
        lazy.layout.maximize(),
        desc='toggle window between minimum and maximum sizes'
        ),
    Key([mod], "o",
        lazy.layout.grow(),
        lazy.layout.increase_nmaster(),
        desc='Expand window (MonadTall), increase number in master pane (Tile)'
        ),
    Key([mod], "i",
        lazy.layout.shrink(),
        lazy.layout.decrease_nmaster(),
        desc='Shrink window (MonadTall), decrease number in master pane (Tile)'
        ),

    # Toggle floating
    Key([mod, "shift"], "f", lazy.window.toggle_floating(),
        desc="Toggle floating"
        ),

    # Toggle Fullscreen
    Key([mod], "f",
        lazy.window.toggle_fullscreen(),
        lazy.hide_show_bar(position='all'),
        desc='Toggle fullscreen and the bars'
        ),

    # Switch window focus to other pane(s) of stack
    Key([mod], "space", lazy.layout.next(),
        desc="Switch window focus to other pane(s) of stack"
        ),

    # Swap panes of split stack
    Key([mod, "shift"], "space",
        lazy.layout.rotate(),
        desc="Swap panes of split stack"
        ),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([mod, "shift"], "s",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack"
        ),
    Key([mod], "Return",
        lazy.spawn(terminal),
        desc="Launch terminal"
        ),

    # Toggle between different layouts as defined below
    Key([mod], "Tab",
        lazy.next_layout(),
        desc="Toggle between layouts"
        ),
    Key([mod], "w",
        lazy.window.kill(),
        desc="Kill focused window"
        ),

    # Toggle bars
    Key([mod], "b",
        lazy.hide_show_bar(position='all'),
        desc="Toggle bars"
        ),

    # Qtile system keys
    Key([mod, "shift", "control"], "l",
        lazy.spawn("swaylock -f -i .cache/wallpaper --effect-blur 10x5 --clock --indicator"),
        desc="Lock screen"
        ),
    Key([mod, "control"], "r",
        lazy.reload_config(),
        desc="Restart qtile"
        ),
    Key([mod, "control"], "q",
        lazy.shutdown(),
        desc="Shutdown qtile"
        ),
    Key([mod], "r",
        lazy.spawncmd(),
        desc="Spawn a command using a prompt widget"
        ),
    Key([mod, "control"], "p",
        lazy.spawn("" + home + "/.local/bin/powermenu"),
        desc="Launch Power menu"
        ),

    # Rofi
    Key(["control"], "space",
        lazy.spawn("fuzzel"),
        desc="Launch Fuzzel menu"
        ),
    # Window Switcher
    Key([mod, "control"], "w",
        lazy.spawn(home + "/.local/bin/qtile-window-switcher.py"),
        desc="Launch the Window Switcher",
        ),
    # Install updates
    Key([mod, "control"], "u",
        lazy.spawn(home + "/.local/bin/statusbar/arch-updates.sh key-update"),
        desc="Install updates",
        ),

    # Cycle through windows in the floating layout
    Key([mod, "shift"], "i",
        lazy.window.toggle_minimize(),
        lazy.group.next_window(),
        lazy.window.bring_to_front()
        ),

    # ------------ Hardware Configs ------------
    # Volume
    Key([], "XF86AudioMute",
        lazy.spawn(home + "/.local/bin/statusbar/volumecontrol mute"),
        desc='Mute audio'
        ),
    Key([], "XF86AudioLowerVolume",
        lazy.spawn(home + "/.local/bin/statusbar/volumecontrol down"),
        desc='Volume down'
        ),
    Key([], "XF86AudioRaiseVolume",
        lazy.spawn(home + "/.local/bin/statusbar/volumecontrol up"),
        desc='Volume up'
        ),

    # Media keys
    Key([], "XF86AudioPlay",
        lazy.spawn("dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify " "/org/mpris/MediaPlayer2 " "org.mpris.MediaPlayer2.Player.PlayPause"),
        desc='Audio play'
        ),
    Key([], "XF86AudioNext",
        lazy.spawn("dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify " "/org/mpris/MediaPlayer2 " "org.mpris.MediaPlayer2.Player.Next"),
        desc='Audio next'
        ),
    Key([], "XF86AudioPrev",
        lazy.spawn("dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify " "/org/mpris/MediaPlayer2 " "org.mpris.MediaPlayer2.Player.Previous"),
        desc='Audio previous'
        ),

    # Brightness
    Key([], "XF86MonBrightnessDown",
        lazy.spawn(home + "/.local/bin/statusbar/brightnesscontrol down"),
        desc='Brightness down'
        ),
    Key([], "XF86MonBrightnessUp",
        lazy.spawn(home + "/.local/bin/statusbar/brightnesscontrol up"),
        desc='Brightness up'
        ),

    # Screenshots
    # Take a screenshot of the currently focused output and save it into screenshots
    Key([], "Print",
        lazy.spawn(home + "/.local/bin/screenshot.sh"),
        desc='Save the screens of the currently focused output to the screenshots folder'
        ),
    # Take a screenshot of the selected region
    Key([mod], "Print",
        lazy.spawn(home + "/.local/bin/screenshot.sh selected-region"),
        desc='Save the selected region of the screen to the screenshots folder'
        ),
    # Capture region of screen to clipboard
    Key([mod, "shift"], "Print",
        lazy.spawn(home + "/.local/bin/screenshot.sh save-to-clipboard"),
        desc='Capture a region of the screen to the clipboard'
        ),
    # Take a screenshot of the selected window
    Key([mod, "control"], "Print",
        lazy.spawn(home + "/.local/bin/screenshot.sh selected-window"),
        desc='Save the selected window to the screenshots folder'
        ),
]

for i in range(1, 5):
    keys.append(Key(["control", "mod1"], "F" + str(i),
                    lazy.core.change_vt(i),
                    desc='Change to virtual console ' + str(i)
                    ),)
