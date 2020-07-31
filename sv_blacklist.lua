local _blacklistedmodels = {
    [`cargoplane`] = 'cargoplane'
}
local _blacklistedNaturalSpawn = {
    [`police3`] = 'police3'
}
AddEventHandler('entityCreating', function(entity)
    local entityOwner = NetworkGetEntityOwner(entity)
    if not IsPlayerAceAllowed(entityOwner, 'command') then --Check permissions
        if _blacklistedmodels[GetEntityModel(entity)] then --Is the vehicle being spawned blacklisted
            TriggerClientEvent('notify', entityOwner, 'Blacklisted Vehicle Model') --Let the client know the vehicle is blacklisted
            CancelEvent() --Cancel the creating of the vehicle
        end
        if _blacklistedNaturalSpawn[GetEntityModel(entity)] then --Is the vehicle being spawned blacklisted
            CancelEvent() --Cancel the creating of the vehicle
        end
    end
end)

--All code below was taken from https://github.com/Zeemahh/no-god-mode just changed the event name. Thanks Zeemahh
function ProcessAces()
    if GetNumPlayerIndices() > 0 then -- don't do it when there aren't any players
        for i=0, GetNumPlayerIndices()-1 do -- loop through all players
            player = tonumber(GetPlayerFromIndex(i))
            Citizen.Wait(0)
            if IsPlayerAceAllowed(player, 'Blacklist') then
                TriggerClientEvent("checkAce", player, true)
            end
        end
    end
end

CreateThread(function()
    while true do
        ProcessAces()
        Wait(60000) --Check every minute
    end
end)

AddEventHandler("onResourceStart", function(name)
    if name == GetCurrentResourceName() then
        ProcessAces()
    end
end)
