--[[
  Game: Space Invaders clone
  Author: Fabun Games
  Notes: 
--]]

require('src.Dependencies')

function love.load()
  love.keyboard.keysPressed = {}
  math.randomseed(os.time())
  love.graphics.setDefaultFilter('nearest', 'nearest')
  love.window.setTitle('Space Invaders')

  -- START: Boilerplate global screen setup with Push library --
  push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
    vsync = true,
    fullscreen = false,
    resizable = true
  })
  -- END --
  
  gColorPalette = {
    ['yellow'] = {255/255, 255/255, 51/255},
    ['black'] = {7/255, 7/255, 8/255},
    ['lgreen'] = {85/255, 170/255, 68/255},
    ['dgreen'] = {71/255, 85/255, 34/255}
  }

  gTextures = {
    ['background'] = love.graphics.newImage('graphics/background.png')
  }

  gFonts = {
    ['title'] = love.graphics.newFont('fonts/mandalore.ttf', 56),
    ['menu'] = love.graphics.newFont('fonts/gameplay.ttf', 14)
  }

  gStateMachine = StateMachine{
    ['start']  = function() return StartState() end,
    ['play'] = function() return PlayState() end
  }

  gStateMachine:change('start')

end

function love.update(dt)
  -- START: Boilerplate recurring call to current state update --
  gStateMachine:update(dt)
  -- END --

  if love.keyboard.wasPressed('escape') then
    love.event.quit()
  end

  -- START: Boilerplate global quit and keyboard monitoring functionality --
  function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
  end

  love.keyboard.keysPressed = {}
  -- END --

  -- START: Boilerplate global window resize function --
  function love.resize(w, h)
    push:resize(w, h)
  end
  -- END --
end

function love.draw()
  push:apply('start')
    local backgroundWidth = gTextures['background']:getWidth()
    local backgroundHeight = gTextures['background']:getHeight()

    love.graphics.draw(gTextures['background'], 0, 0, 0, VIRTUAL_WIDTH/(backgroundWidth - 1), VIRTUAL_HEIGHT/(backgroundHeight - 1))

    gStateMachine:render()
  push:apply('end')
end

function love.render()

end

-- START: Boilerplate boolean function to detect keyboard keys pressed --
function love.keyboard.wasPressed(key)
  if love.keyboard.keysPressed[key] then
    return true
  end
  return false
end
-- END --