---
--- Created by macarthur.
--- DateTime: 11/22/20 5:07 PM
---
BaseGame = Class{}

function BaseGame:init(params)
	--[[
	All of the variables we have to have set.
	]]

	self.gameTime = 0
	self.score = 0
	self.level = 0
	self.lines = 0
	self.pieceRotation = 0
	self.pieceType = 0
	self.heldPiece = 0
	self.pieceY = 0
	self.pieceX = 0
	self.gridXCount = 10
	self.gridYCount = 22

	-- the game variables.
	self.gravityTimer = 0
	self.fallTimer = 0.5
	self.lastChance = nil
	self.lockTimer = 0
	-- the amount of time we should wait until the item is locked.
	--[[
		for levels above 20 in endless what happens is that this is slowly
		decreased over time by 0.05s per level.
	]]
	self.lockTime = 0.5

	-- seconds for how long it should take for the piece to fall 1 row.
	-- "Hard" mode uses the official timelines.
	self.HardDropTimes = {1.0, 0.793, 0.6178, 0.4727, 0.3552, 0.262, 0.1897, 0.1347, 0.0939, 0.0642, 0.043, 0.0282, 0.0182, 0.0114, 0.0071, 0.0043, 0.0025, 0.0015, 0.0008}
	-- Easy mode has the formula modified such that the default time is increased by 0.05s per cell.
	self.EasyDropTimes = {1.0, 0.803, 0.6336, 0.4912, 0.374, 0.2796, 0.2052, 0.1478, 0.1045, 0.0724, 0.0492, 0.0328, 0.0214, 0.0137, 0.0086, 0.0053, 0.0032, 0.0019, 0.0011, 1.0, 0.843, 0.6989, 0.5697, 0.4565, 0.3596, 0.2783, 0.2116, 0.158, 0.1158, 0.0834, 0.0589, 0.0408, 0.0277, 0.0185, 0.0121, 0.0077, 0.0049, 0.003}

	self.inert = {}
	for y = 0, self.gridYCount do
		self.inert[y] = {}
		for x = 1, self.gridXCount do
			self.inert[y][x] = ' '
		end
	end

	self:newBatch()
	self:newPiece()
end

