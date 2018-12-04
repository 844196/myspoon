eventtap = hs.eventtap.new({hs.eventtap.event.types.flagsChanged}, function (event)
  if event:getKeyCode() ~= 60 then
    return false
  end
  if event:getRawEventData().NSEventData.modifierFlags ~= 131332 then
    return false
  end

  hs.logger.new('my', 'debug').i('keydown rshift')
  return true
end)
eventtap:start()
