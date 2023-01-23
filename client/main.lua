
local table = lib.table
InService = player?.inService and table.contains(Config.JobGroups, player.inService) and player.hasGroup(Config.JobGroups)


-- <! Methods grabbed from Overextended's ox_police for reference
-- <! because it was the only ox based job on github
-- <! Ref: https://github.com/overextended/ox_police/blob/main/server/main.lua

-- Method for player to trigger command action through chat
RegisterCommand('duty', function()
    InService = not InService and player.hasGroup(Config.JobGroups) or false
    TriggerServerEvent('ox:setPlayerInService', InService)
end)


-- Method for player log out
-- Change the states to false if player can leave while in state
AddEventHandler('ox:playerLogout', function()
    InService = false
    --LocalPlayer.state:set('isCuffed', false, true)
    --LocalPlayer.state:set('isEscorted', false, true)
end)