WinState = Class{__includes = BaseState}

function WinState:enter(params)
  self.winText = "Congratulations, you win!"
  self.startText = 'Press enter to play again'
end

function WinState:update(dt)
  if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
    gStateMachine:change('play')
  end
end

function WinState:render()
  love.graphics.setFont(gFonts['title'])

  love.graphics.setColor(60/255, 60/255, 73/255)
  love.graphics.printf(self.winText, 0, VIRTUAL_HEIGHT / 2 - 97, VIRTUAL_WIDTH + 5, 'center')
  
  love.graphics.setColor(gColorPalette['yellow'])
  love.graphics.printf(self.winText, 0, VIRTUAL_HEIGHT / 2 - 100, VIRTUAL_WIDTH, 'center')

  love.graphics.setFont(gFonts['menu'])
  love.graphics.printf(self.startText, 0, VIRTUAL_HEIGHT / 2 + 40, VIRTUAL_WIDTH, 'center')
end