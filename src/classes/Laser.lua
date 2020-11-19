Laser = Class{}

function Laser:init(x, y)
  self.width = 2
  self.height = 10
  self.x = x - self.width / 2
  self.y = y - self.height - 2
  self.dy = 150
end

function Laser:update(dt)
  self.y = self.y - self.dy * dt
end

function Laser:render()
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end