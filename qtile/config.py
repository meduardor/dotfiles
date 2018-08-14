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
    Key([mod], "Return", lazy.spawn("termite")),
    Key([mod, "control"], "1", lazy.spawn("firefox")),
    Key([mod, "control"], "2", lazy.spawn("telegram-desktop")),
    Key([mod, "control"], "3", lazy.spawn("thunar")),
    Key([mod, "control"], "0", lazy.spawn("emacs")),
    Key([mod], "p", lazy.spawn("rofi -show run")),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout()),
    Key([mod], "w", lazy.window.kill()),

    Key([mod, "control"], "r", lazy.restart()),
    Key([mod, "control"], "q", lazy.shutdown()),
    Key([mod], "r", lazy.spawncmd()),
    # Keys BSP layout
    Key([mod], "j", lazy.layout.down()),
    Key([mod], "k", lazy.layout.up()),
    Key([mod], "h", lazy.layout.left()),
    Key([mod], "l", lazy.layout.right()),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up()),
    Key([mod, "shift"], "h", lazy.layout.shuffle_left()),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right()),
    Key([mod, "mod1"], "j", lazy.layout.flip_down()),
    Key([mod, "mod1"], "k", lazy.layout.flip_up()),
    Key([mod, "mod1"], "h", lazy.layout.flip_left()),
    Key([mod, "mod1"], "l", lazy.layout.flip_right()),
    Key([mod, "control"], "j", lazy.layout.grow_down()),
    Key([mod, "control"], "k", lazy.layout.grow_up()),
    Key([mod, "control"], "h", lazy.layout.grow_left()),
    Key([mod, "control"], "l", lazy.layout.grow_right()),
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
    layout.Stack(
        stacks=3,
        border_focus="#faf0a5",
        border_normal="#5f5b17",
        border_width=3,
        autosplit=True,
    ),
    layout.Bsp(
        border_normal="#49483e",
        border_focus="#f9f8f5",
        border_width=3,
        margin=2,
        fair=False,
        ratio=1.0,
    ),
    layout.Floating(
        border_normal="#49483e",
        border_focus="f9f8f5",
        border_width=3,
        padding=5,
        margin=3,
        ratio=1.5,
    ),
]

widget_defaults = dict(
    font='UbuntuMono Nerd Fonts',
    fontsize=12,
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
                    font='UbuntuMono Nerd Font',
                    foreground="#032c36",
                    padding=-2,
                ),
                widget.GroupBox(
                    highlight_method='line',
                    fontsize=15,
                    foreground="#daba8b",
                    active="#dfd1d3",
                    inactive="#8d1d1d",
                    padding=0,
                    highlight_color="#3a1515",
                    background="#032c36",
                    font='UbuntuMono Nerd Font',
                    borderwidth=2,
                    disable_drag=True,
                    other_screen_border='002b36',
                    other_current_screen_border='002b36'
                ),
                widget.TextBox(
                    "◤ ",
                    fontsize=55,
                    font='UbuntuMono Nerd Font',
                    foreground="#032c36",
                    padding=-5,
                ),
                widget.Prompt(
                    fontsize=15,
                    max_history=20,
                    record_history=True,
                    prompt=' ',
                    font='UbuntuMono Nerd Font',
                ),
                widget.WindowName(
                    fontsize=12,
                    foreground="#e8dfd6",
                    font='UbuntuMono Nerd Font',
                    padding=3,
                ),
                widget.TextBox(
                    "◢",
                    fontsize=55,
                    font='UbuntuMono Nerd Font',
                    foreground="#c2454e",
                    padding=-2,
                ),
                widget.CurrentLayout(
                    padding=0,
                    fontsize=15,
                    background="#c2454e",
                ),
                widget.TextBox(
                    "◤",
                    fontsize=55,
                    font='UbuntuMono Nerd Font',
                    foreground="#c2454e",
                    padding=-5,
                ),
                widget.TextBox(
                    "◢",
                    fontsize=55,
                    font='UbuntuMono Nerd Font',
                    foreground="#49384c",
                    padding=-2,
                ),
                widget.Battery(
                    format='{char} {percent:1.0%}',
                    low_foreground="#c33027",
                    charge_char='',
                    discharge_char='',
                    low_percentage=0.2,
                    update_delay=60,
                    font='UbuntuMono Nerd Fonts',
                    background="#49384c",
                    padding=5,
                ),
                widget.TextBox(
                    "◤",
                    font='UbuntuMono Nerd Font',
                    fontsize=55,
                    foreground="#49384c",
                    padding=-5,
                ),
                widget.TextBox(
                    "◢",
                    font='UbuntuMono Nerd Font',
                    fontsize=55,
                    foreground="#61778d",
                    padding=-2,
                ),
                widget.CPUGraph(
                    graph_color="c2454e",
                    border_width=1,
                    border_color="#ff5879",
                    type='line',
                    line_width=1,
                    width=50,
                    padding=3,
                    background="#61778d",
                ),
                widget.Memory(
                    format='{MemUsed}G',
                    foreground="#e8dfd6",
                    font='UbuntuMono Nerd Font',
                    update_interval=600,
                    fontsize=12,
                    padding=3,
                    background="#61778d",
                ),
                widget.TextBox(
                    "◤",
                    font='UbuntuMono Nerd Font',
                    fontsize=55,
                    foreground="#61778d",
                    padding=-5,
                ),
                widget.TextBox(
                    "◢",
                    font='UbuntuMono Nerd Font',
                    fontsize=55,
                    foreground="#2e3340",
                    padding=-2,
                ),
                widget.TextBox(
                    "",
                    font='UbuntuMono Nerd Font',
                    fontsize=15,
                    foreground="#e8dfd6",
                    background="#2e3340",
                    padding=3,
                ),
                widget.Pacman(
                    update_interval=60,
                    unavailable="c33027",
                    execute='sudo pacman -Syyu',
                    padding=0,
                    fontsize=15,
                    font='UbuntuMono Nerd Font',
                    background="#2e3340",
                ),
                widget.TextBox(
                    " ",
                    background="#2e3340",
                    padding=0,
                    fontsize=15,
                ),
                widget.Clock(
                    format='%a %d %b | %H:%M',
                    foreground="#e8dfd6",
                    font="UbuntuMono Nerd Font",
                    fontsize=15,
                    padding=0,
                    background="#2e3340",
                ),
                widget.Systray(
                    icon_size=15,
                    background="#2e3340",
                ),
            ],
            background="#021b21",
            opacity=0.95,
            size=20,
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
    border_normal="#49483e",
    border_focus="#f9f8f5",
    border_width=3,
    float_rules=[
        {'wmclass': 'confirm'},
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
os.system("al-compositor --start")
wmname = "Qtile"
