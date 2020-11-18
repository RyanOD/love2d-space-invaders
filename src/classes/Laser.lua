Laser = Class{}

function Laser:init(x)
  self.x = x
  self.y = VIRTUAL_HEIGHT / 2 + 50
  self.width = 2
  self.height = 10
  self.dy = 150
end

function Laser:update(dt)
  self.y = self.y - self.dy * dt
end

function Laser:render()
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end