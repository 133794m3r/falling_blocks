-- the different game modes.
MarathonGame = Class{__includes = BaseGame}
function MarathonGame:init(def)
	self.endLines = 15 or def.lines
	BaseGame.init(self,def)
end

function MarathonGame:endGame()
	if self.lines == self.endLines then
		print("Game Won");
		self:init()
	end
end