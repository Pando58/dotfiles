local wezterm = require "wezterm"

function merge_tables(t1, t2)
  for k, v in pairs(t2) do
    t1[k] = v
  end
end

local config = wezterm.config_builder and wezterm.config_builder() or {}

merge_tables(config, {
  window_background_opacity = 0.85,
  window_padding = {
    left = 6,
    right = 6,
    top = 6,
    bottom = 6,
  },
  adjust_window_size_when_changing_font_size = false,

  color_scheme = "Everblush (Gogh)",
  colors = {
    cursor_fg = "black",
  },

  font = wezterm.font({ family = "JetBrainsMonoNL NF" }),
  font_size = 10,
  freetype_load_flags = "NO_HINTING",
  bold_brightens_ansi_colors = false,
  warn_about_missing_glyphs = false,

  default_cursor_style = "BlinkingBar",
  cursor_thickness = 1,
  cursor_blink_rate = 500,
  cursor_blink_ease_in = "Constant",
  cursor_blink_ease_out = "Constant",

  disable_default_key_bindings = true,
  keys = {
    { mods = "CTRL|SHIFT", key = "c", action = wezterm.action.CopyTo("Clipboard") },
    { mods = "CTRL|SHIFT", key = "v", action = wezterm.action.PasteFrom("Clipboard") },
    { mods = "CTRL", key = "=", action = wezterm.action.IncreaseFontSize },
    { mods = "CTRL", key = "-", action = wezterm.action.DecreaseFontSize },
    { mods = "CTRL", key = "0", action = wezterm.action.ResetFontSize },
    { mods = "CTRL|SHIFT", key = "x", action = wezterm.action.ActivateCopyMode },
  },

  default_prog = { "fish" },
  set_environment_variables = {
    SHELL = "fish",
    EDITOR = "nvim",
  },

  enable_tab_bar = false,
  check_for_updates = false,
})

return config
