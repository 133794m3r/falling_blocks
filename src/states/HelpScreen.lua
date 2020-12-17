HelpMenu = Class{__includes = BaseState}

function HelpMenu:init(params)
	self.currentTextScreen = 1
	self.helpScreenTitles = {
		'Controls',
		'Gameplay 1',
		'Gameplay 2',
		'Game Modes',
		'Marathon Mode',
		'Sprint Mode',
		'Endless Mode',
		'Scoring',
	}
	self.helpScreenTexts= {
		"This game uses keyboard controls. Gamepads aren't currently supported.\n\nThe left/right arrow keys move the piece in their respective directions. Down moves the piece down by one cell.\n\nUp arrow and 'x' rotate the piece clockwise. 'z' left/right ctrl rotate it counter clockwise. 'c' is the 'hard drop' key causing the piece to drop to the bottom as fast as possible and lock in place.\n\nYour 'shift' keys allow you to hold a piece if no piece is already held or it will swap the currently held piece witht he piece on the game board.\n\n'return'/'enter' 'space bar' will cause the game to become paused. Pressing it again will unpause the game.\n\n'm' will mute/unmute the audio.",
		'',
		'',
		'',
		'',
		'',
		'',
		'',
	}
	self.highlightColor = {1,0,0,1}
	self.currentColors = {
		{1,0,0,1},
		{1,1,1,1},
		{1,1,1,1},
		{1,1,1,1},
		{1,1,1,1},
		{1,1,1,1},
		{1,1,1,1},
		{1,1,1,1},
		{1,1,1,1},
		{1,1,1,1},
	}
	self.optionColors = {
		{1,1,1,1},
		{1,1,1,1},
		{1,1,1,1},
		{1,1,1,1},
		{1,1,1,1},
		{1,1,1,1},
		{1,1,1,1},
		{1,1,1,1},
		{1,1,1,1},
	}
	self.positions = {
		157, --1
		200, -- 2
		245, -- 3
		288, -- 4
		332, -- 5
		376, -- 6
		420, -- 7
		465, -- 8
	}
end

function HelpMenu:handleInput(key)
	self.currentColors[self.currentTextScreen] = self.optionColors[self.currentTextScreen]
	if key == 'left' then
		self.currentTextScreen = self.currentTextScreen == 1 and #self.helpScreenTitles or self.currentTextScreen -1
	elseif key == 'right' then
		self.currentTextScreen = self.currentTextScreen == #self.helpScreenTitles and 1 or self.currentTextScreen + 1
	end
	self.currentColors[self.currentTextScreen] = self.highlightColor
end

function HelpMenu:render()
	love.graphics.setColor(1,1,1)
	love.graphics.setFont(gFonts['title'])
	love.graphics.printf(self.helpScreenTitles[self.currentTextScreen],0,0,780,'center')
	love.graphics.setFont(gFonts['sm'])
	love.graphics.printf(self.helpScreenTexts[self.currentTextScreen],20,90,740,'left')
	love.graphics.setFont(gFonts['md'])
	love.graphics.printf('Press Escape to return to main menu.',0,550,780,'center')
	love.graphics.setFont(gFonts['mono_lg'])
	love.graphics.printf({
		-----------=====
		{1,1,1,1},'     <- ',
		self.currentColors[1],'1',
		self.currentColors[2],' 2',
		self.currentColors[3],' 3',
		self.currentColors[4],' 4',
		self.currentColors[5],' 5',
		self.currentColors[6], ' 6',
		self.currentColors[7],' 7',
		self.currentColors[8],' 8',
		{1,1,1,1},' ->     '
	},0,600,780)

	love.graphics.setColor(1,0,0)
	love.graphics.print('[',self.positions[self.currentTextScreen],600)
	love.graphics.print(']',self.positions[self.currentTextScreen]+39,600)


end