Enemy = Class{}

function Enemy:init(col, row, spacing)
  self.xOffset = col * ENEMY_WIDTH * spacing
  self.yOffset = row * ENEMY_HEIGHT * spacing
  self.width = ENEMY_WIDTH
  self.height = ENEMY_HEIGHT
end

function Enemy:update(dt)

end

function Enemy:render(formationX, formationY, stepFlag)
  if stepFlag then
    love.graphics.setColor( gColorPalette['yellow'], 1)
  else
    love.graphics.setColor( gColorPalette['lgreen'], 1)
  end
  love.graphics.rectangle("fill", formationX + self.xOffset, formationY + self.yOffset, self.width, self.height)
end