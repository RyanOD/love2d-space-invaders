PlayState = Class{includes = BaseState}

function PlayState:enter(params)
  self.base = Base()
  self.enemyFormation = EnemyFormation()
  self.starfield = Starfield()
end

function PlayState:update(dt)
  self.base:update(dt)
  if self.base.laser.isVisible then
    self.base.laser:update(dt)
  end
  self.enemyFormation:update(dt)
  
  for key, enemy in ipairs(self.enemyFormation.enemy) do
    if self.base.laser:collision(self.enemyFormation.x + enemy.xOffset, self.enemyFormation.x + enemy.xOffset + enemy.width, self.enemyFormation.y + enemy.yOffset, self.enemyFormation.y + enemy.yOffset + enemy.height) and enemy.isActive and self.base.laser.isVisible then
      enemy.isActive = false
      self.base.laser:resetLaser()
    end
  end

  for key, laser in ipairs(self.enemyFormation.enemyLasers) do
    if laser:collision(self.base.x, self.base.x + self.base.width, self.base.y, self.base.y + self.base.height) then
      love.event.quit()
    end

    if laser:collision(self.base.laser.x, self.base.laser.x + self.base.laser.width, self.base.laser.y, self.base.laser.y + self.base.laser.height) then
      love.event.quit()
    end
  end


end

function PlayState:render()
  self.base:render()
  self.enemyFormation:render()
  self.starfield:render()

  love.graphics.setFont(gFonts['menu'])
  love.graphics.setColor(gColorPalette['dgreen'], 1)
  ---for key,text in pairs(self.lasers) do
    --love.graphics.printf('Lasers: ' .. tostring(table.getn(self.lasers)), 0, VIRTUAL_HEIGHT / 2 + 40, VIRTUAL_WIDTH, 'center')
  --end

  --love.graphics.printf('xMin = ' .. tostring(self.enemyFormation.xMin), 0, VIRTUAL_HEIGHT / 2 + 80, VIRTUAL_WIDTH, 'center')
end