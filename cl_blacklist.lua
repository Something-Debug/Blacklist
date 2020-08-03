function notification(message)
	BeginTextCommandThefeedPost("STRING")
	AddTextComponentSubstringPlayerName(message)
	EndTextCommandThefeedPostTicker(true, false)
end

RegisterNetEvent('notify')
AddEventHandler('notify', function(message)
    notification(message)
end)

RegisterNetEvent('setPed')
AddEventHandler('setPed', function()
    local defaultPed = 'a_m_y_skater_01'
    RequestModel(defaultPed)
    while not HasModelLoaded(defaultPed) do
        Wait(500)
    end
    SetPlayerModel(PlayerId(), defaultPed)
    SetModelAsNoLongerNeeded(defaultPed)
    notification('Blacklisted Ped')
end)
