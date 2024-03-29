#pywal1 config
from typing import List  # noqa: F401
import os
import subprocess
from os import path

from libqtile import bar, layout, widget, hook, qtile
from libqtile.config import Click, Drag, Group, ScratchPad, DropDown, KeyChord, Key, Match, Screen
from libqtile.lazy import lazy
from settings.path import qtile_path
import colors

mod = "mod4"
terminal = "alacritty -e tmux"
brawser = "brave"


keys = [
    KeyChord([mod], "b", [
        Key([], "b", lazy.spawn(brawser)),
        Key([], "c", lazy.spawn("google-chrome-stable")),
        Key([], "f", lazy.spawn("firefox")),
    ]),
    KeyChord([mod, "shift"], "a", [
        Key([], "f", lazy.spawn("pcmanfm")),
    ]),
    Key([mod, "shift"], "Return", lazy.spawn(os.path.expanduser('~/') + ".local/bin/dm-run") ),
# Open terminal
    Key([mod], "Return", lazy.spawn(terminal)),
# Qtile System Actions
    Key([mod, "shift"], "r", lazy.restart()),
    Key([mod, "shift"], "q", lazy.spawn(os.path.expanduser('~/') + ".local/bin/dm-logout")),
# Active Window Actions
    Key([mod], "space", lazy.window.toggle_fullscreen()),
    Key([mod, "shift"], "c", lazy.window.kill()),
    Key([mod, "control"], "h",
        lazy.layout.grow_right(),
        lazy.layout.grow(),
        lazy.layout.increase_ratio(),
        lazy.layout.delete()
        ),
    Key([mod, "control"], "Right",
        lazy.layout.grow_right(),
        lazy.layout.grow(),
        lazy.layout.increase_ratio(),
        lazy.layout.delete()
        ),
    Key([mod, "control"], "l",
        lazy.layout.grow_left(),
        lazy.layout.shrink(),
        lazy.layout.decrease_ratio(),
        lazy.layout.add()
        ),
    Key([mod, "control"], "Left",
        lazy.layout.grow_left(),
        lazy.layout.shrink(),
        lazy.layout.decrease_ratio(),
        lazy.layout.add()
        ),
    Key([mod, "control"], "k",
        lazy.layout.grow_up(),
        lazy.layout.grow(),
        lazy.layout.decrease_nmaster()
        ),
    Key([mod, "control"], "Up",
        lazy.layout.grow_up(),
        lazy.layout.grow(),
        lazy.layout.decrease_nmaster()
        ),
    Key([mod, "control"], "j",
        lazy.layout.grow_down(),
        lazy.layout.shrink(),
        lazy.layout.increase_nmaster()
        ),
    Key([mod, "control"], "Down",
        lazy.layout.grow_down(),
        lazy.layout.shrink(),
        lazy.layout.increase_nmaster()
        ),

# Window Focus (Arrows and Vim keys)
    Key([mod], "Up", lazy.layout.up()),
    Key([mod], "Down", lazy.layout.down()),
    Key([mod], "Left", lazy.layout.left()),
    Key([mod], "Right", lazy.layout.right()),
    Key([mod], "k", lazy.layout.up()),
    Key([mod], "j", lazy.layout.down()),
    Key([mod], "h", lazy.layout.left()),
    Key([mod], "l", lazy.layout.right()),

# Qtile Layout Actions
    Key([mod], "r", lazy.layout.reset()),
    Key([mod], "Tab", lazy.next_layout()),
    Key([mod, "shift"], "Tab", lazy.prev_layout()),
    Key([mod, "shift"], "f", lazy.layout.flip()),
    Key([mod], "t", lazy.window.toggle_floating()),

# Move windows around MonadTall/MonadWide Layouts
    Key([mod, "shift"], "Up", lazy.layout.shuffle_up()),
    Key([mod, "shift"], "Down", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "Left", lazy.layout.swap_left()),
    Key([mod, "shift"], "Right", lazy.layout.swap_right()),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up()),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "h", lazy.layout.swap_left()),
    Key([mod, "shift"], "l", lazy.layout.swap_right()),

