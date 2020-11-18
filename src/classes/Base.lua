Base = Class{}

function Base:init()
  self.x = VIRTUAL_WIDTH / 2
  self.y = VIRTUAL_HEIGHT / 2 + 100
  self.width = 10
  self.height = 20
  self.dx = 120
end

function Base:update(dt)
  if love.keyboard.isDown('left') and self.x > 0 then
    self.x = self.x - self.dx * dt
  elseif love.keyboard.isDown('right') and self.x < VIRTUAL_WIDTH - self.width then
    self.x = self.x + self.dx * dt
  end
end

function Base:render()
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height )
end