TitleState = Class{__includes = BaseState}
function TitleState:enter(params)
	self.titleFont = love.graphics.newFont(52)
	self.titleBlocks = {
		{1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,},
		{1,0,0,0,0,0,0,2,0,0,0,3,0,0,0,4,0,0,0,5,0,6,0,0,0,6,0,0,7,7,7,0,0,0,1,0,0,0,1,0,2,0,0,0,0,3,3,3,0,0,0,4,4,4,0,0,5,0,0,0,5,0,0,6,6,6,0,},
		{1,0,0,0,0,0,2,0,2,0,0,3,0,0,0,4,0,0,0,5,0,6,6,0,0,6,0,7,0,0,0,7,0,0,1,0,0,0,1,0,2,0,0,0,3,0,0,0,3,0,4,0,0,0,4,0,5,0,0,5,0,0,6,0,0,0,0,},
		{1,1,1,0,0,2,0,0,0,2,0,3,0,0,0,4,0,0,0,5,0,6,0,6,0,6,0,7,0,0,0,0,0,0,1,1,1,1,0,0,2,0,0,0,3,0,0,0,3,0,4,0,0,0,0,0,5,5,5,0,0,0,0,6,6,6,0,0,},
		{1,0,0,0,0,2,2,2,2,2,0,3,0,0,0,4,0,0,0,5,0,6,0,0,6,6,0,7,0,0,7,7,0,0,1,0,0,0,1,0,2,0,0,0,3,0,0,0,3,0,4,0,0,0,0,0,5,0,5,0,0,0,0,0,0,0,6,},
		{1,0,0,0,0,2,0,0,0,2,0,3,0,0,0,4,0,0,0,5,0,6,0,0,0,6,0,7,0,0,0,7,0,0,1,0,0,0,1,0,2,0,0,0,3,0,0,0,3,0,4,0,0,0,4,0,5,0,0,5,0,0,6,0,0,0,6,},
		{1,0,0,0,0,2,0,0,0,2,0,3,3,3,0,4,4,4,0,5,0,6,0,0,0,6,0,0,7,7,7,0,0,0,1,1,1,1,0,0,2,2,2,0,0,3,3,3,0,0,0,4,4,4,0,0,5,0,0,0,5,0,0,6,6,6,0,}
	}
end

function TitleState:update(dt)
	if love.keypressed('enter') or love.keypressed('return') then

	end
end
function TitleState:drawBlock(block,x,y)
	--z:7,s:6,t:5,l:4,j:3,o:2,i:1
	local colors = {
		{{0.2456, 0.3971, 0.4911}, {0.517, 0.836, 1.034}, {0.3247, 0.525, 0.6494}},
		{{0.4807, 0.3605, 0.2456}, {1.012, 0.759, 0.517}, {0.6355, 0.4767, 0.3247}},
		{{0.4859, 0.4755, 0.2195}, {1.023, 1.001, 0.462}, {0.6424, 0.6286, 0.2901}},
		{{0.256, 0.4441, 0.3971}, {0.539, 0.935, 0.836}, {0.3385, 0.5872, 0.525}},
		{{0.5068, 0.303, 0.4023}, {1.067, 0.638, 0.847}, {0.6701, 0.4007, 0.5319}},
		{{0.3448, 0.4337, 0.2403}, {0.726, 0.913, 0.506}, {0.4559, 0.5734, 0.3178}},
		{{0.4337, 0.2821, 0.4859}, {0.913, 0.594, 1.023}, {0.5734, 0.373, 0.6424}},
		-- The one when they're marked for clearning. Might use might not.
		{{0.74, 0.74, 0.74}, {1, 1 ,1}, {1, 1, 1}},
		-- The blocks that makeup the ghost piece show final drop position.
		{{0.5643, 0.5643, 0.5643}, {0.99, 0.99, 0.99}, {0.6633, 0.6633, 0.6633}},
		-- Dead blocks aka the ones that are added when selecting a level or something.
		{{0.2565, 0.2565, 0.2565}, {0.45, 0.45, 0.45}, {0.3015, 0.3015, 0.3015}}
	}
	local color = colors[block]
	local blockSize =12
	local blockDrawSize = 11
	x = x - 1
	y = y - 1
	local modifier = 1
	love.graphics.setColor(color[1])
	--love.graphics.setColor(color[1] * 0.47, color[2] * 0.47, color[3] * 0.47)
	love.graphics.rectangle("fill", blockSize * x, blockSize * y, blockDrawSize, blockDrawSize)
	love.graphics.setColor(color[2])
	--love.graphics.setColor(color[1], color[2], color[3])
	love.graphics.rectangle("fill", blockSize * x + 2, blockSize * y + 2, blockDrawSize -2, blockDrawSize -2)
	--love.graphics.setColor(color[3])
	----love.graphics.setColor(color[1] * 0.6275, color[2] * 0.6275, color[3] * 0.6275)
	--love.graphics.rectangle("fill", blockSize * x + 6, blockSize * y + 6, blockDrawSize - 4, blockDrawSize - 4)
end

function TitleState:render()
	local max_x = #self.titleBlocks[1]
	for y=1, 7 do
		for x = 1, 67 do
			if self.titleBlocks[y][x] ~= 0 then
				self:drawBlock(self.titleBlocks[y][x],x,y)
			else
				love.graphics.setColor(0.0863,0.0863,0.0863)
				love.graphics.rectangle(
						'fill',
						(x-1) * 12,
						(y-1) * 12,
						9,
						9
				)
			end
		end
	end
	love.graphics.setColor(1,1,1)
	love.graphics.newFont(52)
	local width, height, flags = love.window.getMode()
	love.graphics.printf("By Macarthur Inbody",0, height/3,width,'center')
	love.graphics.printf('PRESS ENTER',0, height/3+75,width,'center')

end