-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
-- beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")
beautiful.init(os.getenv("HOME") .. "/.config/awesome/theme/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "alacritty"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor

-- Default mod.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
mod = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    --awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    -- awful.layout.suit.fair,
    -- awful.layout.suit.fair.horizontal,
    -- awful.layout.suit.spiral,
    -- awful.layout.suit.spiral.dwindle,
    -- awful.layout.suit.max,
    -- awful.layout.suit.max.fullscreen,
    -- awful.layout.suit.magnifier,
    -- awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
   { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end },
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "open terminal", terminal }
                                  }
                        })

mylauncher = awful.widget.launcher {
    image = beautiful.arch_logo,
    menu = mymainmenu,
}

-- mylauncher.forced_width = 24
-- mylauncher.valign = "center"

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- {{{ Wibar

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
    awful.button({ }, 1, function(t) t:view_only() end),
    awful.button({ mod }, 1, function(t)
        if client.focus then
            client.focus:move_to_tag(t)
        end
    end),
    awful.button({ }, 3, awful.tag.viewtoggle),
    awful.button({ mod }, 3, function(t)
        if client.focus then
            client.focus:toggle_tag(t)
        end
    end),
    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)

local tasklist_buttons = gears.table.join(
    awful.button({ }, 1, function (c)
        if c == client.focus then
            c.minimized = true
        else
            c:emit_signal(
                "request::activate",
                "tasklist",
                {raise = true}
            )
        end
    end),
    awful.button({ }, 3, function()
        awful.menu.client_list({ theme = { width = 250 } })
    end),
    awful.button({ }, 4, function ()
        awful.client.focus.byidx(1)
    end),
    awful.button({ }, 5, function ()
        awful.client.focus.byidx(-1)
    end)
)

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
-- screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    -- set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4", "5", "6" }, s, awful.layout.layouts[1])

    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
        awful.button({ }, 1, function () awful.layout.inc( 1) end),
        awful.button({ }, 3, function () awful.layout.inc(-1) end),
        awful.button({ }, 4, function () awful.layout.inc( 1) end),
        awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen = s,
        filter = awful.widget.taglist.filter.all,
        buttons = taglist_buttons,
        --[[ widget_template = {
            {
                widget = wibox.container.margin,
                top = 9,
                bottom = 9,
                left = 6,
                right = 6,
                {
                    id = 'icon',
                    widget = wibox.widget.imagebox,
                    image = beautiful.tag_inactive,
                },
            },
            id     = 'background_role',
            widget = wibox.container.background,
            -- Add support for hover colors and an index label
            create_callback = function(self, tag, index, objects) --luacheck: no unused args
                -- self:get_children_by_id('index_role')[1].markup = '<b> '..index..' </b>'
                -- self:connect_signal('mouse::enter', function()
                --     if self.bg ~= '#ff0000' then
                --         self.backup     = self.bg
                --         self.has_backup = true
                --     end
                --     self.bg = '#ff0000'
                -- end)
                -- self:connect_signal('mouse::leave', function()
                --     if self.has_backup then self.bg = self.backup end
                -- end)
            end,
            update_callback = function(self, tag, index, objects) --luacheck: no unused args
                -- self:get_children_by_id('index_role')[1].markup = '<b> '..index..' </b>'
            end,
        }, ]]
    }

    -- Create a tasklist widget
    --[[ s.mytasklist = awful.widget.tasklist {
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
        -- layout = {
        --     layout = wibox.layout.fixed.horizontal,
        -- },
    } ]]

    -- Create the wibox
    s.mywibox = awful.wibar({
        screen = s,
        position = "top",
        height = 32,
    })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        expand = "none",
        {
            layout = wibox.layout.fixed.horizontal,
            -- mylauncher,
            s.mytaglist,
            {
                widget = wibox.container.margin,
                margins = 8,
                s.mylayoutbox,
            },
        },
        {
            layout = wibox.layout.fixed.horizontal,
            wibox.widget.textclock(),
        },
        -- s.mytasklist,
        {
            layout = wibox.layout.fixed.horizontal,
            {
                widget = wibox.container.margin,
                margins = 8,
                wibox.widget.systray()
            }
        },
    }
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end)
    -- awful.button({ }, 4, awful.tag.viewnext),
    -- awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = gears.table.join(
    --[[ awful.key(
        { mod }, "{",
        awful.tag.viewprev,
        { group = "tag", description = "Switch to left workspace" }
    ),
    awful.key(
        { mod }, "}",
        awful.tag.viewnext,
        { group = "tag", description = "Switch to right workspace" }
    ), ]]

    -- Awesome
    awful.key(
        { mod }, "s",
        hotkeys_popup.show_help,
        { group="awesome", description="Show shortcuts popup" }
    ),
    awful.key(
        { mod, "Control" }, "r",
        awesome.restart,
        { group = "awesome", description = "Reload awesome" }
    ),
    awful.key({ mod }, "r",
        function() menubar.show() end,
        { group = "launcher", description = "Show menubar" }
    ),

    -- Move window focus
    awful.key(
        { mod }, "Left",
        function () awful.client.focus.global_bydirection("left") end,
        { group = "client", description = "Focus left window" }
    ),
    awful.key(
        { mod }, "Right",
        function () awful.client.focus.global_bydirection("right") end,
        { group = "client", description = "Focus right window" }
    ),
    awful.key(
        { mod }, "Up",
        function () awful.client.focus.global_bydirection("up") end,
        { group = "client", description = "Focus the window above" }
    ),
    awful.key(
        { mod }, "Down",
        function () awful.client.focus.global_bydirection("down") end,
        { group = "client", description = "Focus the window below" }
    ),

    -- Swap windows
    awful.key(
        { mod, "Shift" }, "Left",
        function () awful.client.swap.global_bydirection("left") end,
        { group = "client", description = "Focus left window" }
    ),
    awful.key(
        { mod, "Shift" }, "Right",
        function () awful.client.swap.global_bydirection("right") end,
        { group = "client", description = "Focus right window" }
    ),
    awful.key(
        { mod, "Shift" }, "Up",
        function () awful.client.swap.global_bydirection("up") end,
        { group = "client", description = "Focus the window above" }
    ),
    awful.key(
        { mod, "Shift" }, "Down",
        function () awful.client.swap.global_bydirection("down") end,
        { group = "client", description = "Focus the window below" }
    ),

    -- Move screen focus
    awful.key(
        { mod }, "{",
        function () awful.screen.focus_relative(-1) end,
        { group = "screen", description = "Focus left screen" }
    ),
    awful.key(
        { mod }, "}",
        function () awful.screen.focus_relative(1) end,
        { group = "screen", description = "Focus right screen" }
    ),

    -- Layout controls
    awful.key(
        { mod }, "+",
        function () awful.tag.incmwfact(0.02) end,
        { group = "layout", description = "Increase master size" }
    ),
    awful.key(
        { mod }, "-",
        function () awful.tag.incmwfact(-0.02) end,
        { group = "layout", description = "Decrease master size" }
    ),
    awful.key(
        { mod, "Shift" }, "+",
        function () awful.tag.incnmaster(1, nil, true) end,
        { group = "layout", description = "Increase the number of master clients" }
    ),
    awful.key(
        { mod, "Shift" }, "-",
        function () awful.tag.incnmaster(-1, nil, true) end,
        { group = "layout", description = "Decrease the number of master clients" }
    ),
    awful.key(
        { mod, "Control" }, "+",
        function () awful.tag.incncol(1, nil, true)    end,
        { group = "layout", description = "increase the number of columns" }
    ),
    awful.key(
        { mod, "Control" }, "-",
        function () awful.tag.incncol(-1, nil, true)    end,
        { group = "layout", description = "decrease the number of columns" }
    ),

    -- Switch layouts
    awful.key(
        { mod }, "Tab",
        function () awful.layout.inc(1) end,
        { group = "layout", description = "Select next layout" }
    ),
    awful.key(
        { mod, "Shift" }, "Tab",
        function () awful.layout.inc(-1) end,
        { group = "layout", description = "Select previous layout" }
    ),

    -- Applications
    awful.key(
        { mod }, "t",
        function () awful.spawn(terminal) end,
        { group = "launcher", description = "Launch terminal (" .. terminal .. ")" }
    ),
    awful.key(
        { mod }, "b",
        function () awful.spawn("brave") end,
        { group = "launcher", description = "Launch web browser (brave)" }
    ),
    awful.key(
        { mod, "Shift" }, "b",
        function () awful.spawn("brave --incognito") end,
        { group = "launcher", description = "Launch web browser (brave --incognito)" }
    )
)

