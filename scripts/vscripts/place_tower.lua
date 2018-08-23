-- Константу пишем тут, чтобы была на виду
PLACED_BUILDING_RADIUS = 80;  
function placeBuilding(keys) -- Для предмета
  local caster = keys.caster
  -- Нам потребуется несколько переменных, они должны быть понятны
  blocking_counter = 0
  attempt_place_location = keys.target_points[1]
  -- Как же сложно! В основном, эта строка находит все объекты внутри PLACED_BUILDING_RADIUS от того, где мы хотим поставить башню
  -- Цикл для подсчета
  for _,thing in pairs(Entities:FindAllInSphere(GetGroundPosition(attempt_place_location, nil), PLACED_BUILDING_RADIUS) ) do
    blocking_counter = blocking_counter + 1
  end
  print(blocking_counter .. " blockers")

  -- Если есть объекты, которые мешают размещению башни, тогда не строим здесь, иначе - размещаем
  if( blocking_counter < 1) then
    local tower = CreateUnitByName("npc_dota_tower_lvl1", keys.target_points[1], true, nil, nil,caster:GetPlayerOwner():GetTeam() )

Timers:CreateTimer(0.1, function()
   
   tower:SetControllableByPlayer(caster:GetPlayerID(), true)
   tower:SetOwner(caster)
   return nil
  end)	
	else 
	local item = CreateItem("item_place_tower", caster, caster)
	caster:AddItem(item)
  end
  --local item = CreateItem("item_clarity", hero, hero)
  --hero:AddItem(item)
end
				
function replaceTower(keys) -- Для способности "Улучшить башню"
 local caster = keys.caster
 local origin = caster:GetAbsOrigin()
 local owner = caster:GetPlayerOwner() 
 if caster:GetUnitName() == "npc_dota_tower_lvl1" then towerz = "towerlvl2" end
 if caster:GetUnitName() == "towerlvl2" then towerz = "towerlvl3" end
 local towerB = towerz
 caster:AddNewModifier(caster, nil, "modifier_kill", {duration = 0.03})
Timers:CreateTimer(0.035, function()
   local tower2 = CreateUnitByName(towerB, origin, true, nil, nil,caster:GetPlayerOwner():GetTeam() )
return nil
  end)
  Timers:CreateTimer(0.5, function()
   tower2:SetControllableByPlayer(owner:GetPlayerID(), true)
 tower2:SetOwner(owner)   
return nil
  end)
			   		

end