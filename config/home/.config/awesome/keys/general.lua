local awful = require("awful")
local awesome = awesome

return {
    init = function (mod)
        return {
            awful.key(
                { mod, "Control" }, "r",
                awesome.restart,
                { group = "awesome", description = "Reload awesome" }
            ),
        }
    end
}
