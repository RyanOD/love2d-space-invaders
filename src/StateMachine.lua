StateMachine = Class{}

function StateMachine:init(states)
  self.empty = {
    render = function() end,
    update = function() end,
    enter = function() end,
    exit = function() end
  }
  self.states = states or {}
  self.current = self.empty
end

function StateMachine:render()
  self.current:render()
end

function StateMachine:update(dt)
  self.current:update(dt)
end

function StateMachine:change(stateName, enterParams)
  assert(self.states[stateName])
  self.current:exit() -- call the exit() method of the current state
  self.current = self.states[stateName]() -- set the new state name...this is a function because it returns the next state
  self.current:enter(enterParams) -- call the enter method of the new state
end