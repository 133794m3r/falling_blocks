function valid_move(test_x,test_y,testRotation,printit)
	local maxY = (gridYCount+1) - pieceLength
	if test_y > maxY then
		return false
	end
	for x=1,pieceLength do
		local testBlockX = test_x + x
		for y=0,pieceLength-1 do
			local testBlockY = test_y + y
			if printit then
				print('y',y)
				print('test_x',test_x)
				print('test_y',test_y)
				print('ty',testBlockY)
				print('tx',testBlockX)
				--print_r(inert)
			end
			if pieceStructures[pieceType][testRotation][y+1][x] ~= ' ' then
				--and (

				if
				testBlockX < 1
						or testBlockX > gridXCount
						or testBlockY > gridYCount
						or inert[testBlockY][testBlockX] ~= ' '
				then
					return false
				end

			end
		end
	end
	return true
end
function canPieceMove(testX, testY, testRotation)
	for x = 1, pieceLength do
		for y = 1, pieceLength do
			local testBlockX = testX + x
			local testBlockY = testY + y

			if pieceStructures[pieceType][testRotation][y][x] ~= ' '
					and (
					testBlockX < 1
							or testBlockX > gridXCount
							or testBlockY > (gridYCount+1)
							or inert[testBlockY][testBlockX] ~= ' '
			) then
				return false
			else
				print(testBlockY)
			end
		end
	end

	return true
end

function can_rotate(old_rotation,new_rotation)
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
	local old_x, old_y = pieceX, pieceY
	local new_x, new_y,mod_x, mod_y = 0,0,0,0

	if pieceType == 1 then
		if not valid_move(old_x,old_y,new_rotation+1) then
			for i=1,4 do
				mod_x,mod_y = unpack(kick_data_i[old_rotation][new_rotation][i])
				new_x,new_y = old_x+mod_x, old_y+mod_y
				if valid_move(new_x,new_y,new_rotation+1) then
					valid = true
					pieceX = new_x
					pieceY = new_y
					break
				end
			end
		else
			valid = true
		end
	else
		if not valid_move(old_x,old_y,new_rotation+1) then
			for i=1,4 do
				mod_x,mod_y = unpack(kick_data_normal[old_rotation][new_rotation][i])
				new_x,new_y = old_x+mod_x, old_y+mod_y
				if valid_move(new_x,new_y,new_rotation+1) then
					valid = true
					pieceX = new_x
					pieceY = new_y
					break
				end
			end
		else
			valid = true
		end
	end
	return valid
end

function new_batch()
	sequence = {}
	for x=1, 7 do
		local position = math.random(x+1)
		table.insert(sequence,position,x)
	end
end

function new_piece()
	pieceX = 3
	pieceY = 1
	pieceRotation = 1
	pieceType = table.remove(sequence)
	pieceLength = #pieceStructures[pieceType][1]
	if #sequence == 0 then
		new_batch()
	end
end

function draw_block(block,x,y)
	local colors = {
		[' '] = {.87, .87, .87},
		i = {.47, .76, .94},
		j = {.93, .91, .42},
		l = {.49, .85, .76},
		o = {.92, .69, .47},
		s = {.83, .54, .93},
		t = {.97, .58, .77},
		z = {.66, .83, .46},
		[0] = {0,0,0,0},
	}
	local color = colors[block]
	love.graphics.setColor(color)

	local blockSize = 30
	local blockDrawSize = blockSize - 1
	love.graphics.rectangle(
			'fill',
			(x - 1) * blockSize,
			(y - 1) * blockSize,
			blockDrawSize,
			blockDrawSize
	)
end

function number_seperator(v)
	local s = string.format("%d", math.floor(v))
	local pos = string.len(s) % 3
	if pos == 0 then pos = 3 end
	return string.sub(s, 1, pos) .. string.gsub(string.sub(s, pos+1), "(...)", ",%1")
end
function format_score()

end