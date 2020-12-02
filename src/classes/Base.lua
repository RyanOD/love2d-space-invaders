Base = Class{}

function Base:init()
  self.x = VIRTUAL_WIDTH / 2
  self.y = VIRTUAL_HEIGHT / 2 + 100
  self.width = 10
  self.height = 20
  self.dx = 120
  self.laser = Laser(self.x + 0.5 * self.width, self.y, -1, 250)
end

function Base:update(dt)
  if love.keyboard.isDown('left') and self.x > 0 then
    self.x = self.x - self.dx * dt
  elseif love.keyboard.isDown('right') and self.x < VIRTUAL_WIDTH - self.width then
    self.x = self.x + self.dx * dt
  end

  if love.keyboard.wasPressed('space') and not self.laser.isVisible then
    self.laser:fireLaser(self.x + 0.5 * self.width, self.y, 150, -1)
  end
end

function Base:render()
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
  self.laser:render()
end