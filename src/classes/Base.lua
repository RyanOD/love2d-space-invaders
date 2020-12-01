Base = Class{}

function Base:init()
  self.x = VIRTUAL_WIDTH / 2
  self.y = VIRTUAL_HEIGHT / 2 + 100
  self.width = 10
  self.height = 20
  self.dx = 120
  self.laser = Laser(self.x + 0.5 * self.width, self.y, -1)
end

function Base:update(dt)
  if love.keyboard.isDown('left') and self.x > 0 then
    self.x = self.x - self.dx * dt
  elseif love.keyboard.isDown('right') and self.x < VIRTUAL_WIDTH - self.width then
    self.x = self.x + self.dx * dt
  end

  if not self.laser.isVisible then
    self.laser.x = self.x + 0.5 * self.width
  end

  if love.keyboard.wasPressed('space') and not self.laser.isVisible then
    self.laser.isVisible = true
  end

  if self.laser.isVisible then
    self.laser:update(dt)
  end

  if self.laser.y < 0 then
    self:laserReset()
  end
end

function Base:render()
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height )
  love.graphics.printf('Laser y = ' .. tostring(self.laser.x), 0, VIRTUAL_HEIGHT / 2 + 80, VIRTUAL_WIDTH, 'center')
  self.laser:render()
end

function Base:laserReset()
  self.laser.isVisible = false
  self.laser.x = self.x + 0.5 * self.width
  self.laser.y = self.y
end