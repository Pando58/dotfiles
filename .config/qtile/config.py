from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy

mod = "mod4"
terminal = "alacritty"
browser= "brave"

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
    #Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
    Key(
        [mod], "t",
        lazy.spawn(terminal), # -e /usr/bin/fish
        desc="Launch terminal (" + terminal + ")"
    ),
    Key(
        [mod], "b",
        lazy.spawn(browser),
        desc="Launch browser (" + browser + ")"
    ),
]

groups = [Group(i) for i in "123456789"]

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

layouts = [
    layout.Columns(border_width=1, margin=6,fair=False),
    layout.Max(),
]

widget_defaults = dict(
    font="monospace",
    fontsize=14,
    padding=6,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.CurrentLayout(),
                widget.GroupBox(),
                widget.Prompt(),
                widget.WindowName(),
                widget.Chord(
                    chords_colors={
                        "launch": ("#ff0000", "#ffffff"),
                    },
                    name_transform=lambda name: name.upper(),
                ),
                widget.TextBox("default config", name="default"),
                widget.Systray(),
                widget.Clock(format="%Y-%m-%d %a %I:%M %p"),
                widget.QuickExit(),
            ],
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

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
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
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
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
