--[[
    Copyright (C) 2020  Macarthur David Inbody <admin-contact@transcendental.us>

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.
]]

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
				['score'] = ((17-i)*1600)+11000,
				['level'] = 15,
				['lines'] = 150,
			})
			table.insert(sprint,{
				['name'] =place_holder_names[name_i],
				['score'] = ((17-i)*1300)+10500,
				['level'] = 5,
				['lines'] = 50,
			})
			table.insert(endless,{
				['name'] =place_holder_names[name_i],
				['score'] = ((17-i)*3200)+18000,
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