# Switch focus of monitors
    Key([mod], "period", lazy.next_screen()),
    Key([mod], "comma", lazy.prev_screen()),
]

# Create labels for groups and assign them a default layout.
groups = []


# group_names = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "minus", "equal", "F1", "F2", "F3", "F4", "F5"]
group_names = ["1", "2", "3", "4", "5", "6", "7"]

# group_labels = ["", "", "", "", "", "", "", "", "ﭮ", "", "", "﨣", "F1", "F2", "F3", "F4", "F5"]
# group_labels = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17"]
group_labels = ["1", "2", "3", "4", "5", "6", "7"]

# group_layouts = ["monadtall", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall"]
group_layouts = ["monadtall", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall"]

# Add group names, labels, and default layouts to the groups object.
for i in range(len(group_names)):
    groups.append(
        Group(
            name=group_names[i],
            layout=group_layouts[i].lower(),
            label=group_labels[i],
        ))

# Add group specific keybindings
for i in groups:
    keys.extend([
        Key([mod], i.name, lazy.group[i.name].toscreen(), desc="Mod + number to move to that group."),
        Key(["mod1"], "Tab", lazy.screen.next_group(), desc="Move to next group."),
        Key(["mod1", "shift"], "Tab", lazy.screen.prev_group(), desc="Move to previous group."),
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name), desc="Move focused window to new group."),
    ])

# Define scratchpads
groups.append(ScratchPad("scratchpad", [
    DropDown("term", "alacritty --class scratch", width=0.6, height=0.55, x=0.35, y=0.35, opacity=1),
    DropDown("term2", "alacritty --class scratch", width=0.6, height=0.55, x=0.35, y=0.35, opacity=1),
    DropDown("ranger", "kitty --class=ranger -e ranger", width=0.8, height=0.8, x=0.1, y=0.1, opacity=0.9),
    DropDown("volume", "kitty --class=volume -e pulsemixer", width=0.8, height=0.8, x=0.1, y=0.1, opacity=0.9),
    DropDown("mus", "kitty --class=mus -e ncmpcpp", width=0.8, height=0.8, x=0.1, y=0.1, opacity=0.9),
    DropDown("news", "kitty --class=news -e newsboat", width=0.8, height=0.8, x=0.1, y=0.1, opacity=0.9),

]))

# Scratchpad keybindings
keys.extend([
    Key([mod], "n", lazy.group['scratchpad'].dropdown_toggle('term')),
    Key([mod, "shift"], "n", lazy.group['scratchpad'].dropdown_toggle('term2')),
])

colors, backgroundColor, foregroundColor, workspaceColor, chordColor = colors.gruvbox()

# Define layouts and layout themes
layout_theme = {
        "margin":9,
        "border_width": 2,
        "border_focus": colors[3],
        "border_normal": backgroundColor
    }

layouts = [
    layout.MonadTall(**layout_theme),
    layout.MonadWide(**layout_theme),
    layout.MonadThreeCol(**layout_theme),
    layout.MonadWide(**layout_theme),
    layout.Floating(**layout_theme),
    layout.Spiral(**layout_theme),
    layout.RatioTile(**layout_theme),
    layout.Max(**layout_theme)
]

# Mouse callback functions
def launch_menu():
    qtile.cmd_spawn("rofi -modi run -show run")


# Define Widgets
widget_defaults = dict(
    font="JetBrainsMono Nerd Font",
    fontsize = 12,
    padding = 2,
    background=backgroundColor
)

