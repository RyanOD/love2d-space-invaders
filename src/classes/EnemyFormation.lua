EnemyFormation = Class{}

function EnemyFormation:init()
  self.x = 0
  self.y = 0
  self.dx = 20
  self.rows = 2
  self.cols = 6
  self.spacing = 2
  self.enemy = generateEnemyFormation(self.cols, self.rows, self.spacing)
  self.timer = 0
  self.stepTime = 1
  self.accelerator = 0.9
  self.xStep = (VIRTUAL_WIDTH - (ENEMY_WIDTH * (self.spacing * (self.cols - 1) + 1))) / 20
  self.yStep = 10
  self.edgeFlag = false
  self.stepFlag = true
end

function EnemyFormation:update(dt)
  self.timer = self.timer + dt

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
  if self.x + ENEMY_WIDTH * (self.spacing * (self.cols - 1) + 1) >= VIRTUAL_WIDTH then
    self.edgeFlag = true
    self.xStep = -self.xStep
    self.x = VIRTUAL_WIDTH - ENEMY_WIDTH * (self.spacing * self.cols - 1) - 1
  elseif self.x < 0 then
    self.edgeFlag = true
    self.xStep = -self.xStep
    self.x = 1
  end
end

-- Pass x, y coordinates of the enemyFormation box for Enemy instances to use as a reference point.
function EnemyFormation:render()
  for key, enemy in ipairs(self.enemy) do
    enemy:render(self.x, self.y, self.stepFlag)
  end
end

-- Separate function to generate all enemy instances within the enemy formation
function generateEnemyFormation(cols, rows, spacing)
  local enemies = {}
  for col=0, cols - 1 do
    for row=0, rows - 1 do
      table.insert(enemies, Enemy(col, row, spacing))
    end
  end
  return enemies
end