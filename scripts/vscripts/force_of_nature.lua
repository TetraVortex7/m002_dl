
function ForceOfNature( event )
	local caster = event.caster
	local pID = event.caster:GetPlayerID()
	local ability = event.ability
	local point = event.target_points[1]
	local area_of_effect = ability:GetLevelSpecialValueFor( "area_of_effect", ability:GetLevel() - 1 )
	local max_treants = ability:GetLevelSpecialValueFor( "max_treants", ability:GetLevel() - 1 )
	local duration = ability:GetLevelSpecialValueFor( "duration", ability:GetLevel() - 1 )
	local unit_name = event.UnitName




	-- Create the units on the next frame
	Timers:CreateTimer(0.03,
		function() 
			--print(ability.trees_cut)
			local abilvl = ability:GetLevel()
			local treants_spawned = max_treants
			

			-- Spawn as many treants as possible
			for i=1,treants_spawned do
				local treant = CreateUnitByName(unit_name .. abilvl , point, true, caster, caster, caster:GetTeamNumber())
				treant:SetControllableByPlayer(pID, true)
				treant:AddNewModifier(caster, ability, "modifier_kill", {duration = duration})
			end
		end
	)
end
