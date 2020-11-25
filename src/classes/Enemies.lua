Enemies = Class{}

function Enemies:init()
  self.x = 0
  self.y = 0
  self.dx = 40
  self.height = 20
  self.width = 20
  self.rows = 4
  self.cols = 6
  self.enemy = generateEnemyWave(self)
end

function Enemies:update(dt)
  -- Update x position of "Enemies" bounding box
  self.x = self.x + self.dx * dt

  -- Track position of "Enemies" bounding box to determine when to update Enemy dx and y values
  if self.x + (self.cols + 1) * self.width * 2 - 20 > VIRTUAL_WIDTH then
    self.x = VIRTUAL_WIDTH - (self.cols + 1) * self.width * 2 - 20
    self.y = self.y + 10
    self.dx = -self.dx
    for key, enemy in ipairs(self.enemy) do
      enemy.dx = -enemy.dx
      enemy.y = enemy.y + 10
    end
  elseif self.x < 0 then
    self.x = 0
    self.y = self.y + 10
    self.dx = -self.dx
    for key, enemy in ipairs(self.enemy) do
      enemy.dx = -enemy.dx
      enemy.y = enemy.y + 10
    end
  end
end

function Enemies:render()
  for key, enemy in ipairs(self.enemy) do
    enemy:render()
  end
end

function generateEnemyWave(self)
  local enemies = {}
  for x=0, self.cols do
    for y=0, self.rows do
      table.insert(enemies, Enemy(self.width * x, self.height * y, ENEMY_WIDTH, ENEMY_HEIGHT, self.dx))
    end
  end
  return enemies
end
--[[
1 40
2 80
3 120
4 160
5 200
6 240
7 260
--]]