clientkeys = gears.table.join(
    awful.key(
        { mod }, "f",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end,
        { group = "client", description = "Toggle window maximize" }
    ),
    awful.key({ mod, "Shift" }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        { group = "client", description = "Toggle window fullscreen" }
    ),
    awful.key(
        { mod }, "q",
        function (c) c:kill() end,
        { group = "client", description = "Close window" }
    ),
    awful.key(
        { mod }, "space",
        awful.client.floating.toggle,
        { group = "client", description = "Toggle window floating mode" }
    ),
    awful.key(
        { mod, "Control" }, "Return",
        function (c) c:swap(awful.client.getmaster()) end,
        { group = "client", description = "move to master" }
    ),
    awful.key(
        { mod, "Shift" }, "}",
        function (c) c:move_to_screen(c.screen.index+1) end,
        { group = "client", description = "Move window to next screen" }
    ),
    awful.key(
        { mod, "Shift" }, "{",
        function (c) c:move_to_screen(c.screen.index-1) end,
        { group = "client", description = "Move window to previous screen" }
    ),
    -- awful.key(
    --     { mod, "Mod1" }, "t",
    --     function (c) c.ontop = not c.ontop end,
    --     { group = "client", description = "toggle keep on top" }
    -- ),
    -- awful.key({ mod,           }, "n",
    --     function (c)
    --         -- The client currently has the input focus, so it cannot be
    --         -- minimized, since minimized clients can't have the focus.
    --         c.minimized = true
    --     end ,
    --     {description = "minimize", group = "client"}),
    awful.key(
        { mod, "Mod1" }, "v",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end,
        { group = "client", description = "Toggle vertical maximize" }
    ),
    awful.key({ mod, "Mod1" }, "h",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end,
        { group = "client", description = "Toggle horizontal maximize" }
    )
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ mod }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ mod, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ mod, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ mod, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

