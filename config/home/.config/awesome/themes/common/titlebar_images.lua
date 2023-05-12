local utils = require("gears")
local gfs = require("gears.filesystem")
local main_dir = utils.filesystem.get_configuration_dir()
local themes_dir = gfs.get_themes_dir()

return {
    titlebar_close_button_normal = main_dir .. "assets/close.svg",
    titlebar_close_button_focus = main_dir .. "assets/close.svg",
    titlebar_floating_button_normal_inactive = main_dir .. "assets/tiled.svg",
    titlebar_floating_button_focus_inactive = main_dir .. "assets/tiled.svg",
    titlebar_floating_button_normal_active = main_dir .. "assets/floating.svg",
    titlebar_floating_button_focus_active = main_dir .. "assets/floating.svg",
    titlebar_maximized_button_normal_inactive = main_dir .. "assets/unmaximized.svg",
    titlebar_maximized_button_focus_inactive = main_dir .. "assets/unmaximized.svg",
    titlebar_maximized_button_normal_active = main_dir .. "assets/maximized.svg",
    titlebar_maximized_button_focus_active = main_dir .. "assets/maximized.svg",

    titlebar_minimize_button_normal = themes_dir .. "default/titlebar/minimize_normal.png",
    titlebar_minimize_button_focus = themes_dir .. "default/titlebar/minimize_focus.png",
    titlebar_ontop_button_normal_inactive = themes_dir .. "default/titlebar/ontop_normal_inactive.png",
    titlebar_ontop_button_focus_inactive = themes_dir .. "default/titlebar/ontop_focus_inactive.png",
    titlebar_ontop_button_normal_active = themes_dir .. "default/titlebar/ontop_normal_active.png",
    titlebar_ontop_button_focus_active = themes_dir .. "default/titlebar/ontop_focus_active.png",
    titlebar_sticky_button_normal_inactive = themes_dir .. "default/titlebar/sticky_normal_inactive.png",
    titlebar_sticky_button_focus_inactive = themes_dir .. "default/titlebar/sticky_focus_inactive.png",
    titlebar_sticky_button_normal_active = themes_dir .. "default/titlebar/sticky_normal_active.png",
    titlebar_sticky_button_focus_active = themes_dir .. "default/titlebar/sticky_focus_active.png",
}
