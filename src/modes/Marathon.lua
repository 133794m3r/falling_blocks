---
--- Marathon Mode Game State
--- Created by macarthur.
--- DateTime: 12/9/20 8:29 PM
---
MarathonMode = Class{__includes={BaseGame} }

function MarathonMode:enter(params)
	gMusic['normal_theme']:play()
	self.paused = false
	BaseGame.init(self,params or {})
	love.graphics.setFont(gUIFont)
	self.endLevel = 2 or params.level
	self.gameMode = 1
end

function MarathonMode:update(dt)
	if not self.gameOver and not self.paused then
		self:updateBoard(dt)
	end
end

function MarathonMode:checkWin()
	if self.level >= self.endLevel then
		self:endGame()
	end
end

function MarathonMode:exit()
	gMusic['normal_theme']:stop()
	gMusic['title_music']:play()
end