SaveData = Class{}
function SaveData:init()
	self.difficulty = 'hard'
	self.highScores = HighScoreTable()
end

function SaveData:getRankInfo(mode,index)
	return self.highScores[mode][self.difficulty][index]
end

function SaveData:getRanks(mode)
	return self.highScores[mode][self.difficulty]
end

function SaveData:getScore(mode,index)
	return self.highScores[mode][self.difficulty][index].score
end

function SaveData:addScore(mode,index,params)
	table.insert(self.highScores[mode][self.difficulty],index,params)
	table.remove(self.highScores[mode][self.difficulty],15)
end

function SaveData:save()
	-- this is just for testing to see how big the file will be.
	local str = bitser.dumps(self)
	print(#str)
end
