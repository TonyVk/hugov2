ESX                             = nil

local StareKoord = nil
local Tim = nil
local UWaru = false
local Kill = 0
local Death = 0
local SpawnPoint = 0

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterCommand("warpokreni", function(source, args, rawCommandString)
	ESX.TriggerServerCallback('esx-races:DohvatiPermisiju', function(br)
		if br == 1 then
			local igrac = tonumber(args[1])
			local igrac2 = tonumber(args[2])
			local broj = args[3]
			local vrijeme  = args[4]
            if broj ~= nil and tonumber(broj) > 0 then
                if vrijeme ~= nil and tonumber(vrijeme) > 0 then
                    ESX.TriggerServerCallback('War:PokreniWar', function(br)
                        if br then
                            ESX.ShowNotification("Uspješno pokrenut war!")
                        end
                    end, igrac, igrac2, broj, vrijeme)
                else
                    name = "Admin"..":"
                    message = "/warpokreni [ID lidera 1][ID lidera 2][Broj u waru(3 za 3v3, 5 za 5v5...)][Vrijeme]"
                    TriggerEvent('chat:addMessage', { args = { name, message }, color = r,g,b })
                end
            else
                name = "Admin"..":"
                message = "/warpokreni [ID lidera 1][ID lidera 2][Broj u waru(3 za 3v3, 5 za 5v5...)][Vrijeme]"
                TriggerEvent('chat:addMessage', { args = { name, message }, color = r,g,b })
            end
		else
			ESX.ShowNotification("Nemate pristup ovoj komandi!")
		end
	end)
end, false)

RegisterCommand("warzaustavi", function(source, args, rawCommandString)
	ESX.TriggerServerCallback('esx-races:DohvatiPermisiju', function(br)
		if br == 1 then
			TriggerServerEvent("war:Zaustavi")
		else
			ESX.ShowNotification("Nemate pristup ovoj komandi!")
		end
	end)
end, false)

RegisterCommand("warpozovi", function(source, args, rawCommandString)
	if UWaru then
        local igrac = tonumber(args[1])
        if igrac then
            TriggerServerEvent("War:PozoviIgraca", igrac)
        else
            name = "Admin"..":"
            message = "/warpozovi [ID clana mafije]"
            TriggerEvent('chat:addMessage', { args = { name, message }, color = r,g,b })
        end
    else
        ESX.ShowNotification("Niste u waru!")
	end
end, false)

RegisterCommand("warizbaci", function(source, args, rawCommandString)
	if UWaru then
        local igrac = tonumber(args[1])
        if igrac then
            local id = GetPlayerServerId(PlayerId())
            if id ~= igrac then
                TriggerServerEvent("War:IzbaciIgraca", igrac)
            else
                ESX.ShowNotification("Ne mozete izbaciti samog sebe!")
            end
        else
            name = "Admin"..":"
            message = "/warizbaci [ID clana mafije]"
            TriggerEvent('chat:addMessage', { args = { name, message }, color = r,g,b })
        end
    else
        ESX.ShowNotification("Niste u waru!")
	end
end, false)

local hWeap = false
RegisterCommand('+gtahudweap', function()
	if UWaru then
		hWeap = true
		Citizen.CreateThread(function()
			while hWeap do
				Citizen.Wait(0)
				ShowHudComponentThisFrame(19)
			end
		end)
	end
end, false)
RegisterCommand('-gtahudweap', function()
	hWeap = false
end, false)
RegisterKeyMapping('+gtahudweap', 'Optimizacija GTA huda (weap)', 'keyboard', 'TAB')

RegisterNetEvent("War:VratiKill")
AddEventHandler('War:VratiKill', function()
	if UWaru == true then
		Kill = Kill+1
        SendNUIMessage({
			ubio = true,
			kill = Kill
		})
	end
end)

