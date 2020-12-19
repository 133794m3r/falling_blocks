SaveData = Class{}
function SaveData:init(params)
	params = params or {}
	-- this is so that I can know if the save data needs to be updated for a future purpose mostly.
	self.version = params.version or 1
	self.difficulty = params.difficulty or 'hard'
	self.highScores = params.highScores or HighScoreTable()
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
