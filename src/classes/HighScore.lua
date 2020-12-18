HighScoreTable = Class{}
function HighScoreTable:init(params)
	local marathon = {}
	local sprint = {}
	local endless = {}

	self.marathon = {
		['easy'] = {},
		['hard'] = {},
	}
	self.sprint = {
		['easy'] = {},
		['hard'] = {},
	}
	self.endless = {
		['easy'] = {},
		['hard'] = {},
	}
	local place_holder_name = 'Macarthur'
	local enum = {'easy','hard'}
	for _=1,2 do
		marathon = {}
		sprint = {}
		endless = {}
		for i=1,15 do
			table.insert(marathon,{
				['name'] = place_holder_name,
				['score'] = ((16-i)*350)+100,
				['level'] = 15,
				['lines'] = 150,
			})
			table.insert(sprint,{
				['name'] = place_holder_name,
				['score'] = ((16-i)*150)+6000,
				['level'] = 5,
				['lines'] = 50,
			})
			table.insert(endless,{
				['name'] = place_holder_name,
				['score'] = ((16-i)*450)+20000,
				['level'] = 20,
				['lines'] = 200,
			})
		end
		self.marathon[enum[_]] = marathon
		self.sprint[enum[_]] = sprint
		self.endless[enum[_]] = endless
	end
end

function HighScoreTable:checkScores(score)

end

function HighScoreTable:save()
	local str = bitser.dumps(self)
	print(#str)
end