clientbuttons = gears.table.join(
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

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    {
        rule = { },
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = clientkeys,
            buttons = clientbuttons,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap+awful.placement.no_offscreen
        }
    },

    -- Floating clients.
    {
        rule_any = {
            instance = {
            "DTA",  -- Firefox addon DownThemAll.
            "copyq",  -- Includes session name in class.
            "pinentry",
            },
            class = {
            "Arandr",
            "Blueman-manager",
            "Gpick",
            "Kruler",
            "MessageWin",  -- kalarm.
            "Sxiv",
            "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
            "Wpa_gui",
            "veromix",
            "xtightvncviewer"},

            -- Note that the name property shown in xprop might be set slightly after creation of the client
            -- and the name shown there might not match defined rules here.
            name = {
            "Event Tester",  -- xev.
            },
            role = {
            "AlarmWindow",  -- Thunderbird's calendar.
            "ConfigManager",  -- Thunderbird's about:config.
            "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
            }
        },
        properties = {
            floating = true
        }
    },

    -- Add titlebars to normal clients and dialogs
    {
        rule_any = {
            type = {
                "normal",
                "dialog"
            }
        },
        properties = {
            titlebars_enabled = true
        }
    },

    -- Set Firefox to always map on the tag named "2" on screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { screen = 1, tag = "2" } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    local bg_normal = beautiful.titlebar_bg_normal
    local bg_focus = beautiful.titlebar_bg_focus
    if c.class == "Alacritty" then
        bg_normal = beautiful.titlebar_bg_terminal
        bg_focus = beautiful.titlebar_bg_terminal
    end

    awful.titlebar(c, {
        size = 24,
        bg_normal = bg_normal,
        bg_focus = bg_focus,
    }) : setup {
        layout = wibox.layout.align.horizontal,
        { -- Left
            widget = wibox.container.margin,
            margins = 4,
            {
                layout  = wibox.layout.fixed.horizontal,
                buttons = buttons,
                awful.titlebar.widget.iconwidget(c),
            }
        },
        { -- Middle
            layout  = wibox.layout.flex.horizontal,
            buttons = buttons,
            { -- Title
                align  = "center",
                widget = (function (c)
                    w = awful.titlebar.widget.titlewidget(c)
                    w.font = "Inter Medium 10"
                    return w
                end)(c),
            },
        },
        { -- Right
            widget = wibox.container.margin,
            margins = 8,
            {
                layout = wibox.layout.fixed.horizontal,
                spacing = 12,
                -- awful.titlebar.widget.stickybutton(c),
                -- awful.titlebar.widget.ontopbutton(c),
                awful.titlebar.widget.floatingbutton(c),
                awful.titlebar.widget.maximizedbutton(c),
                awful.titlebar.widget.closebutton(c),
            },
        },
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

beautiful.useless_gap = 6

-- awful.spawn.with_shell("lxsession")
-- awful.spawn.with_shell("nitrogen --restore")
-- awful.spawn.with_shell("picom -b")
-- awful.spawn.with_shell("nm-applet")
-- awful.spawn.with_shell("volumeicon")
-- awful.spawn.with_shell("cbatticon")