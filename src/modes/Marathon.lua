---
--- Marathon Mode Game State
--- Created by macarthur.
--- DateTime: 12/9/20 8:29 PM
---
MarathonMode = Class{__includes={BaseGame} }

function MarathonMode:enter(params)
	gCurrentSong = 'normal_theme'

	self.paused = false
	BaseGame.init(self,params or {})
	love.graphics.setFont(gUIFont)
	self.endLevel = params.level or 2
	self.gameMode = 1
	if gMusicMuted == false then
		gMusic['normal_theme']:play()
	end
end

function MarathonMode:update(dt)
	if not self.gameOver and not self.paused then
		self:updateBoard(dt)
	end
end

function MarathonMode:checkWin()
	if self.level >= self.endLevel then
		self:endGame()
	elseif self.level == 14 then
		gMusic['normal_theme']:stop()
		gMusic['final_countdown']:play()
		gCurrentSong = 'final_countdown'
	end
end