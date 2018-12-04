local handleKeys = {
  rcmd = {keyCode = 54, keyDownFlag = 1048848},
  roption = {keyCode = 61, keyDownFlag = 524608},
  rshift = {keyCode = 60, keyDownFlag = 131332},
}

eventtap = hs.eventtap.new({hs.eventtap.event.types.flagsChanged}, function (event)
  if event:getKeyCode() ~= handleKeys.roption.keyCode then
    return false
  end
  if event:getRawEventData().NSEventData.modifierFlags ~= handleKeys.roption.keyDownFlag then
    return false
  end

  local win = hs.window.focusedWindow()
  local tileUnit = '[0.5, 1, 99.5, 99]'

  if (win:frame() == win:screen():fromUnitRect(tileUnit)) then
    hs.grid.pushWindowNextScreen()
    win:moveToUnit(tileUnit)
  else
    win:moveToUnit(tileUnit)
  end

  return true
end)
eventtap:start()
