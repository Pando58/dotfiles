local utils = require("gears")
local main_dir = utils.filesystem.get_configuration_dir()

local colorscheme = dofile(main_dir .. "colorschemes/wallhaven-rrd721.lua")

local theme = utils.table.join(
  colorscheme,
  {
    font = "Inter Medium 10",
    font_mono = "JetBrainsMonoNL Nerd Font Mono",

    border_normal = colorscheme.base["850"],
    border_focus = colorscheme.border,
    border_width = 2,
    useless_gap = 4,

    titlebar_bg = colorscheme.base["850"],
    titlebar_fg = colorscheme.text["300"],
    titlebar_bg_focus = colorscheme.base["800"],
    titlebar_fg_focus = colorscheme.text["100"],
  },
  dofile(main_dir .. "themes/common/layout_images.lua"),
  dofile(main_dir .. "themes/common/titlebar_images.lua")
)

return theme