function BaseGame:validMove(test_x,test_y,testRotation,printit)
	local maxY = (self.gridYCount+1) - self.pieceLength
	--if test_y > maxY then
	--	if printit then
	--		print(test_y)
	--	end
	--	return false
	--end
	for x=1,self.pieceLength do
		local testBlockX = test_x + x
		for y=0,self.pieceLength-1 do
			local testBlockY = test_y + y
			if printit then
				print('y',y)
				print('test_x',test_x)
				print('test_y',test_y)
				print('ty',testBlockY)
				print('tx',testBlockX)
				print(testBlockY > self.gridYCount)
				--print(self.inert[testBlockY][testBlockX] ~= ' ')
				print(pieceStructures[self.pieceType][testRotation][y+1][x])
				print_r(self.inert)
			end
			if pieceStructures[self.pieceType][testRotation][y+1][x] ~= ' ' then
				--and (

				if
				testBlockX < 1
						or testBlockX > self.gridXCount
						or testBlockY > self.gridYCount
						or self.inert[testBlockY][testBlockX] ~= ' '
				then
					return false
				end

			end
		end
	end
	return true
end

function BaseGame:handleInput(key)
	if key == 'x' or key == 'up' then
		if self.pieceType ~= 2 then
			local new_rotation = self.pieceRotation
			new_rotation = self.pieceRotation + 1
			if new_rotation > (#pieceStructures[self.pieceType]) then
				new_rotation = 1
			end
			if can_rotate(self.pieceRotation,new_rotation) then
				self.pieceRotation = new_rotation
				self.lockTimer = 0
			end
		else
			self.lockTimer = 0
		end

	elseif key == 'z' or key == 'lctrl' or key == 'rctrl' then
		if pieceType ~= 2 then
			local new_rotation = self.pieceRotation
			new_rotation = self.pieceRotation -1
			if new_rotation == 0 then
				new_rotation = #pieceStructures[self.pieceType]
			end

			if can_rotate(self.pieceRotation,new_rotation) then
				self.pieceRotation = new_rotation
				self.lockTimer = 0
			end
		else
			self.lockTimer = 0
		end
	elseif key == 'left' then

		if self:validMove(self.pieceX-1,self.pieceY,self.pieceRotation) then
			self.pieceX = self.pieceX - 1
			self.lockTimer = 0
		end
	elseif key == 'right' then
		if self:validMove(self.pieceX+1,self.pieceY,self.pieceRotation) then
			self.pieceX = self.pieceX + 1
			self.lockTimer = 0
		end
	elseif key == 'down' then
		if self:validMove(self.pieceX,self.pieceY+1,self.pieceRotation) then
			self.pieceY = self.pieceY + 1
			self.lockTimer = 0
			self.score = self.score + 10
		end
	elseif key == 'c' then
		local tmp_extra = 0
		while self:validMove(self.pieceX, self.pieceY + 1, self.pieceRotation,true) do
			if tmp_extra <= 14 then
				tmp_extra = tmp_extra + 1
			end
			self.pieceY = self.pieceY + 1
		end
		print(self.pieceY)
		self.score = self.score + (tmp_extra * 20)
		self.gravityTimer = 0.5
		self.lockTimer = 0
	end
end

function BaseGame:updatePiece(dt)
	self.gravityTimer = self.gravityTimer + dt
	self.lockTimer = self.lockTimer + dt
	if self.gravityTimer >= self.fallTimer then
		self.gravityTimer = self.gravityTimer - self.fallTimer
		local new_y = self.pieceY + 1
		if self:validMove(self.pieceX, new_y,self.pieceRotation) then
			self.pieceY = new_y
		else
			if self.lockTimer > self.lockTime then
				if self:validMove(self.pieceX, new_y,self.pieceRotation) then
					self.piece_y = new_y
				end
				for y = 0, self.pieceLength-1 do
					for x = 1, self.pieceLength do
						local block = pieceStructures[self.pieceType][self.pieceRotation][y+1][x]
						if block ~= ' ' then
							self.inert[self.pieceY + y][self.pieceX + x] = block
						end
					end
				end
				self.lockTimer = 0
				self:newPiece()

				if not self:validMove(self.pieceX, self.pieceY, self.pieceRotation) then
					self:init()
				end
			else

			end

		end

	end
end

function BaseGame:checkClears()
	local lines = 0
	for y =1, self.gridYCount do
		local line = true
		for x=1,self.gridXCount do
			if self.inert[y][x] == ' ' then
				line = false
				break
			end
		end
		if line then
			lines = lines + 1
			for clear_y=y,2,-1 do
				for clear_x=1,self.gridXCount do
					self.inert[clear_y][clear_x] = self.inert[clear_y -1][clear_x]
				end
			end
			for clear_x = 1, self.gridXCount do
				self.inert[1][clear_x] = ' '
			end
		end
	end
	if lines ~= 0 then
		local multiplier = {
			[1] = 100,
			[2] = 300,
			[3] = 500,
			[4] = 800,
		}
		self.score = self.score + (gLevel * multiplier[lines])
		gLines = lines + gLines
		if gLines % 10 == 0 then
			gLevel = gLevel + 1
		end
	end
end

function BaseGame:canRotate(old_rotation,new_rotation)
	--z:7,s:6,t:5,l:4,j:3,o:2,i:1
	-- j,l,s,t,z all use the same rotation. o doesn't rotate.
	-- and i uses it's own special one.
	local kick_data_normal = {
		[0] = {
			[1] = {
				{-1,0},{-1,1},{0,-2},{-1,-2}
			},
			[3] = {
				{1,0},{1,1},{0,-2},{1,-2}
			}
		},
		[1] ={
			[0] ={
				{1,0},{1,-1},{0,2},{1,2}
			},
			[2] = {
				{1,0},{1,-1},{0,2},{1,2}
			},

		},
		[2] = {
			[1]={
				{-1,0},{-1,1},{0,-2},{-1,-2}
			},
			[3] ={
				{1,0},{-1,1},{0,-2},{-1,-2}
			}
		},
		[3]={
			[0]={
				{-1,0},{-1,-1},{0,2},{-1,2}
			},
			[2]={
				{-1,0},{-1,-1},{0,2},{-1,2}
			},
		}
	}
	old_rotation = old_rotation -1
	new_rotation = new_rotation -1
	local kick_data_i = {
		[0] = {
			[1] = {
				{-2,0}, {1,0}, {-2,-1}, {1,2}
			},
			[3] = {
				{-1,0}, {2,0}, {-1,2}, {2,-1}
			}
		},
		[1] ={
			[0] ={
				{2,0}, {-1,0}, {2,1}, {-1,-2}
			},
			[2] = {
				{-1,0}, {2,0}, {-1,2}, {2,-1}
			},
		},
		[2] = {
			[1]={
				{1,0}, {-2,0}, {1,-2}, {-2,1}
			},
			[3] ={
				{2,0}, {-1,0}, {2,1}, {-1,-2}
			}
		},
		[3]={
			[0]={
				{1,0}, {-2,0}, {1,-2}, {-2,1}
			},
			[2]={
				{-2,0}, {1,0}, {-2,-1}, {1,2}
			},
		}
	}
	local valid = false
	local old_x, old_y = self.pieceX, self.pieceY
	local new_x, new_y,mod_x, mod_y = 0,0,0,0

	if self.pieceType == 1 then
		if not self:validMove(old_x,old_y,new_rotation+1) then
			for i=1,4 do
				mod_x,mod_y = unpack(kick_data_i[old_rotation][new_rotation][i])
				new_x,new_y = old_x+mod_x, old_y+mod_y
				if self:validMove(new_x,new_y,new_rotation+1) then
					valid = true
					self.pieceX = new_x
					self.pieceY = new_y
					break
				end
			end
		else
			valid = true
		end
	else
		if not self:validMove(old_x,old_y,new_rotation+1) then
			for i=1,4 do
				mod_x,mod_y = unpack(kick_data_normal[old_rotation][new_rotation][i])
				new_x,new_y = old_x+mod_x, old_y+mod_y
				if self:validMove(new_x,new_y,new_rotation+1) then
					valid = true
					self.pieceX = new_x
					self.pieceY = new_y
					break
				end
			end
		else
			valid = true
		end
	end
	return valid
end
function BaseGame:newPiece()
	self.pieceX = 3
	self.pieceY = 1
	self.pieceRotation = 1
	self.pieceType = table.remove(self.sequence)
	self.pieceLength = #pieceStructures[self.pieceType][1]
	if #self.sequence == 0 then
		self:newBatch()
	end
end
function BaseGame:newBatch()
	self.sequence = {}
	for x=1, 7 do
		-- not using love.math.random() as it's too random this other one gives me the same inputs upon each startup which is good for
		-- testing.
		--local position = love.math.random(x+1)
		local position = math.random(x+1)
		table.insert(self.sequence,position,x)
	end
end

function BaseGame:draw()
	local offsetX = 7
	local offsetY = 0
	for y = 2, self.gridYCount do
		for x = 1, self.gridXCount do
			if self.inert[y][x] ~= ' ' then
				self:drawBlock(self.inert[y][x],x+offsetX,y)
			else
				love.graphics.setColor(0.0863,0.0863,0.0863)
				love.graphics.rectangle(
						'fill',
						((x - 1)+offsetX) * 30,
						(y - 1) * 30,
						26,
						26
				)
				love.graphics.setColor(1,1,1)
			end
		end
	end
	for y=1,self.pieceLength do
		for x=1,self.pieceLength do
			local block = pieceStructures[self.pieceType][self.pieceRotation][y][x]
			if block ~= ' ' then
				self:drawBlock(block,x+self.pieceX +offsetX,y+self.pieceY-1 + offsetY)
			end
		end
	end

	local sw = love.graphics.getWidth()
	local aw = 30 * 10
	local blockSize = 30
	love.graphics.setColor(255, 255, 255)
	love.graphics.printf("HELD", blockSize-1,blockSize * (offsetY+1) , sw - aw, "left")
	love.graphics.printf("NEXT", aw-(blockSize+10),blockSize * (offsetY+1), sw - aw, "right")
	love.graphics.printf("SCORE", aw-(blockSize+10),blockSize * (offsetY+9), sw - aw, "right")
	love.graphics.printf(number_seperator(self.score), gItemFont,aw-(blockSize),blockSize * (offsetY+11), sw - aw +15, "right")
	love.graphics.printf("LINES", aw-(blockSize+10),blockSize * (offsetY+14), sw - aw, "right")
	love.graphics.printf(number_seperator(self.lines), gItemFont, aw-(blockSize+8),blockSize * (offsetY+16), sw - aw, "right")
	love.graphics.printf("LEVEL",  blockSize-1,blockSize * (offsetY+14), sw - aw, "left")
	love.graphics.print(string.format("%05s",number_seperator(self.level)), gItemFont, blockSize*2,blockSize * (offsetY+16))
	local next_piece = pieceStructures[self.sequence[#self.sequence]][1]
	local next_piece_length = #next_piece --#pieceStructures[sequence[#sequence]][1]
	
	for y = 1, next_piece_length do
		for x = 1, next_piece_length do
			local block =next_piece[y][x] --pieceStructures[sequence[#sequence]][1][y][x]
			if block ~= ' ' then
				self:drawBlock(block, x+19, y +offsetY+3)
			end
		end
	end
	
	love.graphics.setColor(0,0,0)
	love.graphics.rectangle(
			'fill',
			(offsetX)*30,
			offsetY,
			30*self.gridXCount,
			30*2
	)
	love.graphics.setColor(255,255,255,255)
end
function BaseGame:drawBlock(block,x,y)
	-- old colors weren't bright enough.
	local colors = {
		i = {0.517, 0.836, 1.034},
		o = {1.012, 0.759, 0.517},
		z = {0.726, 0.913, 0.506},
		t = {1.067, 0.638, 0.847},
		l = {0.539, 0.935, 0.836},
		s = {0.913, 0.594, 1.023},
		j = {1.023, 1.001, 0.462}
	}
	local color = colors[block]
	love.graphics.setColor(color)

	local blockSize = 30
	local blockDrawSize = blockSize - 1
	x = x-1
	y = y - 1
	local modifier = 1
	love.graphics.setColor(color[1] * 0.47, color[2] * 0.47, color[3] * 0.47)
	love.graphics.rectangle("fill", blockSize * x, blockSize * y, blockSize, blockSize)

	love.graphics.setColor(color[1], color[2], color[3])
	love.graphics.rectangle("fill", blockSize * x + 2, blockSize * y + 2, blockSize - 4, blockSize - 4)

	love.graphics.setColor(color[1] * 0.6275, color[2] * 0.6275, color[3] * 0.6275)
	love.graphics.rectangle("fill", blockSize * x + 6, blockSize * y + 6, blockSize - 12, blockSize - 12)
end

function BaseGame:updateBoard(dt)
	self:updatePiece(dt)
	self:checkClears()
end
