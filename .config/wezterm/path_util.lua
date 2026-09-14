-- 📌 使い方
local wezterm = require 'wezterm'

local M = {}

-- vim.fs.normalize の代わりとなる関数
function M.normalize(path)
  if not path then return nil end
  path = path:gsub("\\", "/")
  if path:sub(1, 1) == "~" then
    path = wezterm.home_dir .. path:sub(2)
  end
  return path:gsub("//+", "/")
end

return M
