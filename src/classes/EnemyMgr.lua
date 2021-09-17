EnemyMgr = Class{}

function EnemyMgr:init()
  self.x = 10
  self.y = 20
  self.rows = 2
  self.cols = 2
  self.enemyCount = self.rows * self.cols
  self.xMin = 0
  self.xMax = self.cols * 40 - 20
  self.yMin = 0
  self.yMax = self.rows * 30 - 10
  --self.dx = 30
  self.spacing = 2
  self.enemy = self:generateEnemies()
  self.timer = 0
  self.stepTime = 1
  self.accelerator = 0.9
  self.xStep = (VIRTUAL_WIDTH - (ENEMY_WIDTH * (self.spacing * (self.cols - 1) + 1))) / 20
  self.yStep = 10
  self.edgeFlag = false
  self.stepFlag = true
  self.width = self.cols * 40 - 20
  self.enemyLasers = {}
end

function EnemyMgr:update(dt)
  self.timer = self.timer + dt

  -- # is the length operator in Lua
  if self.enemyCount == 0 then
    gStateMachine:change('win')
  else
    self.xMin = self:xMinCheck()
    self.xMax = self:xMaxCheck()
  end
  
  -- Simple timer to "step" the EnemyMgr across screen and toggle edgeFlag
  if self.timer > self.stepTime then
    if not self.edgeFlag then
      self.x = self.x + self.xStep
      for key, enemy in ipairs(self.enemy) do
        enemy.x = enemy.x + self.xStep
      end
    elseif self.edgeFlag then
      self.y = self.y + self.yStep
      for key, enemy in ipairs(self.enemy) do
        enemy.y = enemy.y + self.yStep
      end
      self.stepTime = self.stepTime * self.accelerator
      self.edgeFlag = false
    end

    self:fireEnemyLaser()
    self.timer = 0
    self.stepFlag = not self.stepFlag
  end

  for key, laser in pairs(self.enemyLasers) do
    laser:update(dt)
  end

  -- Track position of bounding box to move Enemy instances as a group vs. individually
  if self.x + self.xMax >= VIRTUAL_WIDTH then
    self.edgeFlag = true
    self.xStep = -self.xStep
    self.x = VIRTUAL_WIDTH - self.xMax - 1
  elseif self.x + self.xMin < 0 then
    self.edgeFlag = true
    self.xStep = -self.xStep
    self.x = 1 - self.xMin
  end
end

-- Pass x, y coordinates of the EnemyMgr box for Enemy instances to use as a reference point.
function EnemyMgr:render()
 for key, enemy in ipairs(self.enemy) do
    if enemy.isActive then
      enemy:render(self.stepFlag)
    end
  end

  -- Track enemy lasers that hit the ground and trigger explosion
  for key, laser in pairs(self.enemyLasers) do
    if laser.y + laser.height > VIRTUAL_HEIGHT - 10 then
      table.remove(self.enemyLasers, key)
    end
    
    laser:render()
  end

  love.graphics.print("Enemies = " .. self.enemyCount, VIRTUAL_WIDTH / 2, VIRTUAL_HEIGHT - 100)
end

-- Function to generate all enemy instances within the formation
function EnemyMgr:generateEnemies()
  local enemies = {}
  for row=1, self.rows do
    for col=1, self.cols do
      table.insert(enemies, Enemy(row, col, self.spacing))
    end
  end
  return enemies
end

-- Function to determine the leftmost x position of enemy formation
function EnemyMgr:xMinCheck()
  for col=1, self.cols do
    for row=1, self.rows do
      if self.enemy[(col - 1) + (row - 1) * self.cols + 1].isActive then
        return ((col - 1) * 40)
      end
    end
  end
end

-- Function to determine the rightmost x position of enemy formation
function EnemyMgr:xMaxCheck()
  for col=self.cols, 1, -1 do
    for row=self.rows, 1, -1 do
      if self.enemy[(col - 1) + (row - 1) * self.cols + 1].isActive then
        return (col * 40) - 20
      end
    end
  end
end

function EnemyMgr:fireEnemyLaser()
  local shooter = self:selectShooter()
  local laser = Laser(shooter.xOffset + shooter.width * 0.5 + self.x, shooter.yOffset + shooter.height + self.y, 1)
  laser.isVisible = true
  table.insert(self.enemyLasers, laser)
end

function EnemyMgr:selectShooter()
  while true do
    local col = math.random(self.cols)
    for row = self.rows, 1, -1 do
      if self.enemy[(row-1) * self.cols + col].isActive then
        return self.enemy[(row-1) * self.cols + col]
      end
    end
  end
end