GameOverState = Class{__includes = BaseState}

function GameOverState:init()

end

function GameOverState:render()
  love.graphics.setFont(gFonts['title'])

  love.graphics.setColor(60/255, 60/255, 73/255)
  love.graphics.printf('Game Over', 0, VIRTUAL_HEIGHT / 2 - 97, VIRTUAL_WIDTH + 5, 'center')
  
  love.graphics.setColor(gColorPalette['yellow'])
  love.graphics.printf('Game Over', 0, VIRTUAL_HEIGHT / 2 - 100, VIRTUAL_WIDTH, 'center')

end