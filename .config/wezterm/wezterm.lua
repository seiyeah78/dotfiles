-- https://wezfurlong.org/wezterm/config/files.html
local wezterm = require 'wezterm';
local gpus = wezterm.gui.enumerate_gpus()

return {
  default_prog = {'/usr/local/bin/zsh'},
  font = wezterm.font_with_fallback({"RictyDiminishedDiscord Nerd Font", "The font with those symbols"}),
  -- font = wezterm.font("RictyDiminishedDiscord Nerd Font"), -- 自分の好きなフォントいれる
  use_ime = true, -- これがないとIME動かない
  -- prefer_egl = false, -- これ入れるとrenderingが早くなる
  webgpu_preferred_adapter = gpus[1],
  front_end = "WebGpu",
  font_size = 14.5,
  initial_cols = 150,
  initial_rows = 60,
  color_scheme = "NightOwl (Gogh)", -- 自分の好きなテーマ探す https://wezfurlong.org/wezterm/colorschemes/index.html
  force_reverse_video_cursor = false, -- カーソル上の配色を逆転させる
  colors = {
    cursor_fg = '#000000',
    cursor_bg = '#FFFFFF',
  },
  hide_tab_bar_if_only_one_tab = true,
  adjust_window_size_when_changing_font_size = true,
  window_close_confirmation = "NeverPrompt",
  keys = {
    { key = '-', mods = 'CTRL', action = wezterm.action.DisableDefaultAssignment }, -- バインドを変更しない
    { key = '=', mods = 'CTRL', action = wezterm.action.DisableDefaultAssignment }, -- バインドを変更しない
  }
}
