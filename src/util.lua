function valid_move(test_x,test_y,testRotation)
	local test_block_x = 0
	local test_block_y = 0
	for x=1,4 do
		test_block_x = x + test_x
		for y=1,4 do
			local testBlockX = test_x + x
			local testBlockY = test_y + y
			if pieceStructures[pieceType][testRotation][y][x] ~= ' '
					and (
					testBlockX < 1
							or testBlockX > gridXCount
							or testBlockY > gridYCount
							or inert[testBlockY][testBlockX] ~= ' '
			) then
				return false
			end
		end
	end
	return true
end
function canPieceMove(testX, testY, testRotation)
	for x = 1, 4 do
		for y = 1, 4 do
			local testBlockX = testX + x
			local testBlockY = testY + y

			if pieceStructures[pieceType][testRotation][y][x] ~= ' '
					and (
					testBlockX < 1
							or testBlockX > gridXCount
							or testBlockY > gridYCount
							or inert[testBlockY][testBlockX] ~= ' '
			) then
				return false
			end
		end
	end

	return true
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