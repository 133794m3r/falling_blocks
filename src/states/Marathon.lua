---
--- Marathon Mode Game State
--- Created by macarthur.
--- DateTime: 12/9/20 8:29 PM
---
MarathonMode = Class{__includes=BaseState}
function MarathonMode:enter(params)
	self.game = MarathonGame()
end
function MarathonMode:update(dt)
	if not self.paused then
		self.game:updateBoard(dt)
	end
end

function MarathonMode:handleInput(key)
	self.game:handleInput(key)
end

function MarathonMode:render()
	self.game:render()
end