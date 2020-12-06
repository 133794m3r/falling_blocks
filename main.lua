---
--- Created by macarthur.
--- DateTime: 11/20/20 8:46 PM

require 'src/init'

function love.load()
	love.graphics.setBackgroundColor(0, 0, 0)
	--setting up my fonts.
	gUIFont = love.graphics.newFont(36)
	gItemFont = love.graphics.newFont(37)
	love.graphics.setFont(gUIFont)
	love.window.setMode(30 * (21 + 6), 30 * (23))
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
		['menu'] = function() return MainMenu() end,
		['start_marathon'] = function() return StartMarathon() end,
		['start_endless'] = function() return StartEndless() end,
		['time_attack'] = function() return TimeAttack() end,
	}
	gStateMachine:change('title')
	gameState = BaseGame()
end

function love.keypressed(key)
	gameState:handleInput(key);
end

function love.update(dt)
	--gameState:updateBoard(dt)
	gStateMachine:update(dt)
end

function love.draw()
	--gameState:draw()
	gStateMachine:render()
end