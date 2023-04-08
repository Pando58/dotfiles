local awful = require("awful")

return {
    init = function(mod)
        return {
            -- Move window focus
            awful.key(
              { mod }, "a",
              function () awful.client.focus.global_bydirection("left") end,
              { group = "client", description = "Focus left window" }
            ),
            awful.key(
              { mod }, "d",
              function () awful.client.focus.global_bydirection("right") end,
              { group = "client", description = "Focus right window" }
            ),
            awful.key(
              { mod }, "w",
              function () awful.client.focus.global_bydirection("up") end,
              { group = "client", description = "Focus the window above" }
            ),
            awful.key(
              { mod }, "s",
              function () awful.client.focus.global_bydirection("down") end,
              { group = "client", description = "Focus the window below" }
            ),

            -- Swap windows
            awful.key(
              { mod, "Shift" }, "a",
              function () awful.client.swap.global_bydirection("left") end,
              { group = "client", description = "Focus left window" }
            ),
            awful.key(
              { mod, "Shift" }, "d",
              function () awful.client.swap.global_bydirection("right") end,
              { group = "client", description = "Focus right window" }
            ),
            awful.key(
              { mod, "Shift" }, "w",
              function () awful.client.swap.global_bydirection("up") end,
              { group = "client", description = "Focus the window above" }
            ),
            awful.key(
              { mod, "Shift" }, "s",
              function () awful.client.swap.global_bydirection("down") end,
              { group = "client", description = "Focus the window below" }
            ),

            -- Move screen focus
            awful.key(
              { mod }, "q",
              function () awful.screen.focus_relative(-1) end,
              { group = "screen", description = "Focus left screen" }
            ),
            awful.key(
              { mod }, "e",
              function () awful.screen.focus_relative(1) end,
              { group = "screen", description = "Focus right screen" }
            ),
        }
    end
}