RegisterNetEvent("War:SyncMinute")
AddEventHandler('War:SyncMinute', function(br)
	if UWaru == true then
        local str
        if br == 2 or br == 3 or br == 4 then
            str = br.." minute"
        else
            str = br.." minuta"
        end
        SendNUIMessage({
			vrijeme = true,
            minuta = str
		})
	end
end)

RegisterNetEvent("War:UnfreezeIgrace")
AddEventHandler('War:UnfreezeIgrace', function()
	if UWaru == true then
        FreezeEntityPosition(PlayerPedId(), false)
	end
end)

RegisterNetEvent("War:SyncScore")
AddEventHandler('War:SyncScore', function(tim1, tim2)
	if UWaru == true then
		local str1 = "Tim 1: "..tim1
		local str2 = "Tim 2: "..tim2
		SendNUIMessage({
			team1 = true,
			team2 = true,
			score1 = str1,
			score2 = str2,
		})
	end
end)

AddEventHandler('esx:onPlayerDeath', function(data)
	if UWaru == true then
		DoScreenFadeOut(1)
		SetEntityInvincible(PlayerPedId(), true)
		Death = Death+1
		SendNUIMessage({
			mrtav = true,
			death = Death
		})
		if data.killedByPlayer == true then
			TriggerServerEvent("War:PosaljiKill", data.killerServerId, GetPlayerServerId(PlayerId()))
		else
			if Tim == 1 then
                TriggerServerEvent("War:Samoubojstvo", Tim)
			elseif Tim == 2 then
                TriggerServerEvent("War:Samoubojstvo", Tim)
			end
		end
		local ped = PlayerPedId()
		Wait(2000)
        if UWaru then
            if Tim == 1 then
                if SpawnPoint == 1 then
                    SetEntityCoordsNoOffset(ped, -1057.9150390625, 4944.314453125, 209.8247680664, false, false, false, true)
                    NetworkResurrectLocalPlayer(-1057.9150390625, 4944.314453125, 209.8247680664, 129.49896240234, true, false)
                elseif SpawnPoint == 2 then
                    SetEntityCoordsNoOffset(ped, -1059.1833496094, 4947.5693359375, 210.82870483398, false, false, false, true)
                    NetworkResurrectLocalPlayer(-1059.1833496094, 4947.5693359375, 210.82870483398, 123.06597137452, true, false)
                elseif SpawnPoint == 3 then
                    SetEntityCoordsNoOffset(ped, -1055.2409667968, 4947.83984375, 210.5191040039, false, false, false, true)
                    NetworkResurrectLocalPlayer( -1055.2409667968, 4947.83984375, 210.5191040039, 128.36541748046, true, false)
                elseif SpawnPoint == 4 then
                    SetEntityCoordsNoOffset(ped, -1056.6395263672, 4950.921875, 210.21948242188, false, false, false, true)
                    NetworkResurrectLocalPlayer(-1056.6395263672, 4950.921875, 210.21948242188, 124.7791519165, true, false)
                elseif SpawnPoint >= 5 then
                    SetEntityCoordsNoOffset(ped, -1059.679321289, 4952.1337890625, 210.5486907959, false, false, false, true)
                    NetworkResurrectLocalPlayer(-1059.679321289, 4952.1337890625, 210.5486907959, 139.77880859375, true, false)
                end
                SetPlayerInvincible(ped, false)
                ClearPedBloodDamage(ped)
            elseif Tim == 2 then
                if SpawnPoint == 1 then
                    SetEntityCoordsNoOffset(ped, -1169.3131103516, 4898.5942382812, 216.0304107666, false, false, false, true)
                    NetworkResurrectLocalPlayer(-1169.3131103516, 4898.5942382812, 216.0304107666, 299.87637329102, true, false)
                elseif SpawnPoint == 2 then
                    SetEntityCoordsNoOffset(ped, -1171.5206298828, 4901.8862304688, 217.22869873046, false, false, false, true)
                    NetworkResurrectLocalPlayer(-1171.5206298828, 4901.8862304688, 217.22869873046, 300.95999145508, true, false)
                elseif SpawnPoint == 3 then
                    SetEntityCoordsNoOffset(ped, -1174.0954589844, 4900.0385742188, 216.12692260742, false, false, false, true)
                    NetworkResurrectLocalPlayer(-1174.0954589844, 4900.0385742188, 216.12692260742, 302.12118530274, true, false)
                elseif SpawnPoint == 4 then
                    SetEntityCoordsNoOffset(ped, -1171.8341064454, 4897.9067382812, 216.31495666504, false, false, false, true)
                    NetworkResurrectLocalPlayer(-1171.8341064454, 4897.9067382812, 216.31495666504, 303.04583740234, true, false)
                elseif SpawnPoint >= 5 then
                    SetEntityCoordsNoOffset(ped, -1168.3704833984, 4894.1899414062, 216.25135803222, false, false, false, true)
                    NetworkResurrectLocalPlayer(-1168.3704833984, 4894.1899414062, 216.25135803222, 333.31900024414, true, false)
                end
                SetPlayerInvincible(ped, false)
                ClearPedBloodDamage(ped)
            end
            SetEntityInvincible(PlayerPedId(), false)
            DoScreenFadeIn(1)
            GiveWeaponToPed(ped, "WEAPON_PUMPSHOTGUN", 500, false, false)
            GiveWeaponToPed(ped, "WEAPON_ASSAULTRIFLE", 500, false, false)
            GiveWeaponToPed(ped, "WEAPON_MICROSMG", 500, false, false)
            GiveWeaponToPed(ped, "WEAPON_PISTOL", 500, false, false)
            TriggerEvent('esx_basicneeds:healPlayer')
        end
	end
end)

