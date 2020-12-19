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
	local place_holder_names = {'Macarthur','David','Inbody'}
	local enum = {'easy','hard'}
	local name_i = 1
	for _=1,2 do
		marathon = {}
		sprint = {}
		endless = {}
		for i=1,15 do
			table.insert(marathon,{
				['name'] = place_holder_names[name_i],
				['score'] = ((16-i)*1300)+11000,
				['level'] = 15,
				['lines'] = 150,
			})
			table.insert(sprint,{
				['name'] =place_holder_names[name_i],
				['score'] = ((16-i)*400)+5500,
				['level'] = 5,
				['lines'] = 50,
			})
			table.insert(endless,{
				['name'] =place_holder_names[name_i],
				['score'] = ((16-i)*1200)+18000,
				['level'] = 20,
				['lines'] = 200,
			})
			name_i = name_i == 3 and 1 or name_i + 1
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