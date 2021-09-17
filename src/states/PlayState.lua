PlayState = Class{__includes = BaseState}

function PlayState:enter(params)
  self.starfield = Starfield()
  self.base = Base()
  self.shelterMgr = ShelterMgr()
  self.enemyMgr = EnemyMgr()
  self.score = 0
  self.ufo = UFO()
  self.timer = 0
end

function PlayState:update(dt)
  self.base:update(dt)
  self.ufo:update(dt)

  if self.enemyMgr.enemyCount == 0 then
    gStateMachine:change('win')
  end

  if self.base.laser.isVisible then
    self.base.laser:update(dt)
  end
  self.enemyMgr:update(dt)
  
  -- Check for collisions at the PlayState level as the Laser objects and the Enemy objects are both accessable
  for key, enemy in ipairs(self.enemyMgr.enemy) do
    if self:collision(self.base.laser, enemy) and enemy.isActive and self.base.laser.isVisible then
      enemy.isActive = false
      self.base.laser:resetLaser()
      self.score = self.score + 10
      self.enemyMgr.enemyCount = self.enemyMgr.enemyCount - 1
    end
  end

  for key, laser in ipairs(self.enemyMgr.enemyLasers) do
    if self:collision(laser, self.base) then
      gStateMachine:change('gameover')
    end

    if self:collision(laser, self.base.laser) and laser.isVisible and self.base.laser.isVisible then
      laser:resetLaser()
      self.base.laser:resetLaser()
      self.score = self.score + 5
    end

    -- The underscore is used as a throwaway variable here.
    for _, shelter in ipairs(self.shelterMgr.shelters) do
      if self:collision(laser, shelter) then
        laser:resetLaser()
      elseif self:collision(self.base.laser, shelter) then
        self.base.laser:resetLaser()
      end
    end
  end
end

function PlayState:render()
  --self.starfield:render()
  self.base:render()
  self.enemyMgr:render()
  self.shelterMgr:render()
  self.ufo:render()

  love.graphics.setFont(gFonts['stats'])
  love.graphics.printf('Score: ' .. self.score, 0, 5, VIRTUAL_WIDTH - 40, 'right')

  love.graphics.setColor(gColorPalette['white'])
  love.graphics.rectangle('fill', 0, VIRTUAL_HEIGHT - 10, VIRTUAL_WIDTH, 1)
end

function PlayState:collision(object1, object2)
  if object1.y + object1.height < object2.y then
    return false
  elseif object1.y > object2.y + object2.height then
    return false
  elseif object1.x + object1.width < object2.x then
    return false
  elseif object1.x > object2.x + object2.width then
    return false
  end
  return true
end