pcall(require, "luarocks.loader")

require("awful.autofocus")
-- require("awful.hotkeys_popup.keys")

-- Imports
local utils = require("gears")
local wibox = require("wibox") -- widget framework
local awful = require("awful") -- window management
local theme = require("beautiful")

-- Avoid global variable warnings
local awesome = awesome
local client = client
local root = root

-- Variables
local main_dir = utils.filesystem.get_configuration_dir()
local home = os.getenv("HOME")
local mod = "Mod4"

-- Error handling
dofile(main_dir .. "misc/error_handling.lua")

-- Init theme
theme.init(main_dir .. "themes/theme1.lua")

-- Layouts
local layouts = awful.layout.suit

awful.layout.layouts = {
    layouts.tile,
    layouts.tile.bottom,
    layouts.tile.left,
    layouts.tile.top,
    layouts.fair,
    layouts.fair.horizontal,
    -- layouts.spiral,
    -- layouts.spiral.dwindle,
    -- layouts.max,
    -- layouts.max.fullscreen,
    -- layouts.magnifier,
    -- layouts.corner.nw,
    -- layouts.corner.ne,
    -- layouts.corner.sw,
    -- layouts.corner.se,
    layouts.floating,
}

-- Screen setup
local bar = dofile(main_dir .. "bars/simple_middleempty_diagonal.lua")

awful.screen.connect_for_each_screen(function (s)
    -- Create tags
    awful.tag(
        { "1", "2", "3", "4", "5", "6", "7", "8" },
        s,
        awful.layout.layouts[1]
    )

    -- Init Bar
    bar.init(s, {
        launcher = "sh ".. home .."/.config/rofi/launcher/launcher.sh",
    })
end)

-- Global keys
local function get_keys(filename)
    return dofile(main_dir .. "keys/" .. filename .. ".lua").init(mod)
end

local keys_global = utils.table.join(table.unpack(utils.table.join(
    get_keys("general"),
    get_keys("movement_wasd"),
    get_keys("layout_control"),
    get_keys("switch_layouts"),
    get_keys("audio_controls"),
    get_keys("applications")
)))

-- Bind numbers to tags
for i = 1, 9 do
    keys_global = utils.table.join(
        keys_global,

        -- Switch active tag
        awful.key(
            { mod }, "#" .. i + 9,
            function ()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    tag:view_only()
                end
            end,
            { group = "tag", description = "View tag #" .. i }
        ),

        -- Move window to tag
        awful.key({ mod, "Shift" }, "#" .. i + 9,
            function ()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:move_to_tag(tag)
                    end
                end
            end,
            { group = "tag", description = "Move focused window to tag #"..i }
        )
    )
end

-- Local keys
local keys_client = utils.table.join(
    awful.key(
        { mod, "Shift" }, "q",
        function (c) c:move_to_screen(c.screen.index - 1) end,
        { group = "client", description = "Move window to previous screen" }
    ),
    awful.key(
        { mod, "Shift" }, "e",
        function (c) c:move_to_screen(c.screen.index + 1) end,
        { group = "client", description = "Move window to next screen" }
    ),
    awful.key(
        { mod, "Shift" }, "x",
        function (c) c:kill() end,
        { group = "client", description = "Close window" }
    ),
    awful.key(
        { mod }, "f",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end,
        { group = "client", description = "Toggle window maximize" }
    ),
    awful.key(
        { mod, "Shift" }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        { group = "client", description = "Toggle window fullscreen" }
    ),
    awful.key(
        { mod, "Control" }, "space",
        function (c)
            awful.client.floating.toggle()
            c:raise()
        end,
        { group = "client", description = "Toggle window floating mode" }
    ),
    awful.key(
        { mod, "Control" }, "c",
        function (c)
            awful.placement.centered()
            c:raise()
        end,
        { group = "client", description = "Center window" }
    ),
    awful.key(
        { mod, "Shift" }, "space",
        function (c)
            awful.titlebar.toggle(c)
            c:raise()
        end,
        { group = "client", description = "Toggle window titlebar" }
    )
)

-- Window button handling
local client_buttons = utils.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ mod }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ mod }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- Register global keys
root.keys(keys_global)

-- Rules
awful.rules.rules = {
    -- Global rules
    {
        rule = {},
        properties = {
            border_width = theme.border_width,
            border_color = theme.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = keys_client,
            buttons = client_buttons,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap + awful.placement.no_offscreen,
            size_hints_honor = false,
        }
    },

    -- Floating windows
    {
        rule_any = {
            instance = {
            },
            class = {
            },
            name = {
            },
            role = {
                "pop-up",
            }
        },
        properties = {
            floating = true,
        }
    },

    --[[ {
        rule_any = {
            type = {
                "normal",
            }
        },
        properties = {
            titlebars_enabled = true,
        }
    }, ]]
}

-- Signals

-- When a new window appears
client.connect_signal("manage", function (c)
    if not awesome.startup then
        awful.client.setslave(c)
    end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        awful.placement.no_offscreen(c)
    end
end)

-- Add titlebars
client.connect_signal("request::titlebars", function (c)
    local buttons_titlebar = utils.table.join(
        awful.button({ }, 1, function ()
            c:emit_signal("request::activate", "titlebar", { raise = true })
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function ()
            c:emit_signal("request::activate", "titlebar", { raise = true })
            awful.mouse.client.resize(c)
        end)
    )


    awful.titlebar(c, {
        size = 24,
    }):setup({
        layout = wibox.layout.align.horizontal,
        {
            widget = wibox.container.margin,
            margins = 4,
            awful.titlebar.widget.iconwidget(c),
        },
        {
            {
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c),
            },
            buttons = buttons_titlebar,
            layout  = wibox.layout.flex.horizontal
        },
        {
            widget = wibox.container.margin,
            margins = 2,
            {
                layout = wibox.layout.fixed.horizontal,
                spacing = 0,
                awful.titlebar.widget.floatingbutton(c),
                awful.titlebar.widget.maximizedbutton(c),
                awful.titlebar.widget.closebutton(c),
            }
        },
    })
end)

-- Focus window under mouse
client.connect_signal("mouse::enter", function (c)
    c:emit_signal("request::activate", "mouse_enter", { raise = false })
end)

client.connect_signal("focus", function (c) c.border_color = theme.border_focus end)
client.connect_signal("unfocus", function (c) c.border_color = theme.border_normal end)
