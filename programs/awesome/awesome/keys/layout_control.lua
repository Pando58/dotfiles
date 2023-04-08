local awful = require("awful")

return {
    init = function(mod)
        return {
            awful.key(
                { mod }, "+",
                function () awful.tag.incmwfact(0.02) end,
                { group = "layout", description = "Increase master size" }
            ),
            awful.key(
                { mod }, "=",
                function () awful.tag.incmwfact(0.02) end,
                { group = "layout", description = "Increase master size" }
            ),
            awful.key(
                { mod }, "-",
                function () awful.tag.incmwfact(-0.02) end,
                { group = "layout", description = "Decrease master size" }
            ),
            awful.key(
                { mod, "Shift" }, "+",
                function () awful.tag.incnmaster(1, nil, true) end,
                { group = "layout", description = "Increase the number of master clients" }
            ),
            awful.key(
                { mod, "Shift" }, "=",
                function () awful.tag.incnmaster(1, nil, true) end,
                { group = "layout", description = "Increase the number of master clients" }
            ),
            awful.key(
                { mod, "Shift" }, "-",
                function () awful.tag.incnmaster(-1, nil, true) end,
                { group = "layout", description = "Decrease the number of master clients" }
            ),
            awful.key(
                { mod, "Control" }, "+",
                function () awful.tag.incncol(1, nil, true)    end,
                { group = "layout", description = "Increase the number of columns" }
            ),
            awful.key(
                { mod, "Control" }, "=",
                function () awful.tag.incncol(1, nil, true)    end,
                { group = "layout", description = "Increase the number of columns" }
            ),
            awful.key(
                { mod, "Control" }, "-",
                function () awful.tag.incncol(-1, nil, true)    end,
                { group = "layout", description = "Decrease the number of columns" }
            ),
        }
    end
}
