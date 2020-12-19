EndlessMode = Class{__includes={BaseGame} }

function EndlessMode:enter(params)
	gCurrentSong = 'final_countdown'
	gMusic['normal_theme']:play()
	self.paused = false
	BaseGame.init(self,params or {})
	love.graphics.setFont(gUIFont)
	self.gameMode = 3
end

function EndlessMode:update(dt)
	if not self.gameOver and not self.paused then
		self:updateBoard(dt)
	end
end
-- there is no win condition but since we already calling this function upon a level going up we might as well use it
function EndlessMode:checkWin()
	if self.level == 14 then
		gMusic['normal_theme']:stop()
		gMusic['final_countdown']:play()
		gCurrentSong = 'final_countdown'
	end
end