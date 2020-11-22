pieceStructures = {
	{
		{
			{' ', ' ', ' ', ' '},
			{' ', ' ', ' ', ' '},
			{'i', 'i', 'i', 'i'},
			{' ', ' ', ' ', ' '},
		},
		{
			{' ', 'i', ' ', ' '},
			{' ', 'i', ' ', ' '},
			{' ', 'i', ' ', ' '},
			{' ', 'i', ' ', ' '},
		},
	},
	{
		{
			{'o', 'o'},
			{'o', 'o'},
		},
	},
	{
		{
			{' ', ' ', ' '},
			{'j', 'j', 'j'},
			{' ', ' ', 'j'},
		},
		{
			{' ', 'j', ' '},
			{' ', 'j', ' '},
			{'j', 'j', ' '},
		},
		{
			{' ', ' ', ' '},
			{'j', ' ', ' '},
			{'j', 'j', 'j'},
		},
		{
			{' ', 'j', 'j'},
			{' ', 'j', ' '},
			{' ', 'j', ' '},
		},
	},
	{
		{
			{' ', ' ', ' '},
			{'l', 'l', 'l'},
			{'l', ' ', ' '},
		},
		{
			{' ', 'l', ' '},
			{' ', 'l', ' '},
			{' ', 'l', 'l'},
		},
		{
			{' ', ' ', ' '},
			{' ', ' ', 'l'},
			{'l', 'l', 'l'},
		},
		{
			{'l', 'l', ' '},
			{' ', 'l', ' '},
			{' ', 'l', ' '},
		},
	},
	{
		{
			{' ', ' ', ' '},
			{'t', 't', 't'},
			{' ', 't', ' '},
		},
		{
			{' ', 't', ' '},
			{' ', 't', 't'},
			{' ', 't', ' '},
		},
		{
			{' ', ' ', ' '},
			{' ', 't', ' '},
			{'t', 't', 't'},
		},
		{
			{' ', 't', ' '},
			{'t', 't', ' '},
			{' ', 't', ' '},
		},
	},
	{
		{
			{' ', ' ', ' '},
			{' ', 's', 's'},
			{'s', 's', ' '},
		},
		{
			{'s', ' ', ' '},
			{'s', 's', ' '},
			{' ', 's', ' '},
		},
	},
	{
		{
			{' ', ' ', ' '},
			{'z', 'z', ' '},
			{' ', 'z', 'z'},
		},
		{
			{' ', 'z', ' '},
			{'z', 'z', ' '},
			{'z', ' ', ' '},
		},
	},
}
gridXCount = 10
gridYCount = 22
function init_game()

	inert = {}
	for y = 0, gridYCount do
		inert[y] = {}
		for x = 1, gridXCount do
			inert[y][x] = ' '
		end
	end
	-- have to make sure that we create a new batch. and that we also get a new piece.
	new_batch()
	new_piece()


	-- the game variables.
	gGravityTimer = 0
	gFallTimer = 0.5
	gLastChance = nil
	gLockTimer = 0
	-- the amount of time we should wait until the item is locked.
	--[[
		for levels above 20 in endless what happens is that this is slowly
		decreased over time by 0.05s per level.
	]]
	gLockTime = 0.5
	gScore = 0
	gLevel = 1
	gLines = 0
	-- seconds for how long it should take for the piece to fall 1 row.
	-- "Hard" mode uses the official timelines.
	gHardDropTimes = {1.0, 0.793, 0.6178, 0.4727, 0.3552, 0.262, 0.1897, 0.1347, 0.0939, 0.0642, 0.043, 0.0282, 0.0182, 0.0114, 0.0071, 0.0043, 0.0025, 0.0015, 0.0008}
	-- Easy mode has the formula modified such that the default time is increased by 0.05s per cell.
	gEasyDropTimes = {1.0, 0.803, 0.6336, 0.4912, 0.374, 0.2796, 0.2052, 0.1478, 0.1045, 0.0724, 0.0492, 0.0328, 0.0214, 0.0137, 0.0086, 0.0053, 0.0032, 0.0019, 0.0011, 1.0, 0.843, 0.6989, 0.5697, 0.4565, 0.3596, 0.2783, 0.2116, 0.158, 0.1158, 0.0834, 0.0589, 0.0408, 0.0277, 0.0185, 0.0121, 0.0077, 0.0049, 0.003}
end