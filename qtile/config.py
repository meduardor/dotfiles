from libqtile.config import Key, Screen, Group, Drag, Click
from libqtile.command import lazy
from libqtile import layout, bar, widget
import os


try:
    from typing import List  # noqa: F401
except ImportError:
    pass

mod = "mod4"

keys = [
    # Switch between windows in current stack pane
    Key([mod], "k", lazy.layout.down()),
    Key([mod], "j", lazy.layout.up()),

    # Move windows up or down in current stack
    Key([mod, "control"], "k", lazy.layout.shuffle_down()),
    Key([mod, "control"], "j", lazy.layout.shuffle_up()),

    # Switch window focus to other pane(s) of stack
    Key([mod], "space", lazy.layout.next()),

    # Swap panes of split stack
    Key([mod, "shift"], "space", lazy.layout.rotate()),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([mod, "shift"], "Return", lazy.layout.toggle_split()),
    Key([mod], "Return", lazy.spawn("st")),
    Key([mod, "control"], "1", lazy.spawn("basilisk")),
    Key([mod, "control"], "2", lazy.spawn("telegram-desktop")),
    Key([mod, "control"], "3", lazy.spawn("thunar")),
    Key([mod, "control"], "0", lazy.spawn("emacs")),
    Key([mod], "p", lazy.spawn("rofi -show run")),
    Key([mod], "o", lazy.spawn("st -e ranger")),
    Key([mod], "i", lazy.spawn("st -e mutt")),
    Key([mod], "u", lazy.spawn("st -e newsboat")),
    # Toggle between different layouts as defined below	 
    Key([mod], "Tab", lazy.next_layout()),
    Key([mod], "w", lazy.window.kill()),

    Key([mod, "control"], "r", lazy.restart()),
    Key([mod, "control"], "q", lazy.shutdown()),
    Key([mod], "r", lazy.spawncmd()),
    # Keys BSP layout
    Key([mod], "Down", lazy.layout.down()),
    Key([mod], "Up", lazy.layout.up()),
    Key([mod], "Left", lazy.layout.left()),
    Key([mod], "Right", lazy.layout.right()),
    Key([mod, "shift"], "Down", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "Up", lazy.layout.shuffle_up()),
    Key([mod, "shift"], "Left", lazy.layout.shuffle_left()),
    Key([mod, "shift"], "Right", lazy.layout.shuffle_right()),
    Key([mod, "mod1"], "Down", lazy.layout.flip_down()),
    Key([mod, "mod1"], "Up", lazy.layout.flip_up()),
    Key([mod, "mod1"], "Left", lazy.layout.flip_left()),
    Key([mod, "mod1"], "Right", lazy.layout.flip_right()),
    Key([mod, "control"], "Down", lazy.layout.grow_down()),
    Key([mod, "control"], "Up", lazy.layout.grow_up()),
    Key([mod, "control"], "Left", lazy.layout.grow_left()),
    Key([mod, "control"], "Right", lazy.layout.grow_right()),
    Key([mod, "shift"], "n", lazy.layout.normalize()),
    Key([mod], "m", lazy.layout.toggle_split()),
    # Keys volume.
    Key(
        [], "XF86AudioRaiseVolume",
        lazy.spawn("pamixer -i 2")
    ),
    Key(
        [], "XF86AudioLowerVolume",
        lazy.spawn("pamixer -d 2")
    ),
    Key(
        [], "XF86AudioMute",
        lazy.spawn("pamixer -t")
    ),
    ]

groups = [
    Group("1"),
    Group("2"),
    Group("3"),
    Group("4"),
    Group("5"),
    Group("6")
]

for i in groups:
    # mod1 + letter of group = switch to group
    keys.append(
        Key([mod], i.name, lazy.group[i.name].toscreen())
    )

    # mod1 + shift + letter of group = switch to & move focused window to group
    keys.append(
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name))
    )

dgroups_key_binder = None
dgroups_app_rules = []

layouts = [
    layout.Max(),
   # layout.Stack(
   #     stacks=3,
   #     border_focus="#ffffff",
   #     border_normal="#282828",
   #   border_width=3,
   #    autosplit=True,
   # ),
    layout.Bsp(
        border_normal="#282828",
        border_focus="#ffffff",
        border_width=2,
        margin=5,
        fair=False,
        ratio=1.0,
    ),
 #   layout.Floating(
 #       border_normal="#282828",
 #       border_focus="ffffff",
 #       border_width=3,
 #       padding=5,
 #       margin=3,
 #       ratio=1.5,
 #   ),
]

