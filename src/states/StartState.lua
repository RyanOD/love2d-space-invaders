StartState = Class{__includes = BaseState}

function StartState:init()

end

function StartState:update(dt)
  if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
    gStateMachine:change('play')
  end
end

function StartState:render()
  love.graphics.setFont(gFonts['title'])

  love.graphics.setColor(60/255, 60/255, 73/255)
  love.graphics.printf('Place Invaders', 0, VIRTUAL_HEIGHT / 2 - 97, VIRTUAL_WIDTH + 5, 'center')
  
  love.graphics.setColor(gColorPalette['yellow'])
  love.graphics.printf('Place Invaders', 0, VIRTUAL_HEIGHT / 2 - 100, VIRTUAL_WIDTH, 'center')

  love.graphics.setFont(gFonts['menu'])
  love.graphics.printf('Press enter to start game', 0, VIRTUAL_HEIGHT / 2 + 40, VIRTUAL_WIDTH, 'center')
  love.graphics.setFont(gFonts['instructions'])
  love.graphics.printf('Use space bar to fire lasers', 0, VIRTUAL_HEIGHT / 2 + 70, VIRTUAL_WIDTH, 'center')

end