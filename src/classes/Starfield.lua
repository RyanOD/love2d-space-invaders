Starfield = Class{}

function Starfield:init()
  self.starfield = Starfield:generate()
end

function Starfield:render()
  love.graphics.setColor(gColorPalette['white'], 1)
  for i=1, 100 do
    love.graphics.circle('fill', self.starfield[i].x, self.starfield[i].y, 1)
  end
end

function Starfield:generate()
  local starfield = {}
  for i=1, 100 do
    starfield[i] = {}
    starfield[i].x = math.random() * VIRTUAL_WIDTH
    starfield[i].y = math.random() * VIRTUAL_HEIGHT
  end
  return starfield
end
