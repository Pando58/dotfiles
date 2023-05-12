-- Imports
local utils = require("gears")
local wibox = require("wibox") -- widget framework
local awful = require("awful") -- window management
local theme = require("beautiful")

local client = client

-- Theming
local col_bg = theme.base["950"] .. "BB"
local col_text = theme.text["100"]
local col_text_disabled = theme.text["100"] .. "70"
local col_taskbar_active = theme.primary["350"]
local col_taskbar_inactive = theme.base["700"]

local font_text = theme.font_mono .. " 9"
local font_separators = theme.font_mono .. " 19"
local font_tags = theme.font_mono .. " 11"
local font_icon_launcher = theme.font_mono .. " 14"

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
                if c == client.focus then
                    c.minimized = true
                else
                    c:emit_signal(
                        "request::activate",
                        "tasklist",
                        { raise = true }
                    )
                end
            end),
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
            markup = "<span></span>",
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
        bg = "#0000",
    })

    bar:setup({
        layout = wibox.layout.align.horizontal,
        {
            layout = wibox.layout.fixed.horizontal,
            {
                widget = wibox.container.background,
                bg = col_bg,
                {
                    widget = wibox.container.margin,
                    right = 8,
                    {
                        layout = wibox.layout.fixed.horizontal,
                        spacing = 8,
                        wLayout,
                        {
                            widget = wibox.container.margin,
                            right = 7,
                            wTags,
                        },
                        wTaskbar,
                    },
                },
            },
            {
                widget = wibox.widget.textbox,
                markup = "<span color='" .. col_bg .. "'></span>",
                font = font_separators,
                forced_width = 30,
            },
        },
        {
            widget = wibox.container.background,
            bg = "#00000000",
        },
        {
            layout = wibox.layout.fixed.horizontal,
            {
                widget = wibox.widget.textbox,
                markup = "<span color='" .. col_bg .. "'></span>",
                align = "right",
                font = font_separators,
                forced_width = 30,
            },
            {
                widget = wibox.container.background,
                bg = col_bg,
                {
                    widget = wibox.container.margin,
                    left = 8,
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
            },
        },
    })
end

return {
    init = init,
}
