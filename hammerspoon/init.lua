hs.window.animationDuration = 0

local move_mash = {"ctrl", "shift"}
local move_window_mash = {"ctrl", "alt"}

local MOVE_PIXEL = 100

function move_left ()
  local win = hs.window.focusedWindow()
  if win ~= nil then
    local f = win:frame()
    f.x = f.x - MOVE_PIXEL
    win:setFrame(f)
    --hs.console.setConsole(tostring(hs.window.focusedWindow()))
  end
end

function move_right ()
  local win = hs.window.focusedWindow()
  if win ~= nil then
    local f = win:frame()
    f.x = f.x + MOVE_PIXEL
    win:setFrame(f)
  end
end

function move_up ()
  local win = hs.window.focusedWindow()
  if win ~= nil then
    local f = win:frame()
    f.y = f.y - MOVE_PIXEL
    win:setFrame(f)
  end
end

function move_down ()
  local win = hs.window.focusedWindow()
  if win ~= nil then
    local f = win:frame()
    f.y = f.y + MOVE_PIXEL
    win:setFrame(f)
  end
end

function move_screen()
  local win = hs.window.focusedWindow()
  if win ~= nil then
    local sc = win:screen()
    win:moveToScreen(sc:next())
  end
end

function half_window(eventName, params)
  win = hs.window.filter.new():getWindows()[1]
  if win then
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()
    f.x = max.x
    f.y = max.y
    f.w = max.w / 2
    f.h = max.h
    if params["position"] == "right" then
      f.x = f.x + f.w
    end
    win:setFrame(f):focus()
  end
end

function half_window_h(eventName, params)
  win = hs.window.filter.new():getWindows()[1]
  if win then
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()
    f.x = max.x
    f.y = max.y
    f.w = max.w
    f.h = max.h / 2
    if params["position"] == "bottom" then
      f.y = f.y + f.h
    end
    win:setFrame(f):focus()
  end
end

hs.urlevent.bind("maximize_window", function(eventName, params)
  win = hs.window.filter.new():getWindows()[1]
  if win ~= nil then
    win:maximize():focus()
  end
end)
hs.urlevent.bind("half_window", half_window)
hs.urlevent.bind("half_window_h", half_window_h)

-- hs.hotkey.bind(move_mash, "H", move_left, nil, move_left)

-- hs.hotkey.bind(move_mash, "L", move_right, nil, move_right)

-- hs.hotkey.bind(move_mash, "J", move_down, nil, move_down)

-- hs.hotkey.bind(move_mash, "K", move_up, nil, move_up)

hs.hotkey.bind(move_window_mash, "/", move_screen, nil, nil)

hs.keycodes.inputSourceChanged(function()
  local m = hs.keycodes.currentMethod()
  if m then
    hs.alert.closeAll(0)
    uuid = hs.alert.show(hs.keycodes.currentMethod(), 0.5)
  end
end)

-- debug

function table.val_to_str ( v )
  if "string" == type( v ) then
    v = string.gsub( v, "\n", "\\n" )
    if string.match( string.gsub(v,"[^'\"]",""), '^"+$' ) then
      return "'" .. v .. "'"
    end
    return '"' .. string.gsub(v,'"', '\\"' ) .. '"'
  else
    return "table" == type( v ) and table.tostring( v ) or
      tostring( v )
  end
end

function table.key_to_str ( k )
  if "string" == type( k ) and string.match( k, "^[_%a][_%a%d]*$" ) then
    return k
  else
    return "[" .. table.val_to_str( k ) .. "]"
  end
end

function table.tostring( tbl )
  local result, done = {}, {}
  for k, v in ipairs( tbl ) do
    table.insert( result, table.val_to_str( v ) )
    done[ k ] = true
  end
  for k, v in pairs( tbl ) do
    if not done[ k ] then
      table.insert( result,
        table.key_to_str( k ) .. "=" .. table.val_to_str( v ) )
    end
  end
  return "{" .. table.concat( result, "," ) .. "}"
end

