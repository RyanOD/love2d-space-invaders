PlayState = Class{includes = BaseState}

function PlayState:enter(params)
  self.base = Base()
  self.lasers = {}
end

function PlayState:update(dt)
  self.base:update(dt)

  if love.keyboard.wasPressed('return') then
    table.insert(self.lasers, Laser(self.base.x + 0.5 * self.base.width, self.base.y))
  end

  for k, laser in pairs(self.lasers) do
    laser:update(dt)
  end
end

function PlayState:render()
  self.base:render()
  for k, laser in pairs(self.lasers) do
    if laser.y < 0 then
      table.remove(self.lasers, k)
    end
    laser:render()
  end

  love.graphics.setFont(gFonts['menu'])
  for key,text in pairs(self.lasers) do
    love.graphics.printf('Lasers: ' .. tostring(table.getn(self.lasers)), 0, VIRTUAL_HEIGHT / 2 + 40, VIRTUAL_WIDTH, 'center')
  end
end