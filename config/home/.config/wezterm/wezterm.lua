local wezterm = require "wezterm"
local act = wezterm.action

local function merge_tables(t1, t2)
  for k, v in pairs(t2) do
    t1[k] = v
  end
end

local function basename(s)
  return string.gsub(s, '(.*[/\\])(.*)', '%2')
end

local process_icons = {
  ["fish"] = wezterm.nerdfonts.md_fish,              -- 󰈺
  ["bash"] = wezterm.nerdfonts.cod_terminal_bash,    -- 
  ["tmux"] = wezterm.nerdfonts.cod_terminal_tmux,    -- 
  ["nvim"] = wezterm.nerdfonts.custom_vim,           -- 
  ["vim"] = wezterm.nerdfonts.dev_vim,               -- 
  ["git"] = wezterm.nerdfonts.md_git,                -- 󰊢
  ["lazygit"] = wezterm.nerdfonts.md_git,            -- 󰊢
  [".man-wrapped"] = wezterm.nerdfonts.fa_book,      -- 
  ["nix"] = wezterm.nerdfonts.linux_nixos,           -- 
  ["node"] = wezterm.nerdfonts.md_nodejs,            -- 󰎙
  ["lua"] = wezterm.nerdfonts.md_language_lua,       -- 󰢱
  ["python"] = wezterm.nerdfonts.seti_python,        -- 
  ["python3"] = wezterm.nerdfonts.seti_python,       -- 
  ["docker"] = wezterm.nerdfonts.linux_docker,       -- 
  ["docker-compose"] = wezterm.nerdfonts.dev_docker, -- 
}

local window_padding = 6
local window_opacity = 0.9
local window_bg_rgb = "28, 28, 30"
local window_bg = "rgb(" .. window_bg_rgb .. ")"
local window_bg_alpha = "rgba(" .. window_bg_rgb .. ", 0)"
local tab_bg = "767d99"
local tab_fg = window_bg
local tab_bg_focus = "a5e179"
local tab_fg_focus = window_bg
local newtab_bg = "292c3c"
local newtab_fg = "626880"
local newtab_bg_hover = "2d3042"
local newtab_fg_hover = "939cbd"

local config = wezterm.config_builder and wezterm.config_builder() or {}

