import os

from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, ScratchPad, DropDown, Key, KeyChord, Match, Screen
from libqtile.lazy import lazy

mod = "mod4"
terminal = "alacritty"
browser = "brave"
browser_private = "brave --incognito"
file_manager = "nemo"

show_battery = False

home=os.path.expanduser("~")

# Shortcuts
keys = [
    # Switch focus between windows
    Key(
        [mod], "Left",
        lazy.layout.left(),
        desc="Move focus left"
    ),
    Key(
        [mod], "Right",
        lazy.layout.right(),
        desc="Move focus right"
    ),
    Key(
        [mod], "Up",
        lazy.layout.up(),
        desc="Move focus up"
    ),
    Key(
        [mod], "Down",
        lazy.layout.down(),
        desc="Move focus down"
    ),
    # Move windows between left/right columns or move up/down in current stack
    Key([mod, "shift"],
        "Left",
        lazy.layout.shuffle_left(),
        desc="Move window to the left"
    ),
    Key([mod, "shift"],
        "Right",
        lazy.layout.shuffle_right(),
        desc="Move window to the right"
    ),
    Key([mod, "shift"],
        "Up",
        lazy.layout.shuffle_up(),
        desc="Move window up"
    ),
    Key([mod, "shift"],
        "Down",
        lazy.layout.shuffle_down(),
        desc="Move window down"
    ),
    # Change windows size
    Key(
        [mod, "control"], "Left",
        lazy.layout.grow_left(),
        desc="Grow window to the left"
    ),
    Key(
        [mod, "control"], "Right",
        lazy.layout.grow_right(),
        desc="Grow window to the right"
    ),
    Key(
        [mod, "control"], "Down",
        lazy.layout.grow_down(),
        desc="Grow window up"
    ),
    Key(
        [mod, "control"], "Up",
        lazy.layout.grow_up(),
        desc="Grow window down"
    ),
    # Misc window shortcuts
    Key(
        [mod, "control"], "r",
        lazy.restart(),
        desc="Restart Qtile"
    ),
    Key(
        [mod], "n",
        lazy.layout.normalize(),
        desc="Reset all windows size"
    ),
    Key(
        [mod], "Tab",
        lazy.next_layout(),
        desc="Switch layouts"
    ),
    Key(
         [mod, "shift"], "Tab",
         lazy.layout.toggle_split(),
         desc="Maximize the focused window inside its own column"
    ),
    Key(
        [mod], "space",
        lazy.window.toggle_floating(),
        desc="Toggle floating for the focused window"
    ),
    Key(
        [mod], "q",
        lazy.window.kill(),
        desc="Kill focused window"
    ),
    # Applications
    Key(
        [mod], "t",
        lazy.spawn(terminal), # -e /usr/bin/fish
        desc="Launch terminal (" + terminal + ")"
    ),
    Key(
        [mod], "e",
        lazy.spawn(file_manager),
        desc="Launch file manager (" + file_manager + ")"
    ),
    Key(
        [mod], "b",
        lazy.spawn(browser),
        desc="Launch browser (" + browser + ")"
    ),
    Key(
        [mod, "shift"], "b",
        lazy.spawn(browser_private),
        desc="Launch browser (" + browser_private + ")"
    ),
    # Rofi menus
    Key(
        [mod], "a",
        lazy.spawn(f"sh {home}/.config/rofi/launchers/type-1/launcher.sh"),
        desc="Launch Rofi's application menu"
    ),
    Key(
        [mod], "m",
        lazy.spawn(f"sh {home}/.config/rofi/applets/bin/mpd.sh"),
        desc="Launch Rofi's music menu"
    ),
    Key(
        [mod], "s",
        lazy.spawn(f"sh {home}/.config/rofi/applets/bin/screenshot.sh"),
        desc="Launch Rofi's screenshot menu"
    ),
    Key(
        [mod], "x",
        lazy.spawn(f"sh {home}/.config/rofi/powermenu/type-1/powermenu.sh"),
        desc="Launch Rofi's power menu"
    ),
    # Sound
    Key(
        [], "XF86AudioRaiseVolume",
        lazy.spawn("amixer -M set Master,0 5%+ unmute"),
        desc="Launch Rofi's window selector"
    ),
    Key(
        [], "XF86AudioLowerVolume",
        lazy.spawn("amixer -M set Master,0 5%- unmute"),
        desc="Launch Rofi's window selector"
    ),
]

