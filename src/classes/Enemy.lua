Enemy = Class{}

function Enemy:init(x, y, width, height, dx)
  self.x = x * 2
  self.y = y * 2
  self.width = width
  self.height = height
  self.dx = dx
end

function Enemy:update(dt)
  self.x = self.x + self.dx * dt
end

function Enemy:render()
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end