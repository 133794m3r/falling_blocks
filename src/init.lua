-- importing module
Class = require 'lib/class'
bitser = require 'lib/bitser'
Timer = require 'lib/timer'

-- misc utilities and such
require 'src/util'
require 'src/misc'
require 'src/state_machine'

-- game modes
require 'src/modes/core_logic'
require 'src/modes/marathon_mode'


--states
require 'src/states/base_state'
require 'src/states/Title'
require 'src/states/MainMenu'
require 'src/states/Marathon'

-- classes
require 'src/classes/HighScore'
require 'src/classes/SaveData'

-- registering classes that need to be serialized.
HighScoreTable = bitser.registerClass('HighScoreTable',HighScoreTable)