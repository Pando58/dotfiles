-- Imports
local wibox = require("wibox") -- widget framework
local awful = require("awful") -- window management
local theme = require("beautiful")

-- Theme
local font_text = theme.font_mono .. " 12"

--

local active = true

local widget_picom = wibox.widget({
    widget = wibox.container.margin,
    left = 3,
    right = -4,
    {
        widget = wibox.widget.textbox,
        markup = "󱜤 ",
        font = font_text,
        id = "text",
    },
})

widget_picom:buttons(
    awful.button({}, 1, nil, function()
        local text = widget_picom:get_children_by_id("text")[1]

        active = not active

        if active then
            awful.spawn.with_shell("picom -b")
            text.markup = "󱜤 "
            text.opacity = 1
        else
            awful.spawn.with_shell("pkill -15 picom")
            text.markup = "󱠎 "
            text.opacity = 0.6
        end
    end)
)

return widget_picom