# Workspaces
groups = [
    Group(
        "1",
        label="",
    ),
    Group(
        "2",
        label="",
    ),
    Group(
        "3",
        label="",
    ),
    Group(
        "4",
        label="",
    ),
    Group(
        "5",
        label="",
    ),
]

for i in groups:
    keys.extend([
        # mod + letter of group = switch to group
        Key(
            [mod],
            i.name,
            lazy.group[i.name].toscreen(),
            desc="Switch to group {}".format(i.name),
        ),
        # mod + shift + letter of group = switch to and move focused window to group
        Key(
            [mod, "shift"],
            i.name,
            lazy.window.togroup(i.name, switch_group=True),
            desc="Switch to & move focused window to group {}".format(i.name),
        ),
    ])

groups.extend([
    ScratchPad(
       "scratchpad", [
           DropDown(
               "terminal", terminal,
               on_focus_lost_hide=False,
               width=0.4,
               height=0.5,
               x=0.3,
               y=0.25,
           ),
           DropDown(
               "mixer", terminal + " -e pulsemixer",
               on_focus_lost_hide=False,
               width=0.4,
               height=0.5,
               x=0.3,
               y=0.25,
           ),
       ]
    ),
])

keys.extend([
    KeyChord([mod], "g", [
        Key([], "t", lazy.group["scratchpad"].dropdown_toggle("terminal"))
    ]),
    Key([mod], "v", lazy.group["scratchpad"].dropdown_toggle("mixer")),
])

# Layouts
colorscheme = {
"Rosewater" : "#f5e0dc",
"Flamingo"  : "#f2cdcd",
"Pink"      : "#f5c2e7",
"Mauve"     : "#cba6f7",
"Red"       : "#f38ba8",
"Maroon"    : "#eba0ac",
"Peach"     : "#fab387",
"Yellow"    : "#f9e2af",
"Green"     : "#a6e3a1",
"Teal"      : "#94e2d5",
"sky"       : "#89dceb",
"Sapphire"  : "#74c7ec",
"Blue"      : "#89b4fa",
"Lavender"  : "#b4befe",
"Text"      : "#cdd6f4",
"Subtext1"  : "#bac2de",
"Subtext0"  : "#a6adc8",
"Overlay2"  : "#9399b2",
"Overlay1"  : "#7f849c",
"Overlay0"  : "#6c7086",
"Surface2"  : "#585b70",
"Surface1"  : "#45475a",
"Surface0"  : "#313244",
"Base"      : "#1e1e2e",
"Mantle"    : "#181825",
"Crust"     : "#11111b",
}

layout_theme = {
    "border_width": 2,
    "border_normal": colorscheme["Overlay0"],
    "border_focus": colorscheme["Sapphire"],
    "margin": 6,
}

layouts = [
    layout.Columns(
        **layout_theme,
        border_focus_stack=colorscheme["Green"],
        border_normal_stack=layout_theme["border_normal"],
        border_on_single=True,
        grow_amount=1,
        # fair=True,
    ),
    layout.Max(),
]

# Widgets
widget_defaults = dict(
    font="JetBrains Mono Nerd Font Bold",
    fontsize=14,
    padding=3,
)

extension_defaults = widget_defaults.copy()

