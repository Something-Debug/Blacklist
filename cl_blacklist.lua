local _blacklistedweapons = {
    'WEAPON_RPG',
    'WEAPON_PROXYMINE'
}

local _blacklistedpeds = {
    'a_m_m_acult_01',
    'a_m_y_acult_01'
}

local defaultPed = 'a_m_y_skater_01'

CreateThread(function()
    while true do
        Wait(1000) --Mandatory wait can be increased for better perfromace, but is not recommended. 
        if not isAdmin then --Check if the player is staff
            for k, wepNames in ipairs(_blacklistedweapons) do --Loop through all weapon hashes
                if HasPedGotWeapon(PlayerPedId(), wepNames, false) then --Check if the player has a blacklisted weapon.
                    RemoveWeaponFromPed(PlayerPedId(), wepNames) --Remove the blacklisted Weapon
                    notification('Blacklisted Weapon Model')
                end
            end
        end
        if not isAdmin then --Check if the player is staff
            for k, pedNames in ipairs(_blacklistedpeds) do --Loop through all ped hashes
                if GetEntityModel(PlayerPedId()) == GetHashKey(pedNames) then --Check if the player is a blacklisted ped.
                    RequestModel(defaultPed) --Load a_m_y_skater_01 into memory
                    while not HasModelLoaded(defaultPed) do
                        Wait(500)
                    end
                    SetPlayerModel(PlayerId(), defaultPed) --Set the player model to a_m_y_skater_01
                    SetModelAsNoLongerNeeded(defaultPed)
                    notification('Blacklisted Ped Model')
                end
            end
        end
    end
end)

RegisterNetEvent('checkAce')
AddEventHandler('checkAce', function(state)
    isAdmin = state
end)

function notification(message)
	BeginTextCommandThefeedPost("STRING")
	AddTextComponentSubstringPlayerName(message)
	EndTextCommandThefeedPostTicker(true, false)
end

RegisterNetEvent('notify')
AddEventHandler('notify', function(message)
    notification(message)
end)
