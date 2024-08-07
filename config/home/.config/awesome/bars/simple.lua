-- Imports
local utils = require("gears")
local wibox = require("wibox") -- widget framework
local awful = require("awful") -- window management
local theme = require("beautiful")

local main_dir = utils.filesystem.get_configuration_dir()

local widget_volume = dofile(main_dir .. "widgets/volume.lua")
local widget_microphone = dofile(main_dir .. "widgets/microphone.lua")
local widget_picom = dofile(main_dir .. "widgets/picom.lua")

local client = client

-- Theming
local col_bg = theme.base["950"] .. "BB"
local col_text = theme.text["100"]
local col_text_disabled = theme.text["100"] .. "70"
local col_taskbar_active = theme.primary["350"]
local col_taskbar_inactive = theme.base["700"]

local font_text = theme.font_mono .. " 9"
local font_separators = theme.font_mono .. " 19"
local font_tags = theme.font_mono .. " 15"
local font_icon_launcher = theme.font_mono .. " 18"

theme.bg_systray = col_bg
theme.systray_icon_spacing = 8

-- Tags widget
local function wTagsCallback(self, tag, index, tags)
    local wIcon = self:get_children_by_id('icon')[1]

    local text = next(tag:clients()) ~= nil and "" or ""
    local color = tag.selected and col_text or col_text_disabled

    wIcon.markup = "<span color='" .. color .. "'>" .. text .. "</span>"
end

