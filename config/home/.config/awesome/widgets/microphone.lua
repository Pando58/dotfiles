-- Imports
local wibox = require("wibox") -- widget framework
local awful = require("awful") -- window management
local theme = require("beautiful")

-- Theme
local font_icon = theme.font_mono .. " 13"

--

local mute = true

local function update_icon(widget)
    if not mute then
        widget:set_text("󰍬 ")
        widget:set_opacity(1)
    else
        widget:set_text("󰍭 ")
        widget:set_opacity(0.6)
    end
end

local widget_microphone = wibox.widget({
    widget = wibox.container.margin,
    left = 3,
    right = -6,
    {
        font = font_icon,
        id = "icon",
        widget = awful.widget.watch(
            'sh -c "id=$(pulsemixer --list-sources | grep Default | sed \'s/.*ID: //;s/\\,.*//\'); pulsemixer --id $id --get-mute"',
            1,
            function(widget, stdout)
                mute = stdout:gsub("%s+", "") == "1" and true or false

                update_icon(widget)
            end
        ),
    },
})

widget_microphone:buttons(
    awful.button({}, 1, nil, function()
        local icon = widget_microphone:get_children_by_id("icon")[1]

        mute = not mute

        awful.spawn.with_shell(
            "id=$(pulsemixer --list-sources | grep Default | sed 's/.*ID: //;s/\\,.*//'); pulsemixer --id $id --" ..
            (mute and "mute" or "unmute"))

        update_icon(icon)
    end)
)

return widget_microphone
