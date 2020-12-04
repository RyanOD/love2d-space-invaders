Enemy = Class{}

function Enemy:init(width, height, row, col, spacing)
  self.xOffset = (col - 1) * ENEMY_WIDTH * spacing
  self.yOffset = (row - 1) * ENEMY_HEIGHT * spacing
  self.width = width
  self.height = height
  self.isActive = true
  self.isShooter = false
end

function Enemy:render(formationX, formationY, stepFlag)
  if stepFlag then
    love.graphics.setColor(gColorPalette['yellow'], 1)
  else
    love.graphics.setColor(gColorPalette['lgreen'], 1)
  end
  love.graphics.rectangle("fill", formationX + self.xOffset, formationY + self.yOffset, self.width, self.height)
end