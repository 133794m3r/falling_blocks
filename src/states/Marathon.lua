---
--- Marathon Mode Game State
--- Created by macarthur.
--- DateTime: 12/9/20 8:29 PM
---
MarathonMode = Class{__includes={BaseGame} }

function MarathonMode:enter(params)
	--self.game = MarathonGame()
	self.paused = false
	BaseGame.init(self,params or {})
	love.graphics.setFont(gUIFont)
	self.endLevel = 2 or params.level
end

function MarathonMode:update(dt)
	if not self.gameOver and not self.paused then
		self:updateBoard(dt)
	end
end

function MarathonGame:checkWin()
	if self.level >= self.endLevel then
		self:endGame()
	end
end