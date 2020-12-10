-- the different game modes.
MarathonGame = Class{__includes = BaseGame}
function MarathonGame:init(def)
	BaseGame.init(self,def)
	love.graphics.setFont(gUIFont)
	self.level = 2 or def.level
end

function MarathonGame:endGame()
	if self.level >= self.endLevel then
		self:init()
	end
end