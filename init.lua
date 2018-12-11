wm = hs.eventtap.new({hs.eventtap.event.types.flagsChanged}, function (evt)
  if evt:getKeyCode() ~= 60 then
    return false
  end
  if evt:getRawEventData().NSEventData.modifierFlags ~= 131332 then
    return false
  end

  hs.grid.setGrid('2x2').show()

  return true;
end)
wm:start()

escWithEisu = hs.eventtap.new({hs.eventtap.event.types.keyDown}, function (evt)
  if evt:getKeyCode() ~= 53 then
    return false
  end

  hs.eventtap.keyStroke({}, 102, 1000)

  return false
end)
escWithEisu:start()

c_lbracketWithEisu = hs.eventtap.new({hs.eventtap.event.types.keyDown}, function (evt)
  if evt:getKeyCode() ~= 33 then
    return false
  end
  if not evt:getFlags()['ctrl'] then
    return false
  end
  if hs.fnutils.every(evt:getFlags(), function (_, f) return f == 'ctrl' end) == false then
    return false
  end

  hs.eventtap.keyStroke({}, 102, 1000)

  return false
end)
c_lbracketWithEisu:start()

windowHint = hs.eventtap.new({hs.eventtap.event.types.flagsChanged}, function (evt)
  if evt:getKeyCode() ~= 61 then
    return false
  end
  if evt:getRawEventData().NSEventData.modifierFlags ~= 524608 then
    return false
  end

  hs.hints.showTitleThresh = 100
  hs.hints.windowHints()

  return false
end)
windowHint:start()
