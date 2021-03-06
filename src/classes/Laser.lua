Laser = Class{}

function Laser:init(x, y, direction, dy)
  self.width = 2
  self.height = 10
  self.x = x
  self.y = y
  self.dy = dy or 150
  self.direction = direction
  self.isVisible = false

  self.psystem = love.graphics.newParticleSystem(gTextures['particle'], 64)
  self.psystem:setParticleLifetime(0.5, 1)
  self.psystem:setLinearAcceleration(-15, 0, 15, 80)
  self.psystem:setEmissionArea('normal', 10, 10)
end

function Laser:update(dt)
  self.y = self.y + self.dy * dt * self.direction
  if self.y < 0 then
    self:resetLaser()
  end
  self.psystem:update(dt)
end

function Laser:render()
  if self.isVisible then
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
  end
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

function Laser:renderParticles()
  love.graphics.draw(self.psystem, self.x + 16, self.y + 8)
end