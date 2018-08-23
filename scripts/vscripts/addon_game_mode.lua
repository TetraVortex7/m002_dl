-- This is the entry-point to your game mode and should be used primarily to precache models/particles/sounds/etc
require('modmaker')
require('attachments')
require('internal/util')
require('gamemode')

function Precache( context )


  DebugPrint("[BAREBONES] Performing pre-load precache")


 
  --PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_gyrocopter.vsndevts", context)

  PrecacheUnitByNameSync("unit_1", context)
  PrecacheUnitByNameSync("unit_2", context)
    PrecacheUnitByNameSync("unit_3", context)
  PrecacheUnitByNameSync("unit_4", context)
  PrecacheUnitByNameSync("unit_5", context)
  PrecacheUnitByNameSync("unit_6", context)
    PrecacheUnitByNameSync("unit_7", context)
  PrecacheUnitByNameSync("unit_8", context)
  PrecacheUnitByNameSync("unit_9", context)
  PrecacheUnitByNameSync("unit_10", context)
    PrecacheUnitByNameSync("unit_11", context)
  PrecacheUnitByNameSync("unit_12", context)
  PrecacheUnitByNameSync("unit_13", context)
  PrecacheUnitByNameSync("unit_14", context)
    PrecacheUnitByNameSync("unit_15", context)
  PrecacheUnitByNameSync("unit_16", context)
  PrecacheUnitByNameSync("unit_17", context)
  PrecacheUnitByNameSync("unit_18", context)
    PrecacheUnitByNameSync("unit_19", context)
  PrecacheUnitByNameSync("unit_20", context)
  PrecacheUnitByNameSync("unit_21", context)
  PrecacheUnitByNameSync("unit_22", context)
    PrecacheUnitByNameSync("unit_23", context)
  PrecacheUnitByNameSync("unit_24", context)   
  PrecacheUnitByNameSync("unit_25", context)
   PrecacheUnitByNameSync("BOSS", context)
  PrecacheUnitByNameSync("wolves_1", context)   
  PrecacheUnitByNameSync("wolves_2", context)
   PrecacheUnitByNameSync("wolves_3", context)
  PrecacheUnitByNameSync("bat_1", context)   
  PrecacheUnitByNameSync("Krot_sl", context)
   PrecacheUnitByNameSync("Krot_sr", context)
   PrecacheUnitByNameSync("ursa_yellow", context)
   
   PrecacheUnitByNameSync("necro_skeleton_1", context)
  PrecacheUnitByNameSync("necro_skeleton_2", context)
    PrecacheUnitByNameSync("necro_skeleton_3", context)
  PrecacheUnitByNameSync("necro_skeleton_4", context)
  PrecacheUnitByNameSync("necro_skeleton_5", context)
  PrecacheUnitByNameSync("necro_skeleton_6", context)
    PrecacheUnitByNameSync("necro_skeleton_7", context)
  PrecacheUnitByNameSync("necro_skeleton_8", context)
  PrecacheUnitByNameSync("necro_skeleton_9", context)
  PrecacheUnitByNameSync("necro_skeleton_10", context)
    PrecacheUnitByNameSync("necro_skeleton_11", context)
  PrecacheUnitByNameSync("necro_skeleton_12", context)
  PrecacheUnitByNameSync("necro_skeleton_13", context)
  PrecacheUnitByNameSync("necro_skeleton_14", context)
    PrecacheUnitByNameSync("necro_skeleton_15", context)
  PrecacheUnitByNameSync("necro_skeleton_16", context)
  PrecacheUnitByNameSync("necro_skeleton_17", context)
  PrecacheUnitByNameSync("necro_skeleton_18", context)
    PrecacheUnitByNameSync("necro_skeleton_19", context)
  PrecacheUnitByNameSync("necro_skeleton_20", context)
      
  PrecacheUnitByNameSync("towerlvl2", context)
   PrecacheUnitByNameSync("towerlvl3", context)
   PrecacheUnitByNameSync("npc_dota_tower_lvl1", context)  
   PrecacheUnitByNameSync("pig_d", context)
      PrecacheUnitByNameSync("wr_treant", context)
	  
   
   PrecacheModel("models/creeps/neutral_creeps/n_creep_kobold/kobold_c/n_creep_kobold_frost.vmdl", context)
   PrecacheModel("models/props_gameplay/pig.vmdl", context)
    PrecacheModel("models/creeps/neutral_creeps/n_creep_eimermole/n_creep_eimermole.vmdl", context)
	 PrecacheModel("models/creeps/neutral_creeps/n_creep_eimermole/n_creep_eimermole_lamp.vmdl", context)
	 PrecacheModel("models/heroes/furion/treant.vmdl", context)
	 	 PrecacheModel("models/creeps/neutral_creeps/n_creep_troll_skeleton/n_creep_skeleton_melee.vmdl", context)

end

-- Create the game mode when we activate
function Activate()
  GameRules.GameMode = GameMode()
  GameRules.GameMode:_InitGameMode()
  GameRules:SetStrategyTime(0)
  GameRules:SetShowcaseTime(0)

end

