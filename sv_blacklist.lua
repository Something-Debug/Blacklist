local _blacklistedmodels = {
    [`cargoplane`] = 'cargoplane'
}
local _blacklistedNaturalSpawn = {
    [`police3`] = 'police3'
}
AddEventHandler('entityCreating', function(entity)
    local _source = source
    if not IsPlayerAceAllowed(_source, 'command') then --Check permissions
        if _blacklistedmodels[GetEntityModel(entity)] then --Is the vehicle being spawned blacklisted
            TriggerClientEvent('notify', -1, 'Blacklisted Vehicle Model') --Let the client know the vehicle is blacklisted
            CancelEvent() --Prevent the vehicle from being spawned
        end
        if _blacklistedNaturalSpawn[GetEntityModel(entity)] then --Is the vehicle being spawned blacklisted
            CancelEvent() --Prevent the vehicle from being spawne
        end
    end
end)

--All code below was taken from https://github.com/Zeemahh/no-god-mode just changed the event name. Thanks Zeemahh
function ProcessAces()
    if GetNumPlayerIndices() > 0 then -- don't do it when there aren't any players
        for i=0, GetNumPlayerIndices()-1 do -- loop through all players
            player = tonumber(GetPlayerFromIndex(i))
            Citizen.Wait(0)
            if IsPlayerAceAllowed(player, 'command') then
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