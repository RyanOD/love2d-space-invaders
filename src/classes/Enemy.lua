Enemy = Class{}

--pass in the Mgr x and y and use to set the x and y of the Enemy instances


function Enemy:init(row, col, spacing)
  self.xOffset = (col - 1) * ENEMY_WIDTH * spacing
  self.yOffset = (row - 1) * ENEMY_HEIGHT * spacing
  self.x = self.xOffset
  self.y = self.yOffset
  self.width = 20
  self.height = 20
  self.isActive = true
  self.isShooter = false
end

function Enemy:update(formationX, dt)
  self.x = self.x + formationX
end

function Enemy:render(stepFlag)
  if stepFlag then
    love.graphics.setColor(gColorPalette['yellow'], 1)
  else
    love.graphics.setColor(gColorPalette['lgreen'], 1)
  end
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end