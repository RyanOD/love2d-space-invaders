StartState = Class{__includes = BaseState}

function StartState:init()

end

function StartState:render()
  love.graphics.setFont(gFonts['title'])
  love.graphics.setColor(60/255, 60/255, 73/255)
  love.graphics.printf('Space Invaders', 0, VIRTUAL_HEIGHT / 2 - 97, VIRTUAL_WIDTH + 5, 'center')
  love.graphics.setColor(184/255, 255/255, 73/255)
  love.graphics.printf('Space Invaders', 0, VIRTUAL_HEIGHT / 2 - 100, VIRTUAL_WIDTH, 'center')
end