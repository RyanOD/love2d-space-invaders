PlayState = Class{includes = BaseState}

function PlayState:enter(params)
  self.base = Base()
  self.lasers = {}
  self.enemyFormation = EnemyFormation()
end

function PlayState:update(dt)
  self.base:update(dt)

  if love.keyboard.wasPressed('return') then
    table.insert(self.lasers, Laser(self.base.x + 0.5 * self.base.width, self.base.y, 1))
  end

  for k, laser in pairs(self.lasers) do
    laser:update(dt)
  end

  self.enemyFormation:update(dt)
  
  for k, laser in ipairs(self.lasers) do
    for j, enemy in ipairs(self.enemyFormation.enemy) do
      if laser:collision(self.enemyFormation.x + enemy.xOffset, self.enemyFormation.x + enemy.xOffset + enemy.width, self.enemyFormation.y + enemy.yOffset, self.enemyFormation.y + enemy.yOffset + enemy.height) then
        --table.remove(self.enemyFormation.enemy, key)
        enemy.isActive = false
        table.remove(self.lasers, k)
      end
    end
  end

  for key, laser in ipairs(self.enemyFormation.enemyLasers) do
    if laser:collision(self.base.x, self.base.x + self.base.width, self.base.y, self.base.y + self.base.height) then
      love.event.quit()
    end
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

  self.enemyFormation:render()

  love.graphics.setFont(gFonts['menu'])
  love.graphics.setColor( gColorPalette['dgreen'], 1)
  for key,text in pairs(self.lasers) do
    love.graphics.printf('Lasers: ' .. tostring(table.getn(self.lasers)), 0, VIRTUAL_HEIGHT / 2 + 40, VIRTUAL_WIDTH, 'center')
  end

  love.graphics.printf('xMin = ' .. tostring(self.enemyFormation.xMin), 0, VIRTUAL_HEIGHT / 2 + 80, VIRTUAL_WIDTH, 'center')
  love.graphics.printf('xMax = ' .. tostring(self.enemyFormation.xMax), 0, VIRTUAL_HEIGHT / 2 + 100, VIRTUAL_WIDTH, 'center')
end