def init_widgets_list(monitor_num):
    widgets_list = [
        widget.GroupBox(
            font="JetBrainsMono Nerd Font",
            fontsize = 16,
            margin_y = 2,
            margin_x = 4,
            padding_y = 6,
            padding_x = 6,
            borderwidth = 2,
            disable_drag = True,
            active = colors[4],
            inactive = foregroundColor,
            hide_unused = False,
            rounded = False,
            highlight_method = "line",
            highlight_color = [backgroundColor, backgroundColor],
            this_current_screen_border = colors[5],
            this_screen_border = colors[7],
            other_screen_border = colors[6],
            other_current_screen_border = colors[6],
            urgent_alert_method = "line",
            urgent_border = colors[9],
            urgent_text = colors[1],
            foreground = foregroundColor,
            background = backgroundColor,
            use_mouse_wheel = False
        ),
        widget.Spacer(),
        widget.WindowName(),
        widget.Sep(linewidth = 0, padding = 10),
        widget.TextBox(text = " ", fontsize = 14, font = "JetBrainsMono Nerd Font", foreground = colors[7]),
        widget.CPU(
            font = "JetBrainsMono Nerd Font",
            update_interval = 1.0,
            format = '{load_percent}%',
            foreground = foregroundColor,
            background = colors[0],
            padding = 5
        ),
        widget.Sep(linewidth = 0, padding = 10),
        widget.TextBox(text = "󰍛", fontsize = 14, font = "JetBrainsMono Nerd Font", foreground = colors[3]),
        widget.Memory(
            font = "JetBrainsMonoNerdFont",
            foreground = foregroundColor,
            format = '{MemUsed: .0f}{mm} /{MemTotal: .0f}{mm}',
            measure_mem='G',
            padding = 5,
        ),
        widget.Sep(linewidth = 0, padding = 10),
        widget.Volume( foreground = colors[4], fmt = '🕫  Vol: {}',),
        widget.Sep(linewidth = 0, padding = 10),
        widget.TextBox(text = "", fontsize = 23, font = "JetBrainsMono Nerd Font", padding = 0, foreground = colors[4], background = colors[0]),
        widget.TextBox(text = " ", fontsize = 14, font = "JetBrainsMono Nerd Font", foreground = colors[0], background = colors[4]),
        widget.Clock(format='%I:%M %p', font = "JetBrainsMono Nerd Font", padding = 10, foreground = colors[0], background = colors[4]),
        widget.TextBox(text = "", fontsize = 23, font = "JetBrainsMono Nerd Font", padding = 0, foreground = colors[0], background = colors[4]),
        widget.Systray(background = backgroundColor, icon_size = 20, padding = 4),
        widget.Sep(linewidth = 1, padding = 10, foreground = colors[5], background = backgroundColor),
        widget.CurrentLayoutIcon(scale = 0.5, foreground = colors[6], background = colors[6]),
    ]

    return widgets_list

def init_secondary_widgets_list(monitor_num):
    secondary_widgets_list = init_widgets_list(monitor_num)
    del secondary_widgets_list[len(secondary_widgets_list)-4:len(secondary_widgets_list)-1]
    return secondary_widgets_list

widgets_list = init_widgets_list("1")

widgets_list = init_widgets_list("1")
secondary_widgets_list = init_secondary_widgets_list("2")

screens = [
    Screen(top=bar.Bar(widgets=widgets_list, size=24, background=backgroundColor, margin=0, opacity=0.8),),
    Screen(top=bar.Bar(widgets=secondary_widgets_list, size=24, background=backgroundColor, margin=0, opacity=0.8),),
    ]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

@hook.subscribe.startup_once
def autostart():
   home = os.path.expanduser('~/.config/qtile/scripts/autostart.sh')
   subprocess.run([home])

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
follow_mouse_focus = True
bring_front_click = True
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    *layout.Floating.default_float_rules,
    Match(wm_class='confirmreset'),  # gitk
    Match(wm_class='makebranch'),  # gitk
    Match(wm_class='maketag'),  # gitk
    Match(wm_class='ssh-askpass'),  # ssh-askpass
    Match(title='branchdialog'),  # gitk
    Match(title='pinentry'),  # GPG key password entry
], fullscreen_border_width = 0, border_width = 0)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

auto_minimize = True
wmname = "Qtile 0.21.0"
