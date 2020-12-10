MainMenu = Class{__includes = BaseState}

function MainMenu:enter(params)
	self.bigFont = love.graphics.newFont(64)
	self.currentGameMode = 1
	self.currentOption = 1
	self.currentModeString = ''
	self.gameModeStrings = {'Marathon Mode','Sprint Mode','Endless Mode'}
	self.gameModeDesc = {'Complete the 15 levels and attempt get the highest possible score.',
						 'Race against the clock till you get 50 lines completed.',
						 'Attempt to achieve the highest score possible with no limit except your skill.'}
	self.descFont = love.graphics.newFont(26)
	self.highlightColor = {1,0,0,1}
	self.optionColors = {
		{1,1,1,1},
		{1,1,1,1},
		{1,1,1,1},
		{1,1,1,1},
	}
	self.currentColors = {
		{1,0,0,1},
		{1,1,1,1},
		{1,1,1,1},
		{1,1,1,1},
	}
	love.graphics.setColor(1,1,1,1)
end

function MainMenu:update(dt)

end

function MainMenu:handleInput(key)
	if key == 'down' then
		self.currentColors[self.currentOption] = self.optionColors[self.currentOption]
		self.currentOption = (self.currentOption + 1)
		if self.currentOption == 5 then
			self.currentOption = 1
		end
		self.currentColors[self.currentOption] = self.highlightColor
	elseif key == 'up' then
		self.currentColors[self.currentOption] = self.optionColors[self.currentOption]
		self.currentOption = self.currentOption -1
		if self.currentOption == 0 then
			self.currentOption = 1
		end
		self.currentColors[self.currentOption] = self.highlightColor
	elseif key == 'right' then
		self.currentGameMode = self.currentGameMode + 1
		if self.currentGameMode == 4 then
			self.currentGameMode = 1
		end
	elseif key == 'left' then
		self.currentGameMode = self.currentGameMode - 1
		if self.currentGameMode == 0 then
			self.currentGameMode = 3
		end
	elseif key == 'enter' or key == 'return' then
		if self.currentGameMode == 1 then
			gStateMachine:change('start_marathon')
		elseif self.currentGameMode == 2 then
			gStateMachine:change('time_attack')
		elseif self.currentGameMode == 3 then
			gStateMachine:change('start_endless')
		end
	end
end

function MainMenu:render()
	love.graphics.setFont(self.bigFont)
	love.graphics.printf("MAIN MENU",0,20,780,"center")
	love.graphics.setFont(gMenuFont)
	love.graphics.printf({self.currentColors[1],
						  "<- " .. self.gameModeStrings[self.currentGameMode]  .. " ->"},
			0,120,780,"center")
	love.graphics.printf({self.currentColors[2],"View High Scores"},0,400,780,"center")
	love.graphics.printf({self.currentColors[3],"Help"},0,480,780,"center")
	love.graphics.setFont(self.descFont )
	love.graphics.printf(self.gameModeDesc[self.currentGameMode],0,190,720,"center")
	love.graphics.setFont(self.bigFont)
	love.graphics.printf({self.currentColors[4],"EXIT"},0,580,780,"center")


end
