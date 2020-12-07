Shelter = Class()

function Shelter:init(position)
  self.width = 35
  self.height = 15
  self.x = VIRTUAL_WIDTH / 5 * position - self.width / 2
  self.y = VIRTUAL_HEIGHT - 50
end

function Shelter:render()
  love.graphics.setColor(gColorPalette['white'], 1)
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end