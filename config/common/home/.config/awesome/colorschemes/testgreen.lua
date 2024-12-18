local utils = require("gears")
local main_dir = utils.filesystem.get_configuration_dir()
local theme_lib = dofile(main_dir .. "lib/theme_lib.lua")
local create_palette = theme_lib.create_palette

local colorscheme = {
  base = create_palette(220, 12),
  text = create_palette(220, 4),
  primary = create_palette(118, 18),
  secondary = create_palette(38, 70),
  border = "#7dd979",
}

return colorscheme
