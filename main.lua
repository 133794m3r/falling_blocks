---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by macarthur.
--- DateTime: 11/20/20 8:46 PM

require 'src/init'
require 'src/util'

function love.load()
	love.graphics.setBackgroundColor(0, 0, 0)
	for y = 0, gridYCount do
		inert[y] = {}
		for x = 1, gridXCount do
			inert[y][x] = ' '
		end
	end
	new_batch()
	new_piece()
	timer = 0
	gLastChance = nil
	uiFont = love.graphics.newFont(36)
	itemFont = love.graphics.newFont(37)
	love.graphics.setFont(uiFont)
	love.window.setMode(30 * (gridXCount + 16), 30 * (gridYCount))
	love.graphics.setDefaultFilter( 'nearest', 'nearest', 1 )
end

function love.keypressed(key)
	if key == 'x' or key == 'up' then
		local old_rotation = pieceRotation
		pieceRotation = (pieceRotation + 1)
		if pieceRotation > (#pieceStructures[pieceType]) then
			pieceRotation = 1
		end
		if not valid_move(pieceX,pieceY,pieceRotation) then
			pieceRotation = old_rotation
		end
	elseif key == 'z' or key == 'lctrl' or key == 'rctrl' then
		local old_rotation = pieceRotation
		pieceRotation = pieceRotation -1
		if pieceRotation == 0 then
			pieceRotation = #pieceStructures[pieceType]
		end
		if not valid_move(pieceX,pieceY,pieceRotation) then
			pieceRotation = old_rotation
		end
	elseif key == 'left' then

		if valid_move(pieceX-1,pieceY,pieceRotation) then
			pieceX = pieceX - 1
		--elseif gLastChance and valid_move(pieceX-1,pieceY-1,pieceRotation) then
		--	pieceX = pieceX - 1
		end
	elseif key == 'right' then
		if valid_move(pieceX+1,pieceY,pieceRotation) then
			pieceX = pieceX + 1
		--elseif gLastChance and valid_move(pieceX+1,pieceY-1,pieceRotation) then
		--	pieceX = pieceX +1
		end
	elseif key == 'down' then
		if valid_move(pieceX,pieceY+1,pieceRotation) then
			pieceY = pieceY + 1
		end
	elseif key == 'c' then
		while valid_move(pieceX, pieceY + 1, pieceRotation) do
			pieceY = pieceY + 1
			timer = 0.5
		end
	end

end

function love.update(dt)
	timer = timer + dt
	local fall_timer = 0.5
	if timer >= fall_timer then
		timer = timer - fall_timer
		local new_y = pieceY + 1
		if valid_move(pieceX, new_y,pieceRotation) then
			pieceY = new_y
		else
			--if gLastChance == nil then
			--		if valid_move(pieceX-1, pieceY, pieceRotation) or valid_move(pieceX+1, pieceY, pieceRotation) then
			--		print('here')
			--		gLastChance = true
			--		timer = -gravity_timer
			--		print(timer)
			--		pieceY = new_y
			--		--else
			--		--	gLastChance = false
			--		--end
			--		end
			--	else
					--pieceY  = pieceY - 1
					for y = 1, 4 do
						for x = 1, 4 do
							local block = pieceStructures[pieceType][pieceRotation][y][x]
							if block ~= ' ' then
								inert[pieceY + y][pieceX + x] = block
							end
						end
					end

					new_piece()
					if not valid_move(pieceX, pieceY, pieceRotation) then
						--if gLastChance == nil then
						--	if valid_move(pieceX-1, pieceY-1, pieceRotation) or valid_move(pieceX+1, pieceY-1, pieceRotation) then
						--		print('here')
						--		gLastChance = true
						--		timer = -gravity_timer
						--		print(timer)
						--	else
						--		gLastChance = false
						--	end
						--else
						--	gLastChance = false
						--end
						--if gLastChance == false then
						love.load()
						--	end
					--end
					--gLastChance = nil
				end
			end

	end
	for y =1, gridYCount do
		local line = true
		for x=1,gridXCount do
			if inert[y][x] == ' ' then
				line = false
				break
			end
		end
		if line then
			print('true')
			for clear_y=y,2,-1 do
				for clear_x=1,gridXCount do
					inert[clear_y][clear_x] = inert[clear_y -1][clear_x]
				end
			end
			for clear_x = 1, gridXCount do
				inert[1][clear_x] = ' '
			end
		end
	end
end

function love.draw()
	local offsetX = 7
	local offsetY = 0
	for y = 2, gridYCount do
		for x = 1, gridXCount do
			draw_block(inert[y][x],x+offsetX,y+offsetY)
		end
	end
	for y=1,4 do
		for x=1,4 do
			local block = pieceStructures[pieceType][pieceRotation][y][x]
			if block ~= ' ' then
				draw_block(block,x+pieceX +offsetX,y+pieceY-1 + offsetY)
			end
		end
	end
	local sw = love.graphics.getWidth()
	local aw = 30 * 10
	local blockSize = 30
	local score = 20000000
	local level = 55
	local lines = 2000
	love.graphics.setColor(255, 255, 255)
	love.graphics.printf("HELD", blockSize-1,blockSize * (offsetY+1) , sw - aw, "left")
	love.graphics.printf("NEXT", aw-(blockSize+10),blockSize * (offsetY+1), sw - aw, "right")
	love.graphics.printf("SCORE", aw-(blockSize+10),blockSize * (offsetY+9), sw - aw, "right")
	love.graphics.printf(number_seperator(score),itemFont,aw-(blockSize),blockSize * (offsetY+11), sw - aw +15, "right")
	love.graphics.printf("LINES", aw-(blockSize+10),blockSize * (offsetY+14), sw - aw, "right")
	love.graphics.printf(number_seperator(lines),itemFont, aw-(blockSize+8),blockSize * (offsetY+16), sw - aw, "right")
	love.graphics.printf("LEVEL",  blockSize-1,blockSize * (offsetY+14), sw - aw, "left")
	love.graphics.print(string.format("%05s",number_seperator(level)), itemFont, blockSize*2,blockSize * (offsetY+16))
	for y = 1, 4 do
		for x = 1, 4 do
			local block = pieceStructures[sequence[#sequence]][1][y][x]
			if block ~= ' ' then
				draw_block(block, x+20, y +offsetY+2)
			end
		end
	end
end