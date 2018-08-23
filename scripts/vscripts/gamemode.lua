-- This is the primary barebones gamemode script and should be used to assist in initializing your game mode
BAREBONES_VERSION = "1.00"

-- Set this to true if you want to see a complete debug output of all events/processes done by barebones
-- You can also change the cvar 'barebones_spew' at any time to 1 or 0 for output/no output
BAREBONES_DEBUG_SPEW = false 

if GameMode == nil then
    DebugPrint( '[BAREBONES] creating barebones game mode' )
    _G.GameMode = class({})	
	_G.Filter = class({})
end
-- This library can be used for starting customized animations on units from lua
require('libraries/animations')
-- This library can be used for advancted physics/motion/collision of units.  See PhysicsReadme.txt for more information.
require('libraries/physics')
-- This library can be used for advanced 3D projectile systems.
require('libraries/projectiles')

-- This library can be used for performing "Frankenstein" attachments on units
require('attachments')
-- This library can be used to create container inventories or container shops
require('libraries/containers')

-- This library allow for easily delayed/timed actions
require('libraries/timers')


-- This library can be used for sending panorama notifications to the UIs of players/teams/everyone
require('libraries/notifications')

-- This library can be used to synchronize client-server data via player/client-specific nettables
require('libraries/playertables')

-- This library provides a searchable, automatically updating lua API in the tools-mode via "modmaker_api" console command
require('modmaker')
-- This library provides an automatic graph construction of path_corner entities within the map
require('libraries/pathgraph')
-- This library (by Noya) provides player selection inspection and management from server lua
require('libraries/selection')

-- These internal libraries set up barebones's events and processes.  Feel free to inspect them/change them if you need to.
require('internal/gamemode')
require('internal/events')

-- settings.lua is where you can specify many different properties for your game mode and is one of the core barebones files.
require('settings')
-- events.lua is where you can specify the actions to be taken when any event occurs and is one of the core barebones files.
require('events')


-- This is a detailed example of many of the containers.lua possibilities, but only activates if you use the provided "playground" map



GAME_ROUND = 0 -- номер текущего раунда
MAX_ROUNDS = 40 -- номер конечного раунда
ROUND_UNITS = 20 -- кол-во юнитов на 1 раунде

--require("examples/worldpanelsExample")

--[[
  This function should be used to set up Async precache calls at the beginning of the gameplay.

  In this function, place all of your PrecacheItemByNameAsync and PrecacheUnitByNameAsync.  These calls will be made
  after all players have loaded in, but before they have selected their heroes. PrecacheItemByNameAsync can also
  be used to precache dynamically-added datadriven abilities instead of items.  PrecacheUnitByNameAsync will 
  precache the precache{} block statement of the unit and all precache{} block statements for every Ability# 
  defined on the unit.

  This function should only be called once.  If you want to/need to precache more items/abilities/units at a later
  time, you can call the functions individually (for example if you want to precache units in a new wave of
  holdout).

  This function should generally only be used if the Precache() function in addon_game_mode.lua is not working.
]]
function GameMode:PostLoadPrecache()
  DebugPrint("[BAREBONES] Performing Post-Load precache")    
  
end

--[[
  This function is called once and only once as soon as the first player (almost certain to be the server in local lobbies) loads in.
  It can be used to initialize state that isn't initializeable in InitGameMode() but needs to be done before everyone loads in.
]]
function GameMode:OnFirstPlayerLoaded()
  DebugPrint("[BAREBONES] First Player has loaded")
end

--[[
  This function is called once and only once after all players have loaded into the game, right as the hero selection time begins.
  It can be used to initialize non-hero player state or adjust the hero selection (i.e. force random etc)
]]
function GameMode:OnAllPlayersLoaded()
  DebugPrint("[BAREBONES] All Players have loaded into the game")
end

--[[
  This function is called once and only once for every player when they spawn into the game for the first time.  It is also called
  if the player's hero is replaced with a new hero for any reason.  This function is useful for initializing heroes, such as adding
  levels, changing the starting gold, removing/adding abilities, adding physics, etc.

  The hero parameter is the hero entity that just spawned in
]]
function GameMode:OnHeroInGame(hero)
  DebugPrint("[BAREBONES] Hero spawned in game for first time -- " .. hero:GetUnitName())

  -- This line for example will set the starting gold of every hero to 500 unreliable gold
  hero:SetGold(10, false)

  -- These lines will create an item and add it to the player, effectively ensuring they start with the item
  --local item = CreateItem("item_clarity", hero, hero)
  --hero:AddItem(item)

  --[[ --These lines if uncommented will replace the W ability of any hero that loads into the game
    --with the "example_ability" ability
  
  local abil = hero:GetAbilityByIndex(1)
  hero:RemoveAbility(abil:GetAbilityName())
  hero:AddAbility("example_ability")]]
