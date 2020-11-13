--[[
  Game: Space Invaders clone
  Author: Fabun Games
  Notes: 
--]]

--require('src.Dependencies')

function love.load()
  math.randomseed(os.time())
  love.graphics.setDefaultFilter('nearest', 'nearest')
  love.window.setTitle('Space Invaders')
end

-- Global quit option
function love.keypressed(key)
  if key == 'escape' then
      love.event.quit()
  end
end