RegisterNetEvent('war:Pozovi')
AddEventHandler('war:Pozovi', function(tim, br, poceo)
    if not UWaru then
        if tim == 1 then
            ESX.TriggerServerCallback('War:DohvatiSpawn', function(br)
                if br ~= false then
                    StareKoord = GetEntityCoords(PlayerPedId())
                    if not poceo then
                        FreezeEntityPosition(PlayerPedId(), true)
                        Citizen.CreateThread(function()
                            while IsEntityPositionFrozen(PlayerPedId()) do
                                DisablePlayerFiring(PlayerId(),true)
                                Citizen.Wait(1)
                            end
                        end)
                        ESX.ShowNotification("War ce poceti kroz minutu!")
                    end
                    SpawnPoint = br
                    if br == 1 then
                        SetEntityCoords(GetPlayerPed(-1), -1057.9150390625, 4944.314453125, 209.8247680664, 1, 0, 0, 1)
                        SetEntityHeading(GetPlayerPed(-1), 129.49896240234)
                    elseif br == 2 then
                        SetEntityCoords(GetPlayerPed(-1), -1059.1833496094, 4947.5693359375, 210.82870483398, 1, 0, 0, 1)
                        SetEntityHeading(GetPlayerPed(-1), 123.06597137452)
                    elseif br == 3 then
                        SetEntityCoords(GetPlayerPed(-1), -1055.2409667968, 4947.83984375, 210.5191040039, 1, 0, 0, 1)
                        SetEntityHeading(GetPlayerPed(-1), 128.36541748046)
                    elseif br == 4 then
                        SetEntityCoords(GetPlayerPed(-1), -1056.6395263672, 4950.921875, 210.21948242188, 1, 0, 0, 1)
                        SetEntityHeading(GetPlayerPed(-1), 124.7791519165)
                    elseif br >= 5 then
                        SetEntityCoords(GetPlayerPed(-1), -1059.679321289, 4952.1337890625, 210.5486907959, 1, 0, 0, 1)
                        SetEntityHeading(GetPlayerPed(-1), 139.77880859375)
                    end
                    UWaru = true
                    local clothesSkin = {
                        ['tshirt_1'] = 0, ['tshirt_2'] = 0,
                        ['torso_1'] = 7, ['torso_2'] = 5
                    }
                    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                        TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
                    end)
                    Tim = tim
                    TriggerEvent("esx:spremajLoadout", false)
                    RemoveAllPedWeapons(PlayerPedId())
                    TriggerEvent("esx_ambulancejob:PostaviGa", true)
                    TriggerEvent("pullout:PostaviGa", true)
                    TriggerEvent("esx_ambulancejob:PostaviGa", true)
                    TriggerEvent("pullout:PostaviGa", true)
                    TriggerEvent("Muvaj:PostaviGa", true)
                    TriggerEvent("esx:ZabraniInv", true)
                    TriggerEvent('inventory:PostaviGa', true)
                    TriggerEvent('zone:ObrisiNPCove', true)
                    TriggerEvent('mafije:ZabraniF6', true)
                    GiveWeaponToPed(PlayerPedId(), "WEAPON_PUMPSHOTGUN", 500, false, false)
                    GiveWeaponToPed(PlayerPedId(), "WEAPON_ASSAULTRIFLE", 500, false, false)
                    GiveWeaponToPed(PlayerPedId(), "WEAPON_MICROSMG", 500, false, false)
                    GiveWeaponToPed(PlayerPedId(), "WEAPON_PISTOL", 500, false, false)
                    Kill = 0
                    Death = 0
                    local str = "5 minuta"
                    local str1 = "Tim 1: 0"
                    local str2 = "Tim 2: 0"
                    SendNUIMessage({
                        vrijeme = true,
                        minuta = str,
                        prikaziscore = true,
                        team1 = true,
                        team2 = true,
                        score1 = str1,
                        score2 = str2,
                        ubio = true,
                        kill = Kill,
                        mrtav = true,
                        death = Death
                    })
                end
            end, tim)
        elseif tim == 2 then
            ESX.TriggerServerCallback('War:DohvatiSpawn', function(br)
                if br ~= false then
                    StareKoord = GetEntityCoords(PlayerPedId())
                    if not poceo then
                        FreezeEntityPosition(PlayerPedId(), true)
                        Citizen.CreateThread(function()
                            while IsEntityPositionFrozen(PlayerPedId()) do
                                DisablePlayerFiring(PlayerId(),true)
                                Citizen.Wait(1)
                            end
                        end)
                        ESX.ShowNotification("War ce poceti kroz minutu!")
                    end
                    SpawnPoint = br
                    if br == 1 then
                        SetEntityCoords(GetPlayerPed(-1), -1169.3131103516, 4898.5942382812, 216.0304107666, 1, 0, 0, 1)
                        SetEntityHeading(GetPlayerPed(-1), 299.87637329102)
                    elseif br == 2 then
                        SetEntityCoords(GetPlayerPed(-1), -1171.5206298828, 4901.8862304688, 217.22869873046, 1, 0, 0, 1)
                        SetEntityHeading(GetPlayerPed(-1), 300.95999145508)
                    elseif br == 3 then
                        SetEntityCoords(GetPlayerPed(-1), -1174.0954589844, 4900.0385742188, 216.12692260742, 1, 0, 0, 1)
                        SetEntityHeading(GetPlayerPed(-1), 302.12118530274)
                    elseif br == 4 then
                        SetEntityCoords(GetPlayerPed(-1), -1171.8341064454, 4897.9067382812, 216.31495666504, 1, 0, 0, 1)
                        SetEntityHeading(GetPlayerPed(-1), 303.04583740234)
                    elseif br >= 5 then
                        SetEntityCoords(GetPlayerPed(-1), -1168.3704833984, 4894.1899414062, 216.25135803222, 1, 0, 0, 1)
                        SetEntityHeading(GetPlayerPed(-1), 333.31900024414)
                    end
                    UWaru = true
                    local clothesSkin = {
                        ['tshirt_1'] = 0, ['tshirt_2'] = 0,
                        ['torso_1'] = 7, ['torso_2'] = 3
                    }
                    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                        TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
                    end)
                    Tim = tim
                    TriggerEvent("esx:spremajLoadout", false)
                    RemoveAllPedWeapons(PlayerPedId())
                    TriggerEvent("esx_ambulancejob:PostaviGa", true)
                    TriggerEvent("pullout:PostaviGa", true)
                    TriggerEvent("esx_ambulancejob:PostaviGa", true)
                    TriggerEvent("pullout:PostaviGa", true)
                    TriggerEvent("Muvaj:PostaviGa", true)
                    TriggerEvent("esx:ZabraniInv", true)
                    TriggerEvent('inventory:PostaviGa', true)
                    TriggerEvent('zone:ObrisiNPCove', true)
                    TriggerEvent('mafije:ZabraniF6', true)
                    GiveWeaponToPed(PlayerPedId(), "WEAPON_PUMPSHOTGUN", 500, false, false)
                    GiveWeaponToPed(PlayerPedId(), "WEAPON_ASSAULTRIFLE", 500, false, false)
                    GiveWeaponToPed(PlayerPedId(), "WEAPON_MICROSMG", 500, false, false)
                    GiveWeaponToPed(PlayerPedId(), "WEAPON_PISTOL", 500, false, false)
                    Kill = 0
                    Death = 0
                    local str = "5 minuta"
                    local str1 = "Tim 1: 0"
                    local str2 = "Tim 2: 0"
                    SendNUIMessage({
                        vrijeme = true,
                        minuta = str,
                        prikaziscore = true,
                        team1 = true,
                        team2 = true,
                        score1 = str1,
                        score2 = str2,
                        ubio = true,
                        kill = Kill,
                        mrtav = true,
                        death = Death
                    })
                end
            end, tim)
        end
    else
        ESX.ShowNotification("Vec jeste u waru!")
    end
