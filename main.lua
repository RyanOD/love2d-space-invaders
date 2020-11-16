--[[
  Game: Space Invaders clone
  Author: Fabun Games
  Notes: 
--]]

require('src.Dependencies')

function love.load()
  math.randomseed(os.time())
  love.graphics.setDefaultFilter('nearest', 'nearest')
  love.window.setTitle('Space Invaders')

  push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
    vsync = true,
    fullscreen = false,
    resizable = true
  })
  
  gTextures = {
    ['background'] = love.graphics.newImage('graphics/background.png')
  }

  gFonts = {
    ['title'] = love.graphics.newFont('fonts/mandalore.ttf', 56)
  }

  gStateMachine = StateMachine{
    ['start']  = function() return StartState() end
  }

  gStateMachine:change('start')

end

-- Global quit option
function love.keypressed(key)
  if key == 'escape' then
      love.event.quit()
  end
end

function love.update()
  gStateMachine:update(dt)
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