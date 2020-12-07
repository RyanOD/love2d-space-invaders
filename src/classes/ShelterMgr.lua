ShelterMgr = Class{}

function ShelterMgr:init()
  self.numShelters = 4
  self.shelters = self:createShelters(self.numShelters)
end

function ShelterMgr:render()
  for key, shelter in ipairs(self.shelters) do
    shelter:render()
  end
end

function ShelterMgr:createShelters(numShelters)
  local shelterTable = {}
  for i=1, numShelters do
    table.insert(shelterTable, Shelter(i))
  end
  return shelterTable
end