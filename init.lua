local function min (table)
  local key = next(table)
  local min = table[key]
  for k, v in pairs(table) do
    if (v < min) then
      key, min = k, v
    end
  end
  return min, key
end

local function eventtapModKeySinglePress (key, callback)
  return hs.eventtap.new({hs.eventtap.event.types.flagsChanged}, function (event)
    if event:getKeyCode() ~= key.keyCode then
      return false
    end
    if event:getRawEventData().NSEventData.modifierFlags ~= 256 then
      return false
    end
    return callback()
  end)
end

local function computeNextTile (window, tiles)
  local tilesAsGeometry = hs.fnutils.map(tiles, function (tile)
    return window:screen():fromUnitRect(tile)
  end)
  local currentTileId = hs.fnutils.indexOf(tilesAsGeometry, window:frame())

  if (not currentTileId) then
    local points = hs.fnutils.map(tilesAsGeometry, function (geom)
      return window:frame():distance(geom.topleft)
    end)
    local _, nearestTileId = min(points)
    return tiles[nearestTileId], false
  end

  local nextTile = tiles[currentTileId + 1]
  if (not nextTile) then
    return tiles[1], true
  end

  return nextTile, false
end

local function applyTilingRule (tiles)
  return function ()
    local win = hs.window.focusedWindow()

    local nextTile, shouldMoveNextScreen = computeNextTile(win, tiles)

    if (shouldMoveNextScreen) then
      hs.grid.pushWindowNextScreen()
    end
    win:moveToUnit(nextTile)
  end
end

local handleKeys = {
  rcmd = {keyCode = 54, keyDownFlag = 1048848},
  roption = {keyCode = 61, keyDownFlag = 524608},
  rshift = {keyCode = 60, keyDownFlag = 131332},
}
local rules = {
  only = {
    '[0.5, 1, 99.5, 99]',
  },
  vs = {
    '[0.5, 1, 49.75, 99]',
    '[50.25, 1, 99.5, 99]',
  },
}

roptionSingle = eventtapModKeySinglePress(handleKeys.roption, applyTilingRule(rules.only))
roptionSingle:start()
rshiftSingle = eventtapModKeySinglePress(handleKeys.rshift, applyTilingRule(rules.vs))
rshiftSingle:start()
