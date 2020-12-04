PlayState = Class{__includes = BaseState}

function PlayState:enter(params)
  self.starfield = Starfield()
  self.base = Base()
  self.shelter = Shelter()
  self.enemyFormation = EnemyFormation()
  self.score = 0
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
      self.score = self.score + 10
    end
  end

  for key, laser in ipairs(self.enemyFormation.enemyLasers) do
    if laser:collision(self.base.x, self.base.x + self.base.width, self.base.y, self.base.y + self.base.height) then
      gStateMachine:change('gameover')
    end

    if laser:collision(self.base.laser.x, self.base.laser.x + self.base.laser.width, self.base.laser.y, self.base.laser.y + self.base.laser.height) then
      laser:resetLaser()
      self.base.laser:resetLaser()
    end

    for _, shelter in ipairs(self.shelter.shelters) do
      if laser:collision(shelter.x, shelter.x + self.shelter.width, shelter.y, shelter.y + self.shelter.height) then
        laser:resetLaser()
      elseif self.base.laser:collision(shelter.x, shelter.x + self.shelter.width, shelter.y, shelter.y + self.shelter.height) then
        self.base.laser:resetLaser()
      end
    end
  end
end

function PlayState:render()
  self.starfield:render()
  self.base:render()
  self.enemyFormation:render()
  self.shelter:render()

  love.graphics.setFont(gFonts['stats'])
  love.graphics.printf('Score: ' .. self.score, 0, 5, VIRTUAL_WIDTH - 40, 'right')
end