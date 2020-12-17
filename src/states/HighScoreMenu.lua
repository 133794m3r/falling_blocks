--[[
Rough layout of the UX for displaying the High Scores
Place Name          Score     Level    Lines
1.    Macarthur1  200,000        20      500
]]

HighScoreMenu = Class{__includes=BaseState}
function HighScoreMenu:enter(params)
	-- basic enum
	self.modes = {'marathon','sprint','endless'}
	-- game mode
	self.currentGameMode = params.mode or 1
	-- some font stuff
	self.descFont = love.graphics.newFont(32)
	love.graphics.setFont(gFonts['mono_md'])
	self.headerString = '<- ' .. self.modes[self.currentGameMode]:gsub("^%l",string.upper) .. ' High Scores ->'
end

function HighScoreMenu:update(dt)

end

function HighScoreMenu:handleInput(key)
	if key == 'left' then
		if self.currentGameMode == 1 then
			self.currentGameMode = 3
		else
			self.currentGameMode = self.currentGameMode - 1
		end
		self.headerString = '<- ' .. self.modes[self.currentGameMode]:gsub("^%l",string.upper) .. ' High Scores ->'
	elseif key == 'right' then
		if self.currentGameMode == 3 then
			self.currentGameMode = 1
		else
			self.currentGameMode = self.currentGameMode + 1
		end
		self.headerString = '<- ' .. self.modes[self.currentGameMode]:gsub("^%l",string.upper) .. ' High Scores ->'
	end
end

function HighScoreMenu:render()
	local name,score,level,lines = 0,0,0,0
	local rank_string = ''
	local format_str = ' %2d.%14s       %7s       %3d      %5d'
	local tmp_rank = {}
	local current_ranks =  gSaveData:getRanks(self.modes[self.currentGameMode])--gHighScores[self.modes[self.currentGameMode]]
	love.graphics.setFont(gFonts['mono_lg'])
	love.graphics.printf(self.headerString,0,0,780,'center')
	love.graphics.setFont(gFonts['mono_md'])
	love.graphics.printf(' Rank    Name            Score       Level      Lines',0,60,780,'left')
	for i=1,15 do
		tmp_rank = current_ranks[i]
		rank_string = sprintf(format_str,i,tmp_rank['name'],number_separator(tmp_rank['score']),tmp_rank['level'],tmp_rank['lines'])
		love.graphics.printf(rank_string,0,i*30+60,780,'left')
	end
	love.graphics.setFont(gFonts['mono_lg'])
	love.graphics.printf({{1,1,1,1},"Go to ",{0.85,0,0,1},"Main Menu",{1,1,1,1}," hit escape."},0,600,790,'center')
end