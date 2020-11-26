EnemyFormation = Class{}

function EnemyFormation:init()
  self.x = 0
  self.y = 0
  self.rows = 2
  self.cols = 6
  self.xMin = 0
  self.xMax = self.cols * 40 - 20
  self.yMin = 0
  self.yMax = self.rows * 30 - 10
  self.dx = 20
  self.spacing = 2
  self.enemy = self:generateEnemyFormation(self.cols, self.rows, self.spacing)
  self.timer = 0
  self.stepTime = .4
  self.accelerator = 0.9
  self.xStep = (VIRTUAL_WIDTH - (ENEMY_WIDTH * (self.spacing * (self.cols - 1) + 1))) / 20
  self.yStep = 10
  self.edgeFlag = false
  self.stepFlag = true
  self.width = self.cols * 40 - 20
end

function EnemyFormation:update(dt)
  self.timer = self.timer + dt

  self.xMin = self:xMinCheck()
  self.xMax = self:xMaxCheck()

  -- Simple timer to "step" the enemyFormation across screen and toggle edgeFlag
  if self.timer > self.stepTime then
    if not self.edgeFlag then
      self.x = self.x + self.xStep
    elseif self.edgeFlag then
      self.y = self.y + self.yStep
      self.stepTime = self.stepTime * self.accelerator
      self.edgeFlag = false
    end
    self.timer = 0
    self.stepFlag = not self.stepFlag
  end

  -- Track position of bounding box to move Enemy instances as a group vs. individually
  --if self.x + ENEMY_WIDTH * (self.spacing * (self.cols - 1) + 1) >= VIRTUAL_WIDTH then
  if self.x + self.width >= VIRTUAL_WIDTH then
    self.edgeFlag = true
    self.xStep = -self.xStep
    self.x = VIRTUAL_WIDTH - ENEMY_WIDTH * (self.spacing * self.cols - 1) - 1
  elseif self.x + self.xMin < 0 then
    self.edgeFlag = true
    self.xStep = -self.xStep
    self.x = 1 - self.xMin
  end
end

-- Pass x, y coordinates of the enemyFormation box for Enemy instances to use as a reference point.
function EnemyFormation:render()
  for key, enemy in ipairs(self.enemy) do
    if enemy.isActive then
      enemy:render(self.x, self.y, self.stepFlag)
    end
  end
end

-- Function to generate all enemy instances within the formation
function EnemyFormation:generateEnemyFormation()
  local enemies = {}
  for row=1, self.rows do
    for col=1, self.cols do
      table.insert(enemies, Enemy(row, col, self.spacing))
    end
  end
  return enemies
end

-- Function to determine the leftmost x position of enemy formation
function EnemyFormation:xMinCheck()
  for col=1, self.cols do
    for row=1, self.rows do
      if self.enemy[(col - 1) + (row - 1) * self.cols + 1].isActive then
        return ((col - 1) * 40)
      end
    end
  end
end

-- Function to determine the rightmost x position of enemy formation
function EnemyFormation:xMaxCheck()
  for col=self.cols, 1, -1 do
    for row=self.rows, 1, -1 do
      if self.enemy[(col - 1) + (row - 1) * self.cols + 1].isActive then
        return (col * 40)
      end
    end
  end
end