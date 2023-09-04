# Justine Smithies
# https://github.com/justinesmithies/qtile-wayland-dotfiles

# Widgets setup
# Get the icons at https://www.nerdfonts.com/cheat-sheet

import os
import subprocess
from libqtile import qtile
from libqtile import widget
from colors import colors
from ordinaldate import custom_date
from keys import terminal


widget_defaults = dict(
    # font='FiraCode Nerd Font Regular',
    font='GoMono Nerd Font',
    fontsize='12',
    padding=2,
    foreground=colors['light0']
)
extension_defaults = widget_defaults.copy()

primary_widgets = [
    widget.Spacer(length=10),
    widget.GroupBox(
        padding=0,
        active=colors['light0'],
        borderwidth=3,
        inactive=colors['light4'],
        this_current_screen_border=colors['neutral_green'],
        this_screen_border=colors['neutral_green'],
        other_screen_border='#00000000',
        other_current_screen_border='#00000000',
        font='GoMono Nerd Font',
        fontsize=12,
        highlight_method='line',
        highlight_color=['00000000', '00000000']
    ),
    widget.CurrentLayoutIcon(scale=0.5, **widget_defaults),
    widget.CurrentLayout(**widget_defaults),
    widget.Spacer(),
    widget.GenPollText(
        func=custom_date,
        update_interval=1,
        **widget_defaults,
        mouse_callbacks={
            'Button1': lambda: qtile.spawn(os.path.expanduser("~/.local/bin/statusbar/calendar.sh show"), shell=True),
            'Button3': lambda: qtile.spawn(os.path.expanduser("~/.local/bin/statusbar/calendar.sh edit"), shell=True)
        }
    ),
    widget.Spacer(),
    widget.CheckUpdates(
        **widget_defaults,
        update_interval=600,
        distro='Arch_paru',
        custom_command='~/.local/bin/statusbar/arch-updates.sh',
        display_format=' {updates}',
        colour_have_updates=colors['neutral_green'],
        execute='foot -e paru'
    ),
    widget.Spacer(length=5),
    widget.GenPollText(update_interval=1, **widget_defaults, func=lambda: subprocess.check_output(os.path.expanduser("~/.local/bin/statusbar/idleinhibit")).decode(), mouse_callbacks={'Button1': lambda: qtile.spawn(os.path.expanduser("~/.local/bin/statusbar/idleinhibit toggle"), shell=True)}),
    widget.Spacer(length=5),
    widget.KeyboardLayout(configured_keyboards=['us', 'gb']),
    widget.Spacer(length=5),
    widget.GenPollText(update_interval=1, **widget_defaults, func=lambda: subprocess.check_output(os.path.expanduser("~/.local/bin/statusbar/brightnesscontrol")).decode(), mouse_callbacks={'Button1': lambda: qtile.spawn(os.path.expanduser("~/.local/bin/statusbar/brightnesscontrol down"), shell=True), 'Button3': lambda: qtile.spawn(os.path.expanduser("~/.local/bin/statusbar/brightnesscontrol up"), shell=True)}),
    widget.Spacer(length=5),
    widget.GenPollText(update_interval=1, **widget_defaults, func=lambda: subprocess.check_output(os.path.expanduser("~/.local/bin/statusbar/volumecontrol")).decode(), mouse_callbacks={'Button1': lambda: qtile.spawn(os.path.expanduser("~/.local/bin/statusbar/volumecontrol down"), shell=True), 'Button2': lambda: qtile.spawn(os.path.expanduser("~/.local/bin/statusbar/volumecontrol mute"), shell=True), 'Button3': lambda: qtile.spawn(os.path.expanduser("~/.local/bin/statusbar/volumecontrol up"), shell=True)}),
    widget.Spacer(length=5),
    widget.GenPollText(update_interval=1, **widget_defaults, func=lambda: subprocess.check_output(os.path.expanduser("~/.local/bin/statusbar/battery.py")).decode(), mouse_callbacks={'Button1': lambda: qtile.spawn(os.path.expanduser("~/.local/bin/statusbar/battery.py --c left-click"), shell=True)}),
    widget.Spacer(length=5),
    widget.GenPollText(update_interval=1, **widget_defaults, func=lambda: subprocess.check_output(os.path.expanduser("~/.local/bin/statusbar/network.sh")).decode(), mouse_callbacks={'Button1': lambda: qtile.spawn(os.path.expanduser("~/.local/bin/statusbar/network.sh ShowInfo"), shell=True), 'Button3': lambda: qtile.spawn(terminal + ' -e nmtui', shell=True)}),
    widget.Spacer(length=10),
]

secondary_widgets = [
    widget.Spacer(length=10),
    widget.GroupBox(
        padding=0,
        forground=colors['light0'],
        borderwidth=3,
        inactive=colors['light4'],
        this_current_screen_border=colors['neutral_green'],
        this_screen_border=colors['neutral_green'],
        other_screen_border='#00000000',
        other_current_screen_border='#00000000',
        font='GoMono Nerd Font',
        fontsize=12,
        highlight_method='line',
        highlight_color=['00000000', '00000000']
    ),
    widget.CurrentLayoutIcon(scale=0.6, **widget_defaults),
    widget.CurrentLayout(**widget_defaults),
    widget.Spacer(length=440),
    widget.GenPollText(
        func=custom_date,
        update_interval=1,
        **widget_defaults,
        mouse_callbacks={
            'Button1': lambda: qtile.spawn(os.path.expanduser("~/.local/bin/statusbar/calendar.sh show"), shell=True),
            'Button3': lambda: qtile.spawn(os.path.expanduser("~/.local/bin/statusbar/calendar.sh edit"), shell=True)
        }
    ),
    widget.Spacer(),
]
