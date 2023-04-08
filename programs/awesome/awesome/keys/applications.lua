local awful = require("awful")

return {
    init = function(mod)
        return {
            awful.key(
                { mod }, "space",
                function () awful.spawn("sh ".. os.getenv("HOME") .."/.config/rofi/launcher/launcher.sh") end,
                { group = "launcher", description = "Show menubar" }
            ),
            awful.key(
                { mod }, "t",
                function () awful.spawn("alacritty") end,
                { group = "launcher", description = "Launch terminal (Alacritty)" }
            ),
            awful.key(
                { mod }, "b",
                function () awful.spawn("brave") end,
                { group = "launcher", description = "Launch web browser (Brave)" }
            ),
            awful.key(
                { mod, "Shift" }, "b",
                function () awful.spawn("brave --incognito") end,
                { group = "launcher", description = "Launch web browser as incognito (Brave)" }
            ),
            awful.key(
                { mod, "Mod1" }, "e",
                function () awful.spawn("pcmanfm") end,
                { group = "launcher", description = "Launch file explorer (PCManFM)" }
            ),
            awful.key(
                { mod, "Mod1" }, "s",
                function () awful.spawn("flameshot gui") end,
                { group = "launcher", description = "Take a screenshot (Flameshot)" }
            ),
            awful.key(
                { "Shift" }, "Print",
                function () awful.spawn("flameshot screen") end,
                { group = "launcher", description = "Take a screenshot of the current screen" }
            ),
            awful.key(
                { }, "Print",
                function () awful.spawn("flameshot screen -c") end,
                { group = "launcher", description = "Copy to the clipboard a screenshot of the current screen" }
            )
        }
    end
}
