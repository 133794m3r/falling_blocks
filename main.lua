---
--- Created by macarthur.
--- DateTime: 11/20/20 8:46 PM

require 'src/init'
require 'src/util'
require 'src/misc'
require 'src/game'
function love.load()
	love.graphics.setBackgroundColor(0, 0, 0)
	--setting up my fonts.
	gUIFont = love.graphics.newFont(36)
	gItemFont = love.graphics.newFont(37)
	love.graphics.setFont(gUIFont)
	love.window.setMode(30 * (gridXCount + 16), 30 * (gridYCount))
	love.graphics.setDefaultFilter( 'nearest', 'nearest', 1 )
	init_game()
end

function love.keypressed(key)
	if key == 'x' or key == 'up' then
		if pieceType ~= 2 then
			local new_rotation = pieceRotation
			new_rotation = pieceRotation + 1
			if new_rotation > (#pieceStructures[pieceType]) then
				new_rotation = 1
			end
			--if not valid_move(pieceX,pieceY,pieceRotation) then
			if can_rotate(pieceRotation,new_rotation) then
				pieceRotation = new_rotation
				gLockTimer = 0
			end
		else
			gLockTimer = 0
		end

	elseif key == 'z' or key == 'lctrl' or key == 'rctrl' then
		if pieceType ~= 2 then
			local new_rotation = pieceRotation
			new_rotation = pieceRotation -1
			if new_rotation == 0 then
				new_rotation = #pieceStructures[pieceType]
			end
			--if not valid_move(pieceX,pieceY,pieceRotation) then
			if can_rotate(pieceRotation,new_rotation) then
				pieceRotation = new_rotation
				gLockTimer = 0
			end
		else
			gLockTimer = 0
		end
	elseif key == 'left' then

		if valid_move(pieceX-1,pieceY,pieceRotation) then
			pieceX = pieceX - 1
			gLockTimer = 0
		--elseif gLastChance and valid_move(pieceX-1,pieceY-1,pieceRotation) then
		--	pieceX = pieceX - 1
		end
	elseif key == 'right' then
		if valid_move(pieceX+1,pieceY,pieceRotation) then
			pieceX = pieceX + 1
			gLockTimer = 0
		--elseif gLastChance and valid_move(pieceX+1,pieceY-1,pieceRotation) then
		--	pieceX = pieceX +1
		end
	elseif key == 'down' then
		if valid_move(pieceX,pieceY+1,pieceRotation) then
			pieceY = pieceY + 1
			gLockTimer = 0
		end
	elseif key == 'c' then
		while valid_move(pieceX, pieceY + 1, pieceRotation) do
			pieceY = pieceY + 1
		end
		gGravityTimer = 0.5
		gLockTimer = 0
	end

end

function love.update(dt)
	update_board(dt)
end

function love.draw()
	local offsetX = 7
	local offsetY = 0
	for y = 2, gridYCount do
		for x = 1, gridXCount do
			if inert[y][x] ~= ' ' then
				draw_block(inert[y][x],x+offsetX,y)
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
	for y=1,pieceLength do
		for x=1,pieceLength do
			local block = pieceStructures[pieceType][pieceRotation][y][x]
			if block ~= ' ' then
				draw_block(block,x+pieceX +offsetX,y+pieceY-1 + offsetY)
			end
		end
	end

	local sw = love.graphics.getWidth()
	local aw = 30 * 10
	local blockSize = 30
	local score = gScore
	local level = gLevel
	local lines = gLines
	love.graphics.setColor(255, 255, 255)
	love.graphics.printf("HELD", blockSize-1,blockSize * (offsetY+1) , sw - aw, "left")
	love.graphics.printf("NEXT", aw-(blockSize+10),blockSize * (offsetY+1), sw - aw, "right")
	love.graphics.printf("SCORE", aw-(blockSize+10),blockSize * (offsetY+9), sw - aw, "right")
	love.graphics.printf(number_seperator(score), gItemFont,aw-(blockSize),blockSize * (offsetY+11), sw - aw +15, "right")
	love.graphics.printf("LINES", aw-(blockSize+10),blockSize * (offsetY+14), sw - aw, "right")
	love.graphics.printf(number_seperator(lines), gItemFont, aw-(blockSize+8),blockSize * (offsetY+16), sw - aw, "right")
	love.graphics.printf("LEVEL",  blockSize-1,blockSize * (offsetY+14), sw - aw, "left")
	love.graphics.print(string.format("%05s",number_seperator(level)), gItemFont, blockSize*2,blockSize * (offsetY+16))
	local next_piece = pieceStructures[sequence[#sequence]][1]
	local next_piece_length = #next_piece --#pieceStructures[sequence[#sequence]][1]

	for y = 1, next_piece_length do
		for x = 1, next_piece_length do
			local block =next_piece[y][x] --pieceStructures[sequence[#sequence]][1][y][x]
			if block ~= ' ' then
				draw_block(block, x+20, y +offsetY+3)
			end
		end
	end
	love.graphics.setColor(0,0,0)
	love.graphics.rectangle(
			'fill',
			(offsetX)*30,
			offsetY,
			30*gridXCount,
			30*2
	)
	love.graphics.setColor(255,255,255,255)
end