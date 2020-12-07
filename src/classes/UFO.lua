UFO = Class{}

function UFO:init()
  self.x = -30
  self.y = 15
  self.dx = 70
  self.height = 5
  self.width = 25
  self.timer = 0
end

function UFO:update(dt)
  self.timer = self.timer + dt
  if self.timer > 5 then
    self.x = self.x + dt * self.dx
  end
end

function UFO:render()
  love.graphics.setColor(gColorPalette['lgreen'], 1)
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end