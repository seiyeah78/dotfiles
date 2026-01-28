-- https://wezfurlong.org/wezterm/config/files.html
local wezterm = require("wezterm")
local gpus = wezterm.gui.enumerate_gpus()

local font_with_fallback = wezterm.font_with_fallback({
  { family = "HackGen Console NF" },
  { family = "HackGen Console NF", assume_emoji_presentation = true },
  { family = "Noto Color Emoji",   scale = 0.95 }, -- Adjust scale for emojis
  { family = "Nerd Font Symbols",  scale = 0.95 }, -- Adjust scale for icons
})

return {
  font = font_with_fallback,
  underline_thickness = 2,
  -- window_background_opacity = 0.8,
  macos_window_background_blur = 20,
  font_rules = {
    {
      italic = false,
      font = font_with_fallback
    },
  },
  foreground_text_hsb = {
    hue = 1.0,
    saturation = 1.2,
    brightness = 1.5,
  },
  use_ime = true,     -- これがないとIME動かない
  prefer_egl = false, -- これ入れるとrenderingが早くなる
  webgpu_preferred_adapter = gpus[1],
  -- front_end = "WebGpu",
  font_size = 13,
  initial_cols = 150,
  initial_rows = 60,
  color_scheme = "Tokyo Night Storm", -- 自分の好きなテーマ探す https://wezfurlong.org/wezterm/colorschemes/index.html
  colors = {
    cursor_fg = "#000000",
    cursor_bg = "#FFFFFF",
  },
  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  },
  hide_tab_bar_if_only_one_tab = true,
  adjust_window_size_when_changing_font_size = true,
  window_close_confirmation = "NeverPrompt",
  audible_bell = "Disabled",
  keys = {
    { key = "-", mods = "CTRL", action = wezterm.action.DisableDefaultAssignment }, -- バインドを変更しない
    { key = "=", mods = "CTRL", action = wezterm.action.DisableDefaultAssignment }, -- バインドを変更しない
  },
}
