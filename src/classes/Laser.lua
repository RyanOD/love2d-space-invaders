Laser = Class{}

function Laser:init(x, y)
  self.width = 2
  self.height = 10
  self.x = x
  self.y = y
  self.dy = 150
end

function Laser:update(dt)
  self.y = self.y - self.dy * dt
end

function Laser:render()
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

function Laser:collision(formation, target)
  if self.y > formation.y + target.yOffset + target.height then
    return false
  elseif self.y + self.height < formation.y + target.yOffset then
    return false
  elseif self.x + self.width < formation.x + target.xOffset then
    return false
  elseif self.x > formation.x + target.xOffset + target.width then
    return false
  end

  return true
end