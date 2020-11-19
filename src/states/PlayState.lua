PlayState = Class{includes = BaseState}

function PlayState:enter(params)
  self.base = Base()
  self.laser = Laser(self.base.x)
  self.lasers = {"H"}
end

function PlayState:update(dt)
  self.base:update(dt)

  if love.keyboard.wasPressed('return') then
    table.insert(self.lasers, "bar")
  end

end

function PlayState:render()
  self.base:render()

  love.graphics.setFont(gFonts['menu'])
  for key,text in pairs(self.lasers) do
    love.graphics.printf('Lasers: ' .. text, 0, VIRTUAL_HEIGHT / 2 + 40, VIRTUAL_WIDTH, 'center')
  end
end