local function init(s, config)
    -- Tags widget
    local wTags = awful.widget.taglist({
        screen = s,
        filter = awful.widget.taglist.filter.all,
        widget_template = {
            create_callback = wTagsCallback,
            update_callback = wTagsCallback,

            layout = wibox.container.margin,
            left = 0,
            right = 4,
            top = 0,
            {
                widget = wibox.widget.textbox,
                font = font_tags,
                forced_width = 18, -- prevent color glitches and text clipping
                align = "center",
                id = "icon",
            },
        },
        buttons = utils.table.join(
            awful.button({}, 1, function(t) t:view_only() end),
            awful.button({}, 3, awful.tag.viewtoggle),
            awful.button({}, 4, function(t) awful.tag.viewprev(t.screen) end),
            awful.button({}, 5, function(t) awful.tag.viewnext(t.screen) end)
        ),
    })

    -- Taskbar widget
    local function wTaskbarCallback(self, c, index, objects)
        local icon = self:get_children_by_id('icon')[1]
        local bg = self:get_children_by_id('bg')[1]

        icon.client = c

        if client.focus == c then
            bg.bg = col_taskbar_active
        else
            bg.bg = col_taskbar_inactive
        end
    end

    local wTaskbar = awful.widget.tasklist({
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags,
        layout = {
            layout = wibox.layout.fixed.horizontal,
            spacing = 2,
        },
        widget_template = {
            create_callback = wTaskbarCallback,
            update_callback = wTaskbarCallback,

            layout = wibox.layout.align.vertical,
            nil,
            {
                widget = wibox.container.margin,
                left   = 5,
                right  = 2,
                top    = 6,
                bottom = 4,
                {
                    widget = awful.widget.clienticon,
                    id = 'icon',
                },
            },
            {
                widget = wibox.container.background,
                id = "bg",
                forced_height = 2,
                wibox.widget.base.make_widget(),
            },
        },
        buttons = utils.table.join(
            awful.button({}, 1, function(c)
                -- if c == client.focus then
                --     c.minimized = true
                -- else
                c:emit_signal(
                    "request::activate",
                    "tasklist",
                    { raise = true }
                )
                -- end
            end),
            awful.button({}, 3, function() awful.menu.client_list({ theme = { width = 250 } }) end),
            awful.button({}, 4, function() awful.client.focus.byidx(-1) end),
            awful.button({}, 5, function() awful.client.focus.byidx(1) end)
        ),
    })


    -- Focused window taskbar widget
    local function wFocusedWindowBarCallback(self, c, index, objects)
        local icon = self:get_children_by_id("icon")[1]
        local title = self:get_children_by_id("title")[1]
        local btn_floating = self:get_children_by_id("btn_floating")[1]
        local btn_maximized = self:get_children_by_id("btn_maximized")[1]
        local btn_close = self:get_children_by_id("btn_close")[1]

        icon.client = c
        title.markup = "<span color='" .. col_text .. "'>" .. c.name .. "</span>"
        btn_floating.children = { awful.titlebar.widget.floatingbutton(c) }
        btn_maximized.children = { awful.titlebar.widget.maximizedbutton(c) }
        btn_close.children = { awful.titlebar.widget.closebutton(c) }

        title:buttons(utils.table.join(
            awful.button({}, 1, function() awful.titlebar.toggle(c) end)
        ))
    end

    local wFocusedWindowBar = awful.widget.tasklist({
        screen = s,
        filter = awful.widget.tasklist.filter.focused,
        widget_template = {
            create_callback = wFocusedWindowBarCallback,
            update_callback = wFocusedWindowBarCallback,

            widget = wibox.container.margin,
            left = 0,
            right = 6,
            {
                layout = wibox.layout.fixed.horizontal,
                spacing = 12,
                {
                    widget = wibox.container.margin,
                    margins = 6,
                    {
                        widget = awful.widget.clienticon,
                        id = "icon",
                    },
                },
                {
                    widget = wibox.container.constraint,
                    width = 240,
                    {
                        widget = wibox.widget.textbox,
                        font = font_text,
                        id = "title",
                    },
                },
                {
                    widget = wibox.container.margin,
                    top = 6,
                    bottom = 4,
                    {
                        layout = wibox.layout.fixed.horizontal,
                        {
                            widget = wibox.container.margin,
                            id = "btn_floating",
                        },
                        {
                            widget = wibox.container.margin,
                            id = "btn_maximized",
                        },
                        {
                            widget = wibox.container.margin,
                            id = "btn_close",
                        },
                    }
                }
            }
        },
        buttons = utils.table.join(
            awful.button({}, 3, function() awful.menu.client_list({ theme = { width = 250 } }) end),
            awful.button({}, 4, function() awful.client.focus.byidx(-1) end),
            awful.button({}, 5, function() awful.client.focus.byidx(1) end)
        ),
    })

    -- Current layout widget
    local wLayout = wibox.container.margin(awful.widget.layoutbox(s), 6, 6, 6, 6)

    wLayout:buttons(utils.table.join(
        awful.button({}, 1, function() awful.layout.inc(1) end),
        awful.button({}, 3, function() awful.layout.inc(-1) end),
        awful.button({}, 4, function() awful.layout.inc(1) end),
        awful.button({}, 5, function() awful.layout.inc(-1) end)
    ))

    -- Launcher button widget
    local wLauncher = wibox.widget({
        widget = wibox.container.margin,
        left = 8,
        right = 5,
        top = -1,
        {
            widget = wibox.widget.textbox,
            markup = "<span>󱄅</span>",
            font = font_icon_launcher,
            forced_width = 20,
        },
    })

    wLauncher:connect_signal("button::press", function(_, _, _, button)
        if button == 1 then
            awful.spawn(config.launcher)
        end
    end)

    -- Create bar
    local bar = awful.wibar({
        screen = s,
        position = "top",
        height = 30,
        bg = col_bg,
    })

    bar:setup({
        layout = wibox.layout.align.horizontal,
        expand = "none",
        {
            widget = wibox.container.margin,
            left = 0,
            right = 0,
            {
                layout = wibox.layout.fixed.horizontal,
                spacing = 0,
                wLayout,
                wTags,
                {
                    widget = wibox.container.margin,
                    left = 12,
                    right = 6,
                    wTaskbar,
                },
            },
        },
        wFocusedWindowBar,
        {
            widget = wibox.container.margin,
            left = 12,
            {
                layout = wibox.layout.fixed.horizontal,
                {
                    layout = wibox.layout.fixed.horizontal,
                    spacing = 16,
                    {
                        widget = wibox.container.margin,
                        top = 6,
                        bottom = 6,
                        wibox.widget.systray(),
                    },
                    {
                        widget = wibox.container.margin,
                        left = 6,
                        right = 6,
                        {
                            layout = wibox.layout.fixed.horizontal,
                            spacing = 12,
                            widget_picom,
                            widget_microphone,
                            widget_volume,
                        },
                    },
                    wibox.widget.textclock(
                        "<span font='" .. font_text .. "' color='" .. col_text .. "'>%a %b %d, %H:%M:%S </span>",
                        1 -- Refresh rate - default: 60
                    ),
                },
                {
                    widget = wibox.container.margin,
                    left = 0, -- 6
                    wLauncher,
                },
            },
        },
    })
end

return {
    init = init,
}
