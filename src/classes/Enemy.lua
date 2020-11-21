Enemy = Class{}

function Enemy:init(x, y)
  self.x = x
  self.y = y
  self.width = 8
  self.height = 8
  self.dx = 140
end

function Enemy:render()
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

function Enemy:update(dt)
  self.x = self.x + self.dx * dt
end