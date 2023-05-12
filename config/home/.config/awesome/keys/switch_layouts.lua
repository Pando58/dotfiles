local awful = require("awful")

return {
    init = function (mod)
        return {
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
        }
    end
}
