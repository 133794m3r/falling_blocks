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
require 'src/states/base_state'


-- menus
require 'src/states/menus/Title'
require 'src/states/menus/MainMenu'
require 'src/states/menus/CheckScores'
require 'src/states/menus/HighScoreMenu'
require 'src/states/menus/SettingsMenu'
require "src/states/menus/HelpScreen"


-- base game mode
require 'src/modes/core_logic'

-- derived game modes
require 'src/states/modes/Marathon'
require 'src/states/modes/Endless'
require 'src/states/modes/TimeAttack'


-- classes
require 'src/classes/HighScore'
require 'src/classes/SaveData'

-- registering classes that need to be serialized.
HighScoreTable = bitser.registerClass('HighScoreTable',HighScoreTable)
SaveData = bitser.registerClass('SaveData',SaveData)