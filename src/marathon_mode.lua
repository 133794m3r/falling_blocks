-- the different game modes.
MarathonMode = Class{__includes = BaseGame}
function MarathonMode:init(def)
	self.endLines = 15 or def.lines
	BaseGame.init(self,def)
end

function MarathonMode:endGame()
	if self.lines == self.endLines then
		print("Game Won");
		self:init()
	end
end