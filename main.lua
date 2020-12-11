---
--- Created by macarthur.
--- DateTime: 11/20/20 8:46 PM

require 'src/init'

function love.load()
	love.graphics.setBackgroundColor(0, 0, 0)
	--setting up my fonts.
	gUIFont = love.graphics.newFont(36)
	gItemFont = love.graphics.newFont(37)
	gMenuFont = love.graphics.newFont(48)
	love.graphics.setFont(gUIFont)
	love.window.setMode(30 * (20 + 6), 30 * (23))
	love.graphics.setDefaultFilter( 'nearest', 'nearest', 1 )
	--[[
	-- Title is the title screen that has the logo
	-- HighScores is the high scores menu that lets you see the best scores/initials for the different modes
	-- Add Score is when they have achieved one, we'll check their current mode and final score/items at the end of the game
	-- Help tells them the current controls for the game
	-- Menu is the main menu where they'll select between the modes, help screen, to see the high score table etc
	-- The three game modes all just go into the "GamePlay" state, but initialize the class based upon what they need.
	-- Plus they set their respective music tracks to play
	-- Start Marathon is the start of the Marathon game mode. Goal is to get max score within 15 levels.
	-- Start Endless is just that it's the endless mode get as high of a score as possible.
	-- Time Attack is trying to get to 50 lines as fast as possible
	]]

	gStateMachine = StateMachine {
		['title'] = function() return TitleState() end,
		['high_scores'] = function() return HighScores() end,
		['add_score'] = function() return AddHighScore() end,
		['help'] = function() return HelpScreen() end,
		['main_menu'] = function() return MainMenu() end,
		['start_marathon'] = function() return MarathonMode() end,
		['start_endless'] = function() return EndlessMode() end,
		['time_attack'] = function() return TimeAttack() end,
	}
	gStateMachine:change('main_menu')

	gHighScores = HighScoreTable()

	--if love.filesystem.getInfo('high_score_table.dat') then
	--	gHighScores = bitser.loadLoveFile('high_score_table.dat')
	--else
	--	gHighScores = HighScoreTable()
	--	bitser.dumpLoveFile('high_score_table.dat',gHighScores)
	--
	--end

end

function love.keypressed(key)
	gStateMachine:handleInput(key);
end

function love.update(dt)
	--gameState:updateBoard(dt)
	gStateMachine:update(dt)
	Timer.update(dt)
end

function love.draw()
	--gameState:draw()
	gStateMachine:render()
end