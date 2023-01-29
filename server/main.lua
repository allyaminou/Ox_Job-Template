local players = {}
local table = lib.table

--[[ --------------------------------------------------------------------------------
<! Methods grabbed from Overextended's ox_police for reference !>
<! because it was the only ox based job on github !>
<! Ref: https://github.com/overextended/ox_police/blob/main/server/main.lua !>
-------------------------------------------------------------------------------- ]]--

-- Method for getting players in the provided job groups
CreateThread(function()
    for _, player in pairs(Ox.GetPlayers(true, { groups = Config.JobGroups })) do
        local inService = player.get('inService')
        if inService and table.contains(Config.JobGroups, inService) then
            players[player.source] = player
        end
    end
end)

-- Method for registering players in service of job
RegisterNetEvent('ox:setPlayerInService', function(group)
    local player = Ox.GetPlayer(source)
    if player then
        if group and table.contains(Config.JobGroups, group) and player.hasGroup(Config.JobGroups) then
            players[source] = player
            return player.set('inService', group, true)
        end
        player.set('inService', false, true)
    end
    players[source] = nil
end)

-- Method for player logging out
AddEventHandler('ox:playerLogout', function(source)
    players[source] = nil
end)

-- Callback for player registering in service
-- Change 'ox_police:' part of code here
lib.callback.register('ox_police:isPlayerInService', function(source, target)
    return players[target or source]
end)

--[[ References for player targeting

lib.callback.register('ox_police:setPlayerCuffs', function(source, target)
    local player = players[source]
    if not player then return end
    target = Player(target)?.state
    if not target then return end
    local state = not target.isCuffed
    target:set('isCuffed', state, true)
    return state
end)

RegisterNetEvent('ox_police:setPlayerEscort', function(target, state)
    local player = players[source]
    if not player then return end
    target = Player(target)?.state
    if not target then return end
    target:set('isEscorted', state and source, true)
end)
]]