widget_defaults = dict(
    font='ProFont for Powerline',
    fontsize=10,
    padding=2,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.TextBox(
                    "◢",
                    fontsize=55,
                    font='Inconsolata',
                    foreground="#ffffff",
                    padding=-2,
                ),
                widget.GroupBox(
                    highlight_method='line',
                    fontsize=10,
                    foreground="#282828",
                    active="#dc322f",
                    inactive="#000000",
                    padding=0,
                    highlight_color="#ffffff",
                    background="#ffffff",
                    font='Hack',
                    borderwidth=2,
                    disable_drag=True,
                    other_screen_border='002b36',
                    other_current_screen_border='002b36'
                ),
                widget.TextBox(
                    "◤ ",
                    fontsize=55,
                    font='Inconsolata',
                    foreground="#ffffff",
                    padding=-5,
                ),
                widget.Prompt(
                    fontsize=10,
                    max_history=20,
                    record_history=True,
                    prompt='run: ',
                    font='monofur for Powerline',
                ),
                widget.WindowName(
                    fontsize=10,
                    foreground="#e8dfd6",
                    font='ProFont for Powerline',
                    padding=3,
                ),
                widget.TextBox(
                    "◢",
                    fontsize=55,
                    font='Inconsolata',
                    foreground="#ffffff",
                    padding=-2,
                ),
                widget.CurrentLayout(
                    padding=0,
                    fontsize=10,
                    background="#ffffff",
                    foreground="#282828",
                    font='Hack',
                ),
                widget.TextBox(
                    "◤",
                    fontsize=55,
                    font='Inconsolata',
                    foreground="#ffffff",
                    padding=-5,
                ),
                widget.TextBox(
                    "◢",
                    fontsize=55,
                    font='Inconsolata',
                    foreground="#ffffff",
                    padding=-2,
                ),
                widget.Battery(
                    format='{char} {percent:1.0%}',
                    low_foreground="#c33027",
                    charge_char='',
                    discharge_char='',
                    low_percentage=0.2,
                    update_delay=60,
                    fontsize=10,
                    font='ProFont for Powerline',
                    background="#ffffff",
                    padding=5,
                    foreground="#282828"
                ),
                widget.TextBox(
                    "◤",
                    font='Inconsolata',
                    fontsize=55,
                    foreground="#ffffff",
                    padding=-5,
                ),
                widget.TextBox(
                    "◢",
                    font='Inconsolata',
                    fontsize=55,
                    foreground="#ffffff",
                    padding=-2,
                ),
                widget.TextBox(
                    " ",
                    background="#ffffff",
                    padding=0,
                    fontsize=15,
                ),
                widget.Clock(
                    format='%a %d %b | %H:%M',
                    foreground="#282828",
                    font="ProFont for Powerline",
                    fontsize=10,
                    padding=0,
                    background="#ffffff",
                ),
                widget.Systray(
                    icon_size=13,
                    background="#ffffff",
                ),
            ],
            background="#000000",
            size=13,
        ),
    ),
]
# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

# dgroups_key_binder = None
# dgroups_app_rules = []  # type: List
main = None
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    border_normal="#282828",
    border_focus="#ffffff",
    border_width=3,
    float_rules=[
        {'wmclass': 'confirm'},
        {'wmclass': 'telegram-desktop'},
        {'wmclass': 'dialog'},
        {'wmclass': 'download'},
        {'wmclass': 'error'},
        {'wmclass': 'file_progress'},
        {'wmclass': 'notification'},
        {'wmclass': 'splash'},
        {'wmclass': 'toolbar'},
        {'wmclass': 'confirmreset'},  # gitk
        {'wmclass': 'makebranch'},  # gitk
        {'wmclass': 'maketag'},  # gitk
        {'wname': 'branchdialog'},  # gitk
        {'wname': 'pinentry'},  # GPG key password entry
        {'wmclass': 'ssh-askpass'},  # ssh-askpass
    ])
auto_fullscreen = True
focus_on_window_activation = "smart"


os.system("nitrogen --restore")
os.system("compton -b -c -C")
os.system("xrandr --output HDMI1 --primary --mode 1366x768 --pos 1366x0 --rotate normal --output VIRTUAL1 --off --output eDP1 --mode 1366x768 --pos 0x0 --rotate normal")
wmname = "Qtile"
