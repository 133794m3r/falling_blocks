--[[
Rough layout of the UX for displaying the High Scores
Place Name          Score     Level    Lines
1.    Macarthur1  200,000        20      500
]]

HighScoreMenu = Class{__includes=BaseState}
function HighScoreMenu:enter(params)

end

function HighScoreMenu:update(dt)

end

function HighScoreMenu:handleInput(key)

end

function HighScoreMenu:render()
	bitser.dumpLoveFile('high_score_table.dat',gHighScores)
end