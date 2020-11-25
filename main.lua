---
--- Created by macarthur.
--- DateTime: 11/20/20 8:46 PM

Class = require 'lib/class'
bitser = require 'lib/bitser'
require 'src/init'
require 'src/util'
require 'src/misc'
require 'src/core_logic'

function love.load()
	love.graphics.setBackgroundColor(0, 0, 0)
	--setting up my fonts.
	gUIFont = love.graphics.newFont(36)
	gItemFont = love.graphics.newFont(37)
	love.graphics.setFont(gUIFont)
	love.window.setMode(30 * (18 + 6), 30 * (22))
	love.graphics.setDefaultFilter( 'nearest', 'nearest', 1 )
	init_game()
	gameState = BaseGame()
end

function love.keypressed(key)
	gameState:handleInput(key);
end

function love.update(dt)
	gameState:updateBoard(dt)
end

function love.draw()
	gameState:draw()
end