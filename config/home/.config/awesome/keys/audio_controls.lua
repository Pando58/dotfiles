local awful = require("awful")

return {
    init = function (mod)
        return {
            awful.key(
                { }, "XF86AudioRaiseVolume",
                function () awful.spawn("pulsemixer --change-volume +5") end,
                { group = "launcher", description = "Raise system volume" }
            ),
            awful.key(
                { }, "XF86AudioLowerVolume",
                function () awful.spawn("pulsemixer --change-volume -5") end,
                { group = "launcher", description = "Reduce system volume" }
            ),
            awful.key(
                { }, "XF86AudioMute",
                function () awful.spawn("pulsemixer --toggle-mute") end,
                { group = "launcher", description = "Reduce system volume" }
            ),
            awful.key(
                { }, "XF86AudioPlay",
                function () awful.spawn("playerctl play-pause") end,
                { group = "launcher", description = "Reduce system volume" }
            ),
        }
    end
}
