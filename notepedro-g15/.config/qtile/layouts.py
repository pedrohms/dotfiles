# Justine Smithies
# https://github.com/justinesmithies/qtile-wayland-dotfiles

# Layout configuration

from libqtile import layout
from libqtile.config import Match
from colors import colors

# DEFAULT THEME SETTINGS FOR LAYOUTS #
layout_theme = {"border_width": 2,
                "margin": 10,
                "border_focus": '#33eeffee',
                "border_normal": colors['dark0']
                }

layouts = [
    layout.MonadTall(**layout_theme, single_border_width=2),
    layout.Stack(num_stacks=2, **layout_theme),
    # layout.Max(),
    # Try more layouts by unleashing below layouts.
    layout.Bsp(**layout_theme),
    layout.Columns(**layout_theme),

]

floating_layout = layout.Floating(
    **layout_theme,
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        # *layout.Floating.default_float_rules,
        Match(title='Quit and close tabs?'),
        Match(wm_type='utility'),
        Match(wm_type='notification'),
        Match(wm_type='toolbar'),
        Match(wm_type='splash'),
        Match(wm_type='dialog'),
        Match(wm_class='gimp-2.99'),
        Match(wm_class='Firefox'),
        Match(wm_class='file_progress'),
        Match(wm_class='confirm'),
        Match(wm_class='dialog'),
        Match(wm_class='download'),
        Match(wm_class='error'),
        Match(wm_class='notification'),
        Match(wm_class='splash'),
        Match(wm_class='toolbar'),
        Match(title='About LibreOffice'),
        Match(wm_class='confirmreset'),  # gitk
        Match(wm_class='makebranch'),  # gitk
        Match(wm_class='maketag'),  # gitk
        Match(wm_class='ssh-askpass'),  # ssh-askpass
        Match(title='branchdialog'),  # gitk
        Match(title='pinentry'),  # GPG key password entry
    ],
)
