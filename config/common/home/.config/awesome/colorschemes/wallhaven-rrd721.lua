local utils = require("gears")
local main_dir = utils.filesystem.get_configuration_dir()
local theme_lib = dofile(main_dir .. "lib/theme_lib.lua")
local create_palette = theme_lib.create_palette

local colorscheme = {
  base = create_palette(208, 15),
  text = create_palette(207, 20),
  primary = create_palette(207, 15),
  secondary = create_palette(212, 40),
  border = "#b8d1e6",
}

return colorscheme
