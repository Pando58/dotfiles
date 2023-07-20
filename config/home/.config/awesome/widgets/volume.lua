-- Imports
local utils = require("gears")
local wibox = require("wibox") -- widget framework
local awful = require("awful") -- window management
local theme = require("beautiful")

-- Theme
local font_text = theme.font_mono .. " 9"
local font_icon = theme.font_mono .. " 14"

--

local vol = 0
local mute = true

local function update_icon(widget)
    if mute then
        widget:set_text("󰝟 ")
    elseif vol == 0 then
        widget:set_text("󰸈 ")
    elseif vol <= 33 then
        widget:set_text("󰕿 ")
    elseif vol <= 66 then
        widget:set_text("󰖀 ")
    else
        widget:set_text("󰕾 ")
    end
end

local function update_text(widget)
    widget:set_text("") -- Force re-render
    widget:set_text(vol .. "%")

    if mute then
        widget:set_opacity(0.6)
    else
        widget:set_opacity(1)
    end
end

local widget_volume = wibox.widget({
    widget = wibox.container.margin,
    left = 0,
    right = 3,
    {
        layout = wibox.layout.fixed.horizontal,
        {
            widget = wibox.container.margin,
            left = 3,
            right = -2,
            {
                font = font_icon,
                id = "icon",
                widget = awful.widget.watch(
                    "sh -c 'vol=($(pulsemixer --get-volume)); vol=${vol[0]}; mute=$(pulsemixer --get-mute); echo $vol $mute'",
                    1,
                    function(widget, stdout)
                        local t = {}
                        for s in stdout:gmatch("([^%s]+)") do table.insert(t, s) end

                        vol = tonumber(t[1]) or 0
                        mute = t[2] == "1" and true or false

                        update_icon(widget)
                    end
                ),
            },
        },
        {
            font = font_text,
            id = "text",
            widget = awful.widget.watch(
                "sh -c 'vol=($(pulsemixer --get-volume)); vol=${vol[0]}; mute=$(pulsemixer --get-mute); echo $vol $mute'",
                1,
                function(widget, stdout)
                    local t = {}
                    for s in stdout:gmatch("([^%s]+)") do table.insert(t, s) end

                    vol = tonumber(t[1]) or 9
                    mute = t[2] == "1" and true or false

                    update_text(widget)
                end
            ),
        },
    }
})

widget_volume:buttons(utils.table.join(
    awful.button({}, 1, nil, function()
        local text = widget_volume:get_children_by_id("text")[1]
        local icon = widget_volume:get_children_by_id("icon")[1]

        mute = not mute
        awful.spawn.with_shell("pulsemixer --" .. (mute and "mute" or "unmute"))

        update_icon(icon)
        update_text(text)
    end),
    awful.button({}, 4, nil, function()
        local text = widget_volume:get_children_by_id("text")[1]
        local icon = widget_volume:get_children_by_id("icon")[1]

        vol = math.min(math.max(vol + 1, 0), 100)
        awful.spawn.with_shell("pulsemixer --set-volume " .. vol)

        update_icon(icon)
        update_text(text)
    end),
    awful.button({}, 5, nil, function()
        local text = widget_volume:get_children_by_id("text")[1]
        local icon = widget_volume:get_children_by_id("icon")[1]

        vol = math.min(math.max(vol - 1, 0), 100)
        awful.spawn.with_shell("pulsemixer --set-volume " .. vol)

        update_icon(icon)
        update_text(text)
    end)
))

return widget_volume
