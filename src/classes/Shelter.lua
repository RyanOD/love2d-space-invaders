Shelter = Class{}

function Shelter:init()
  self.width = 35
  self.height = 15
  self.x = VIRTUAL_WIDTH / 5
  self.y = VIRTUAL_HEIGHT - 40
  self.shelters = {{x=self.x - self.width / 2, y=self.y}, {x=self.x * 2 - self.width / 2, y=self.y}, {x=self.x * 3 - self.width / 2, y=self.y}, {x=self.x * 4 - self.width / 2, y=self.y}}
end

function Shelter:render()
  love.graphics.setColor(gColorPalette['white'], 1)
  for key, shelter in ipairs(self.shelters) do
    love.graphics.rectangle("fill", shelter.x, shelter.y, self.width, self.height)
  end
end