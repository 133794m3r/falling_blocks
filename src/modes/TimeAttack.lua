---
--- Time Attack Mode
--- Created by macarthur.
--- DateTime: 12/9/20 8:27 PM
---

TimeAttack = Class{__includes=BaseGame}

function TimeAttack:enter(params)
	gMusic['sprint_theme']:play()
	gCurrentSong = 'sprint_theme'
	self.paused = false
	BaseGame.init(self,params or {})
	love.graphics.setFont(gUIFont)
	self.endLines = params.endLines or 5
	self.gameMode = 2
end

function TimeAttack:update(dt)
	if not self.gameOver and not self.paused then
		self:updateBoard(dt)
	end
end

function TimeAttack:checkWin()
	if self.lines >= self.endLines then
		self:endGame()
	end
end