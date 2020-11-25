PlayState = Class{includes = BaseState}

function PlayState:enter(params)
  self.base = Base()
  self.lasers = {}
  self.enemies = Enemies()
end

function PlayState:update(dt)
  self.base:update(dt)

  if love.keyboard.wasPressed('return') then
    table.insert(self.lasers, Laser(self.base.x + 0.5 * self.base.width, self.base.y))
  end

  for k, laser in pairs(self.lasers) do
    laser:update(dt)
  end

  self.enemies:update(dt)
  
  for k, enemy in pairs(self.enemies.enemy) do
    enemy:update(dt)
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

  --for k, enemy in pairs(self.enemies.enemy) do
    --enemy:render()
  --end
  self.enemies:render()
  love.graphics.setFont(gFonts['menu'])
  for key,text in pairs(self.lasers) do
    love.graphics.printf('Lasers: ' .. tostring(table.getn(self.lasers)), 0, VIRTUAL_HEIGHT / 2 + 40, VIRTUAL_WIDTH, 'center')
  end

  love.graphics.printf('Box' .. self.enemies.x, 0, VIRTUAL_HEIGHT / 2 + 80, VIRTUAL_WIDTH, 'center')

end