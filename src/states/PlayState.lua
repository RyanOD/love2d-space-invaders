PlayState = Class{includes = BaseState}

function PlayState:enter(params)
  self.base = Base()
  self.laser = Laser(self.base.x)
end

function PlayState:update(dt)
  self.base:update(dt)

  if love.keyboard.isDown('space') then
    self.laser:render()
  end

end

function PlayState:render()
  self.base:render()
end