SaveData = Class{}
function SaveData:init()
	self.difficulty = 1
	self.highScores = HighScoreTable()
	self.difficulties = {'easy','hard'}
end

function SaveData:getRankInfo(mode,index)
	return self.highScores[mode][self.difficulties[self.difficulty]][index]
end

function SaveData:getRanks(mode)
	return self.highScores[mode][self.difficulties[self.difficulty]]
end

function SaveData:getScore(mode,index)
	return self.highScores[mode][self.difficulties[self.difficulty]][index].score
end

function SaveData:addScore(mode,index)
	table.insert(self.highScores[mode][self.difficulties[self.difficulty]],index)
	table.remove(self.highScores[mode][self.difficulties[self.difficulty]],15)
end

function SaveData:save()
	-- this is just for testing to see how big the file will be.
	local str = bitser.dumps(self)
	print(#str)
end
