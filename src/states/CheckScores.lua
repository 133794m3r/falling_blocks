CheckScores = Class{__includes=BaseState}
function CheckScores:enter(params)
	love.keyboard.setTextInput(true)
	self.score = params.score or 0
	self.lines = params.lines or 0
	self.level = params.level or 0
	self.mode = params.mode or 1
	self.rank = 0
	self.name = ''
	-- basic enum
	local modes = {'marathon','sprint','endless'}
	local currentMode = modes[self.mode]
	for x=1,15 do
		if gHighScores[currentMode][x].score < self.score then
			table.insert(gHighScores[currentMode],x,{
				['score'] = self.score,
				['level'] = self.level,
				['lines'] = self.lines,
			})
			table.remove(gHighScores,15)
			self:enterName(x)
			self.rank = x
			break
		end
	end
end

function CheckScores:update(dt)

end

function CheckScores:enterName(pos)
	local name = ''
end

function CheckScores:handleInput(key)
	-- only do this if we're already got text input.
	--if love.keyboard.hasTextInput() then
		-- if they press backspace or delete delete a character.
	if key == 'backspace' or key == 'delete' then
		gTextString = string.sub(gTextString,1,#gTextString-1)
		--end
	--end
	elseif key == 'enter' then
		self.name = gTextString
	end
end

function CheckScores:render()
	if self.name == '' then
		love.graphics.printf('Enter name then press enter when done.',0,0,780,'center')
	end
	love.graphics.printf('You got Rank:' .. tostring(self.rank),0,30,780,'center')
	love.graphics.printf('Your score :' .. tostring(self.score),0,60,780,'center')
	love.graphics.printf(gTextString or '',0,90,780,'center')
	end
function CheckScores:exit()

end