end

--[[
  This function is called once and only once when the game completely begins (about 0:00 on the clock).  At this point,
  gold will begin to go up in ticks if configured, creeps will spawn, towers will become damageable etc.  This function
  is useful for starting any game logic timers/thinkers, beginning the first round, etc.
]]
function GameMode:OnGameInProgress()
  DebugPrint("[BAREBONES] The game has officially begun")

  Timers:CreateTimer(30, -- Start this timer 30 game-time seconds later
    function()
      DebugPrint("This function is called 30 seconds after the game begins, and every 30 seconds thereafter")
      return 30.0 -- Rerun this timer every 30 game-time seconds 
    end)
	
	GameRules:SetStrategyTime(0)
	
	local point = Entities:FindByName( nil, "spawner1"):GetAbsOrigin() -- первый спавнер волн
	local point2 = Entities:FindByName( nil, "spawner2"):GetAbsOrigin() -- первый спавнер волн
	local waypoint = Entities:FindByName( nil, "1") -- вейпоинт до которого идут крипы с первого спавнера
	local return_time = 120 -- время между волнами
	

	Timers:CreateTimer(180, function()	-- время до начала первой волны 
	GAME_ROUND = GAME_ROUND + 1 -- объявление следущего раунда (не трогаем)
		if GAME_ROUND == MAX_ROUNDS -- просто не трогаем
		then return_time = nil -- тоже не трогаем
		end -- конец проверки которую не трогаем
		
		for i=1, ROUND_UNITS do  -- для i(переменная) от одного до количества юнитов на волну
		
		local unit = CreateUnitByName( "unit_" .. GAME_ROUND, point + RandomVector( RandomFloat( 0, 200 ) ), true, nil, nil, DOTA_TEAM_NEUTRALS ) -- спавним юнитов за нейтралов
		unit:SetInitialGoalEntity( waypoint )
		
		local unit = CreateUnitByName( "unit_" .. GAME_ROUND, point2 + RandomVector( RandomFloat( 0, 200 ) ), true, nil, nil, DOTA_TEAM_NEUTRALS ) -- спавним юнитов за нейтралов
		unit:SetInitialGoalEntity( waypoint ) 
		
		end
	return return_time 
	end)
	
	
	
end



-- This function initializes the game mode and is called before anyone loads into the game
-- It can be used to pre-initialize any values/tables that will be needed later
function GameMode:InitGameMode()
  GameMode = self
  DebugPrint('[BAREBONES] Starting to load Barebones gamemode...')

  -- Commands can be registered for debugging purposes or as functions that can be called by the custom Scaleform UI
  Convars:RegisterCommand( "command_example", Dynamic_Wrap(GameMode, 'ExampleConsoleCommand'), "A console command example", FCVAR_CHEAT )
  DebugPrint('[BAREBONES] Done loading Barebones gamemode!\n\n')
  GameRules:GetGameModeEntity():SetDamageFilter( Dynamic_Wrap( Filter, "DamageFilter" ), self )
end

function Filter:DamageFilter( kv ) --[[ Эта функция будет вызываться каждый раз, когда происходит событие, т.е. каждый раз при получении урона. Тут и будет происходить обработка. kv - таблица с описанием события. ]]
    local ability
    local attacker
    local victim
    if kv.entindex_inflictor_const then --[[ так можно проверить, существует ли вообще такая переменная, или же там nil ]]
        ability = EntIndexToHScript(kv.entindex_inflictor_const)
    end
	attacker = EntIndexToHScript(kv.entindex_attacker_const)
    victim = EntIndexToHScript(kv.entindex_victim_const)
	
	if (attacker:GetUnitName() == "npc_dota_tower_lvl1" or attacker:GetUnitName() == "towerlvl2")  and (victim:GetUnitName() == "bat_1" or victim:GetUnitName() == "Krot_sl" or victim:GetUnitName() == "Krot_sr" or victim:GetUnitName() == "BOSS" or victim:GetUnitName() == "ursa_yellow" or victim:GetUnitName() == "wolves_1" or victim:GetUnitName() == "wolves_2" or victim:GetUnitName() == "wolves_3") then return false 
	else return true	
	end
	
    return true --[[ Да, функция еще и что-то возвращать должна. Позднее узнаем, что именно. ]]
end



-- This is an example console command
function GameMode:ExampleConsoleCommand()
  print( '******* Example Console Command ***************' )
  local cmdPlayer = Convars:GetCommandClient()
  if cmdPlayer then
    local playerID = cmdPlayer:GetPlayerID()
    if playerID ~= nil and playerID ~= -1 then
      -- Do something here for the player who called this command
      PlayerResource:ReplaceHeroWith(playerID, "npc_dota_hero_viper", 1000, 1000)
    end
  end

  print( '*********************************************' )
end