end)

RegisterNetEvent('war:Zavrsi')
AddEventHandler('war:Zavrsi', function(br)
    UWaru = false
    FreezeEntityPosition(PlayerPedId(), false)
    SendNUIMessage({
        zatvoriscore = true
    })
    SetEntityCoords(PlayerPedId(), StareKoord)
    TriggerEvent('zone:ObrisiNPCove', false)
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
        TriggerEvent('skinchanger:loadSkin', skin)
    end)
    Tim = nil
    TriggerEvent("esx_ambulancejob:PostaviGa", false)
    TriggerEvent("pullout:PostaviGa", false)
    TriggerEvent("esx_ambulancejob:PostaviGa", false)
    TriggerEvent("pullout:PostaviGa", false)
    TriggerEvent("Muvaj:PostaviGa", false)
    TriggerEvent("esx:ZabraniInv", false)
    TriggerEvent('inventory:PostaviGa', false)
    TriggerEvent('mafije:ZabraniF6', false)
    TriggerEvent('esx:restoreLoadout')
    if not br then
        ESX.ShowNotification("Izbaceni ste iz wara!")
    end
    if IsEntityDead(PlayerPedId()) then
        SetPlayerInvincible(ped, false)
        ClearPedBloodDamage(ped)
        SetEntityInvincible(PlayerPedId(), false)
        SetEntityCoordsNoOffset(PlayerPedId(), StareKoord, false, false, false, true)
		NetworkResurrectLocalPlayer(StareKoord, 0.0, true, false)
        DoScreenFadeIn(1)
    end
    RemoveAllPedWeapons(PlayerPedId())
    TriggerEvent("esx:spremajLoadout", true)
    TriggerEvent('esx:restoreLoadout')
end)

RegisterNetEvent("War:VratiPoruku")
AddEventHandler('War:VratiPoruku', function(str)
	if UWaru == true then
		ESX.ShowNotification(str, 7000)
	end
end)