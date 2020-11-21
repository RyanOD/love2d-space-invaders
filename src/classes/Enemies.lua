Enemies = Class{}

function Enemies:init()
  self.x = 0
  self.y = 0
  self.dx = 5
  self.enemy = {}
  for i=0, 5 do
    for j=0, 0 do
      table.insert(self.enemy, Enemy(10 * i, 10 * j))
    end
  end
end

function Enemies:update(dt)
  for key, enemy in pairs(self.enemy) do
    if enemy.x + (8 + (math.abs((key % 6) - 6) * 10)) > VIRTUAL_WIDTH and key ~= 6 then
      enemy.dx = -enemy.dx
    elseif enemy.x + 8 > VIRTUAL_WIDTH then
      enemy.dx = -enemy.dx
    end
    enemy.x = enemy.x + enemy.dx * dt
  end
end

function Enemies:render()
  for key, enemy in pairs(self.enemy) do
    enemy:render()
  end
end