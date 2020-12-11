HighScoreTable = Class{}
function HighScoreTable:init(params)
	self.marathon = {}
	self.timeAttack = {}
	self.endless = {}
	local place_holder_name = 'Macarthur'
	for i=1,15 do
		table.insert(self.marathon,{
			['name'] = place_holder_name,
			['score'] = ((16-i)*350)+16000,
			['level'] = 15,
		})
		table.insert(self.timeAttack,{
			['name'] = place_holder_name,
			['score'] = ((16-i)*150)+6000,
			['level'] = 5,
		})
		table.insert(self.endless,{
			['name'] = place_holder_name,
			['score'] = ((16-i)*450)+20000,
			['level'] = 20,
		})
	end

end
function HighScoreTable:update()

end

function HighScoreTable:save()

end