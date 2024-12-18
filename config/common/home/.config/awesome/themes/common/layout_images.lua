local gfs = require("gears.filesystem")
local themes_dir = gfs.get_themes_dir()

return {
    layout_fairh = themes_dir .. "default/layouts/fairhw.png",
    layout_fairv = themes_dir .. "default/layouts/fairvw.png",
    layout_floating  = themes_dir .. "default/layouts/floatingw.png",
    layout_magnifier = themes_dir .. "default/layouts/magnifierw.png",
    layout_max = themes_dir .. "default/layouts/maxw.png",
    layout_fullscreen = themes_dir .. "default/layouts/fullscreenw.png",
    layout_tilebottom = themes_dir .. "default/layouts/tilebottomw.png",
    layout_tileleft   = themes_dir .. "default/layouts/tileleftw.png",
    layout_tile = themes_dir .. "default/layouts/tilew.png",
    layout_tiletop = themes_dir .. "default/layouts/tiletopw.png",
    layout_spiral  = themes_dir .. "default/layouts/spiralw.png",
    layout_dwindle = themes_dir .. "default/layouts/dwindlew.png",
    layout_cornernw = themes_dir .. "default/layouts/cornernww.png",
    layout_cornerne = themes_dir .. "default/layouts/cornernew.png",
    layout_cornersw = themes_dir .. "default/layouts/cornersww.png",
    layout_cornerse = themes_dir .. "default/layouts/cornersew.png",
}
