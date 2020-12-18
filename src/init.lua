-- importing module
Class = require 'lib/class'
bitser = require 'lib/bitser'
Timer = require 'lib/timer'


-- misc utilities and such
require 'src/util'
require 'src/misc'
require 'src/state_machine'


-- asset file loader
require 'src/assets'


-- the base state
require 'src/base_state'


-- menus
require 'src/menus/Title'
require 'src/menus/MainMenu'
require 'src/menus/CheckScores'
require 'src/menus/HighScoreMenu'
require 'src/menus/SettingsMenu'
require "src/menus/HelpScreen"


-- base game mode
require 'src/modes/core_logic'

-- derived game modes
require 'src/modes/Marathon'
require 'src/modes/Endless'
require 'src/modes/TimeAttack'


-- classes
require 'src/classes/HighScore'
require 'src/classes/SaveData'

-- registering classes that need to be serialized.
HighScoreTable = bitser.registerClass('HighScoreTable',HighScoreTable)
SaveData = bitser.registerClass('SaveData',SaveData)