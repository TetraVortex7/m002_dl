function Respoint (keys )
    local caster = keys.caster     --пробиваем IP усопшего
    caster.respoint = caster:GetAbsOrigin() -- определяем точку спавна
end

function Respawn (keys )
    local caster= keys.caster                --пробиваем IP усопшего
    local point = caster.respoint            -- пробиваем адрес дома
    local team= caster:GetTeamNumber()      --пробиваем команду терпилы
    local name= caster:GetUnitName()         --Пробиваем имя покойного
    Timers:CreateTimer(10,function()              --Через сколько секунд появится новый фраер(5)
    local unit = CreateUnitByName(name, point + RandomVector( RandomFloat( 0, 50)), true, nil, nil, team)
-- создаем нового пацыка по трем аргументам ( имя покойного ,адрес дома ,true,nil,nil,команда терпилы)
    end)
end