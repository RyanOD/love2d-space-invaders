Laser = Class{}

function Laser:init(x, y, direction, dy)
  self.width = 2
  self.height = 10
  self.x = x
  self.y = y
  self.dy = dy or 150
  self.direction = direction
  self.isVisible = false
end

function Laser:update(dt)
  self.y = self.y + self.dy * dt * self.direction
  if self.y < 0 then
    self:resetLaser()
  end
end

function Laser:render()
  if self.isVisible then
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
  end
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

function Laser:fireLaser(x, y)
  self.isVisible = true
  self.x = x
  self.y = y
end

function Laser:resetLaser()
  self.isVisible = false
  self.x = 0
  self.y = 0
end