local _blacklistedweapons = {
    0xB1CA77B1, --WEAPON_RPG
    0xAB564B93, --WEAPON_PROXYMINE
    0xDBBD7280, --WEAPON_COMBATMG_MK2
    0xA284510B, --WEAPON_GRENADELAUNCHER
    0x4DD2DC56, --WEAPON_GRENADELAUNCHER_SMOKE
    0x42BF8A85, --WEAPON_MINIGUN
    0x6D544C99, --WEAPON_RAILGUN
    0x63AB0442, --WEAPON_HOMINGLAUNCHER
    0x2C3731D9, --WEAPON_STICKYBOMB
    0x0781FE4A, --WEAPON_COMPACTLAUNCHER
    0x6A6C02E0, --WEAPON_MARKSMANRIFLE_MK2
    0x555AF99A, --WEAPON_PUMPSHOTGUN_MK2
    0xA914799, --WEAPON_HEAVYSNIPER_MK2
    0x969C3D67, --WEAPON_SPECIALCARBINE_MK2
    0x84D6FAFD, --WEAPON_BULLPUPRIFLE_MK2
    0xBA45E8B8, --WEAPON_PIPEBOMB
    0xFAD1F1C9, --WEAPON_CARBINERIFLE_MK2
    0x78A97CD0, --WEAPON_SMG_MK2
    0x9D07F764, --WEAPON_MG
    0xAF3696A1, --WEAPON_RAYPISTOL
    0x476BF155, --WEAPON_RAYCARBINE
    0xB62D1F67 --WEAPON_RAYMINIGUN

}

local _blacklistedpeds = {
    1413662315, --a_m_m_acult_01
    0xB564882B, --a_m_y_acult_01
    0x55446010, --a_m_o_acult_01
    0x80E59F2E, --a_m_y_acult_02
    0x7DC3908F, --u_m_y_justin
    0x9CF26183, --a_f_y_topless_01
    0x52580019, --s_f_y_stripper_01
    0x6E0FB794, --s_f_y_stripper_02
    0x5C14EDFA --s_f_y_stripperlite
}
CreateThread(function()
    while true do
        Wait(1000) --Mandatory wait can be increased for better perfromace, but is not recommended. 
        if not isAdmin then --Check if the player is staff
            for k, wepHashes in ipairs(_blacklistedweapons) do --Loop through all weapon hashes
                if HasPedGotWeapon(PlayerPedId(), wepHashes, false) then --Check if the player has a blacklisted weapon.
                    RemoveWeaponFromPed(PlayerPedId(), wepHashes) --Remove the blacklisted Weapon
                    notification('Blacklisted Weapon Model')
                end
            end
        end
        if not isAdmin then --Check if the player is staff
            for k, pedHashes in ipairs(_blacklistedpeds) do --Loop through all ped hashes
                if GetEntityModel(PlayerPedId()) == pedHashes then --Check if the player is a blacklisted ped.
                    RequestModel(-1044093321) --Load a_m_y_skater_01 into memory
                    Wait(1000)
                    SetPlayerModel(PlayerId(), -1044093321) --Set the player model to a_m_y_skater_01
                    SetModelAsNoLongerNeeded(-1044093321)
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