merge_tables(config, {
  term = "wezterm",

  window_background_opacity = window_opacity,
  window_padding = {
    left = window_padding,
    right = window_padding,
    top = window_padding,
    bottom = window_padding,
  },
  adjust_window_size_when_changing_font_size = false,

  color_scheme = "Everblush (Gogh)",
  colors = (function()
    local t = wezterm.color.get_builtin_schemes()["Everblush (Gogh)"]

    merge_tables(t, {
      background = window_bg,
      cursor_fg = "black",
      tab_bar = {
        background = window_bg_alpha,
      },
    })

    t.ansi[1] = "2b2f38" -- Black
    t.brights[1] = "474e5c"

    t.brights[3] = tab_bg_focus -- Green

    return t
  end)(),

  window_frame = {
    border_bottom_height = "0.375cell",
    border_bottom_color = window_bg_alpha,
  },

  use_fancy_tab_bar = false,
  tab_bar_at_bottom = true,
  tab_max_width = 32,
  tab_bar_style = {
    new_tab = wezterm.format({
      { Background = { Color = newtab_bg } },
      { Foreground = { Color = window_bg_alpha } },
      { Text = "" },
      { Background = { Color = newtab_bg } },
      { Foreground = { Color = newtab_fg } },
      { Attribute = { Intensity = "Bold" } },
      { Text = " + " },
      { Background = { Color = window_bg_alpha } },
      { Foreground = { Color = newtab_bg } },
      { Text = "" },
    }),
    new_tab_hover = wezterm.format({
      { Background = { Color = newtab_bg_hover } },
      { Foreground = { Color = window_bg_alpha } },
      { Text = "" },
      { Background = { Color = newtab_bg_hover } },
      { Foreground = { Color = newtab_fg_hover } },
      { Attribute = { Intensity = "Bold" } },
      { Text = " + " },
      { Background = { Color = window_bg_alpha } },
      { Foreground = { Color = newtab_bg_hover } },
      { Text = "" },
    }),
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
  leader = {
    mods = "SHIFT",
    key = "Space",
    timeout_milliseconds = 1000,
  },
  keys = {
    { mods = "CTRL|SHIFT",        key = "c", action = act.CopyTo("Clipboard") },
    { mods = "CTRL|SHIFT",        key = "v", action = act.PasteFrom("Clipboard") },

    { mods = "LEADER|SHIFT",      key = "+", action = act.IncreaseFontSize },
    { mods = "LEADER|SHIFT",      key = "_", action = act.DecreaseFontSize },
    { mods = "LEADER|SHIFT",      key = ")", action = act.ResetFontSize },

    { mods = "LEADER|SHIFT",      key = ">", action = act.ActivateTabRelative(1) },
    { mods = "LEADER|SHIFT",      key = "<", action = act.ActivateTabRelative(-1) },
    { mods = "LEADER|CTRL|SHIFT", key = ">", action = act.MoveTabRelative(1) },
    { mods = "LEADER|CTRL|SHIFT", key = "<", action = act.MoveTabRelative(-1) },

    { mods = "LEADER|SHIFT",      key = "s", action = act.SplitPane({ direction = "Right" }) },
    { mods = "LEADER|SHIFT",      key = "v", action = act.SplitPane({ direction = "Down" }) },
    { mods = "LEADER|CTRL|SHIFT", key = "s", action = act.SplitPane({ direction = "Right", command = { args = { "fish" } }, }) },
    { mods = "LEADER|CTRL|SHIFT", key = "v", action = act.SplitPane({ direction = "Down", command = { args = { "fish" } }, }) },
    { mods = "LEADER|SHIFT",      key = "h", action = act.ActivatePaneDirection("Left") },
    { mods = "LEADER|SHIFT",      key = "j", action = act.ActivatePaneDirection("Down") },
    { mods = "LEADER|SHIFT",      key = "k", action = act.ActivatePaneDirection("Up") },
    { mods = "LEADER|SHIFT",      key = "l", action = act.ActivatePaneDirection("Right") },
    { mods = "LEADER|SHIFT",      key = "m", action = act.PaneSelect({ mode = "SwapWithActive" }) },

    { mods = "LEADER|SHIFT",      key = "n", action = act.SpawnTab("DefaultDomain") },
    { mods = "LEADER|CTRL|SHIFT", key = "n", action = act.SpawnCommandInNewTab({ args = { "fish" } }) },
    { mods = "LEADER|SHIFT",      key = "q", action = act.CloseCurrentPane({ confirm = true }) },
  },

  default_prog = { "tmux" },
  set_environment_variables = {
    EDITOR = "nvim",
  },

  check_for_updates = false,
})

wezterm.on(
  "format-tab-title",
  function(tab, tabs, panes, cfg, hover, max_width)
    local title = (tab.tab_title and #tab.tab_title > 0)
        and tab.tab_title
        or tab.active_pane.title

    return {
      { Background = { Color = tab.is_active and tab_bg_focus or tab_bg } },
      { Foreground = { Color = window_bg } },
      { Text = (tab.tab_index == 0 and "" or "") },
      { Foreground = { Color = tab.is_active and tab_fg_focus or tab_fg } },
      { Attribute = { Intensity = "Bold" } },
      { Text = " " .. tab.tab_index + 1 .. " " },
      { Attribute = { Intensity = "Normal" } },
      { Text = string.sub(title, 1, tab.tab_index == 0 and 25 or 26) .. " " },
      { Background = { Color = window_bg } },
      { Foreground = { Color = tab.is_active and tab_bg_focus or tab_bg } },
      { Text = "" },
    }
  end
)

wezterm.on('update-status', function(window, pane)
  local process_name = basename(pane:get_foreground_process_name())

  window:set_left_status(wezterm.format({
    { Background = { Color = window_bg } },
    { Text = " " .. (process_icons[process_name] or process_name) .. " " },
  }))
end)

return config
