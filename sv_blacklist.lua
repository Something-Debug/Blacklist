local webhook = ''
function log(message)
    local serverName = GetConvar('sv_hostname', '')
    local embed = {
      {
        ['title'] = 'Blacklist on '..serverName,
        ['type'] = 'rich',
        ['description'] = message,
        ['color'] = 732633,
        ['footer'] = {['text'] = os.date("%x (%X %p)")}
      }
    }
    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })
end

local _blacklistedmodels = {
    [`adder`] = true,
    [`cargoplane`] = true
}
AddEventHandler('entityCreating', function(entity)
    local entityOwner = NetworkGetEntityOwner(entity)
    if not IsPlayerAceAllowed(entityOwner, 'Blacklist') then
        if _blacklistedmodels[GetEntityModel(entity)] then
            CancelEvent()
            TriggerClientEvent('notify', entityOwner, 'Blacklisted Vehicle') 
        end
    end
end)

local _blacklistedPeds = {
    'a_m_m_acult_01',
    'a_m_y_acult_01'
}

local _blacklistedWeapons = {
    'WEAPON_RPG',
    'WEAPON_SMG'
}

local _blacklistedVehicles = {
    'adder',
    'cargoplane'
}
CreateThread(function()
    while true do
        Wait(1000)
        if GetNumPlayerIndices() > 0 then
            local player = GetPlayerFromIndex(0)
            local playerPed = GetPlayerPed(player)
            local coords = GetEntityCoords(playerPed)
            local name = GetPlayerName(player)
            if not IsPlayerAceAllowed(player, 'Blacklist') then
                for _, pedNames in pairs(_blacklistedPeds) do
                    if GetEntityModel(playerPed) == GetHashKey(pedNames) then
                        TriggerClientEvent('setPed', player)
                        log('**Player:** `' ..name..'`\n**Information:** Tried to set themselves as a blacklisted ped `' ..pedNames..'`\n**Coords:** `' ..coords..'`')
                    end
                end
                for _, wepNames in pairs(_blacklistedWeapons) do
                    if GetSelectedPedWeapon(playerPed) == GetHashKey(wepNames) then
                        RemoveWeaponFromPed(playerPed, wepNames)
                        log('**Player:** `' ..name..'`\n **Information:** Tried to use a blacklisted weapon `' ..wepNames..'`\n**Coords:** `' ..coords..'`')
                        TriggerClientEvent('notify', player, 'Blacklisted Weapon')
                    end
                end
                for _, vehNames in pairs(_blacklistedVehicles) do
                    local vehicle = GetVehiclePedIsIn(playerPed, false)
                    if GetEntityModel(vehicle) == GetHashKey(vehNames) then
                        DeleteEntity(vehicle)
                        log('**Player:** `' ..name..'`\n **Information:** Tried to spawn a blacklisted vehicle `' ..vehNames.. '`\n**Coords:** `' ..coords..'`')
                        TriggerClientEvent('notify', player, 'Blacklisted Vehicle')    
                    end
                end
            end
        end
    end
end)
