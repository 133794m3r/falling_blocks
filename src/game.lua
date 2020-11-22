---
--- Created by macarthur.
--- DateTime: 11/22/20 5:07 PM
---
---
---
function update_piece(dt)
	gGravityTimer = gGravityTimer + dt
	gLockTimer = gLockTimer + dt
	if gGravityTimer >= gFallTimer then
		gGravityTimer = gGravityTimer - gFallTimer
		local new_y = pieceY + 1
		if valid_move(pieceX, new_y,pieceRotation) then
			pieceY = new_y
		else
			if gLockTimer > gLockTime then
				if valid_move(pieceX, new_y,pieceRotation) then
					piece_y = new_y
				end
				for y = 0, pieceLength-1 do
					for x = 1, pieceLength do
						local block = pieceStructures[pieceType][pieceRotation][y+1][x]
						if block ~= ' ' then
							inert[pieceY + y][pieceX + x] = block
						end
					end
				end
				gLockTimer = 0
				new_piece()

				if not valid_move(pieceX, pieceY, pieceRotation) then
					init_game()
				end
			else
				--print_r(inert)
				--print_r(piece)
				--love.timer.sleep(1)
			end

		end

	end
end
function check_clears()
	local lines = 0
	for y =1, gridYCount do
		local line = true
		for x=1,gridXCount do
			if inert[y][x] == ' ' then
				line = false
				break
			end
		end
		if line then
			lines = lines + 1
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
	if lines ~= 0 then
		local multiplier = {
			[1] = 100,
			[2] = 300,
			[3] = 500,
			[4] = 800,
		}
		gScore = gScore + (gLevel * multiplier[lines])
		gLines = lines + gLines
		if gLines % 10 == 0 then
			gLevel = gLevel + 1
		end
	end
end

function update_board(dt)
	update_piece(dt)
	check_clears()
end
