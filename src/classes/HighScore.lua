HighScoreTable = Class{}
function HighScoreTable:init(params)
	self.marathon = {}
	self.sprint = {}
	self.endless = {}
	local place_holder_name = 'Macarthur'
	for i=1,15 do
		table.insert(self.marathon,{
			['name'] = place_holder_name,
			['score'] = ((16-i)*35000)+10000,
			['level'] = 15,
			['lines'] = 150,
		})
		table.insert(self.sprint,{
			['name'] = place_holder_name,
			['score'] = ((16-i)*150)+6000,
			['level'] = 5,
			['lines'] = 50,
		})
		table.insert(self.endless,{
			['name'] = place_holder_name,
			['score'] = ((16-i)*450)+20000,
			['level'] = 20,
			['lines'] = 200,
		})
	end

end

function HighScoreTable:update()

end

function HighScoreTable:save()
	local str = bitser.dumps(self)
	print(#str)
end