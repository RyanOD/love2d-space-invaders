Laser = Class{}

function Laser:init(x, y, direction)
  self.width = 2
  self.height = 10
  self.x = x
  self.y = y
  self.dy = 150
  self.direction = direction
end

function Laser:update(dt)
  self.y = self.y - self.dy * dt * self.direction
end

function Laser:render()
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

function Laser:collision(xMin, xMax, yMin, yMax)
  if self.y + self.height < yMin then
    return false
  elseif self.y > yMax then
    return false
  elseif self.x + self.height < xMin then
    return false
  elseif self.x > xMax then
    return false
  end

  return true
end