bar_widgets = [
    widget.TextBox(
        text="",
        padding=7,
        fontsize=20,
        foreground=colorscheme["Blue"],
        background=colorscheme["Crust"],
        mouse_callbacks={
            "Button1": lazy.spawn(f"sh {home}/.config/rofi/launchers/type-1/launcher.sh"),
        },
    ),
    widget.Spacer(
        length=4,
        background=colorscheme["Crust"],
    ),
    widget.TextBox(
        text="",
        padding=0,
        fontsize=27,
        foreground=colorscheme["Crust"],
        background=colorscheme["Surface2"],
    ),
    widget.GroupBox(
        disable_drag=True,
        highlight_method="text",
        urgent_alert_method="text",
        this_current_screen_border=colorscheme["Green"],
        active=colorscheme["Text"],
        inactive=colorscheme["Surface0"],
        urgent_text=colorscheme["Red"],
        fontsize=20,
        background=colorscheme["Surface2"],
    ),
    widget.TextBox(
        text="",
        padding=0,
        fontsize=27,
        foreground=colorscheme["Surface2"],
        background=colorscheme["Sapphire"],
    ),
    widget.CurrentLayoutIcon(
        custom_icon_paths=[f"{home}/.config/qtile/layout-icons"],
        scale=0.67,
        padding=0,
        background=colorscheme["Sapphire"],
    ),
    widget.TextBox(
        text="",
        padding=0,
        fontsize=27,
        foreground=colorscheme["Sapphire"],
        background=colorscheme["Surface0"],
    ),
    widget.WindowName(
        padding=10,
        background=colorscheme["Surface0"],
    ),
    widget.TextBox(
        text="",
        padding=0,
        fontsize=27,
        background=colorscheme["Surface0"],
        foreground=colorscheme["Sapphire"],
    ),
    widget.TextBox(
        text="墳",
        fontsize=20,
        background=colorscheme["Sapphire"],
        foreground=colorscheme["Crust"],
    ),
    widget.Spacer(
        length=6,
        background=colorscheme["Sapphire"],
    ),
    widget.Volume(
        background=colorscheme["Sapphire"],
        foreground=colorscheme["Crust"],
    ),
    widget.TextBox(
        text="",
        padding=0,
        fontsize=27,
        background=colorscheme["Sapphire"],
        foreground=colorscheme["Peach"],
    ),
    widget.Clock(
        format="%d-%m-%Y",
        background=colorscheme["Peach"],
        foreground=colorscheme["Base"],
    ),
    widget.TextBox(
        text="",
        padding=0,
        fontsize=27,
        background=colorscheme["Peach"],
        foreground=colorscheme["Base"],
    ),
    widget.Systray(
        background=colorscheme["Base"],
    ),
]

# Battery widget
if show_battery:
    bar_widgets.extend([
        widget.Spacer(
            length=10,
            background=colorscheme["Base"],
        ),
        widget.TextBox(
            text="",
            background=colorscheme["Base"],
        ),
        widget.Battery(
            format="{percent:2.0%}",
            background=colorscheme["Base"],
        )
    ])

bar_widgets.extend([
    widget.TextBox(
        text="",
        padding=0,
        fontsize=27,
        background=colorscheme["Base"],
        foreground=colorscheme["Green"],
    ),
    widget.Clock(
        format="%H:%M:%S",
        background=colorscheme["Green"],
        foreground=colorscheme["Mantle"],
    ),
    widget.TextBox(
        text="",
        padding=0,
        fontsize=27,
        background=colorscheme["Green"],
        foreground=colorscheme["Mantle"],
    ),
    widget.TextBox(
        text=" ",
        fontsize=15,
        background=colorscheme["Mantle"],
        foreground=colorscheme["Red"],
        mouse_callbacks={
            "Button1": lazy.spawn(f"sh {home}/.config/rofi/powermenu/type-1/powermenu.sh"),
        },
    ),
])

# Add widgets to screens
screens = [
    Screen(
        top=bar.Bar(
            bar_widgets,
            32,
            margin = [0, 0, 6, 0],
            background = "#202020"
        ),
        bottom=bar.Gap(6),
        left=bar.Gap(6),
        right=bar.Gap(6),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

layout_theme = {
    "border_width": 2,
    "border_normal": colorscheme["Overlay0"],
    "border_focus": colorscheme["Sapphire"],
    "margin": 6,
}

floating_layout = layout.Floating(
    border_width=2,
    border_normal=colorscheme["Overlay0"],
    border_focus=colorscheme["Red"],
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = True
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
