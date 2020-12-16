-- fonts
gFonts = {
	['mono_sm'] = love.graphics.newFont('res/source_code_pro.otf',16),
	['mono_md'] = love.graphics.newFont('res/source_code_pro.otf',24),
	['mono_lg'] = love.graphics.newFont('res/source_code_pro.otf',36),
}


-- music
--[[
Sudocolon OGA. Chip Bit Danger will be used for level 14+ on Endless mode/final level of marathon aka level 14.
https://opengameart.org/content/chip-bit-danger
https://opengameart.org/content/this-game-is-over for game over music.
Oribital Colossus will be Time Attack

https://opengameart.org/content/twister-tetris Title screen/menu music/high score screen music.
https://opengameart.org/content/chiptune-techno Marathon Mode maybe
https://opengameart.org/content/let-the-games-begin-0 Endless Mode
]]

gMusic ={
	['title_music'] = love.audio.newSource('res/music/Twister Tetris.mp3','stream'),
	['sprint_theme'] = love.audio.newSource('res/music/Orbital Colossus.mp3','stream'),
	['normal_theme'] = love.audio.newSource('S31-Let the Games Begin.ogg','stream'),
	['final_countdown'] = love.audio.newSource('Chip Bit Danger.mp3','stream'),
	['game_over'] = love.audio.newSource('ThisGameIsOver.ogg','stream'),
}


--[[
https://opengameart.org/content/rpg-sound-pack
rotate and the block drop sounds.
]]
gSFX = {
	['rotate'] = love.audio.newSource('res/sfx/rotate.wav','static'),
	['drop'] = love.audio.newSource('res/sfx/drop.wav','static'),
}