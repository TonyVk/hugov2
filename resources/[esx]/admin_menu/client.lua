local group = "user"
local states = {}
states.frozen = false
states.frozenPos = nil
local noclipEntity = nil
local noclipSpeed = 2.0
local noclip = false
local nevidljivost = false
local duznost = false
local staffTable = { 0 }
local TagDistance = 25
local viewname = false

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	ESX.TriggerServerCallback('tagovi:DajStaff', function(br)
		staffTable = br
	end)
end)

--Tagovi
RegisterNetEvent('sendStaff')
AddEventHandler('sendStaff', function(_staffTable)
	staffTable = _staffTable
end)

function ManageHeadLabels()
	for _,player in ipairs(GetActivePlayers()) do
		if NetworkIsPlayerActive(player) then
			local iPed = GetPlayerPed(player)
			local lPed = PlayerPedId()
			if iPed ~= lPed then
				if DoesEntityExist(iPed) then
					distance = math.ceil(GetDistanceBetweenCoords(GetEntityCoords(lPed), GetEntityCoords(iPed)))
					if HasEntityClearLosToEntity(lPed, iPed, 17) then
						if distance < TagDistance then
							local imeIgr = ""
							if viewname then
								local ida = GetPlayerServerId(player)
								imeIgr = GetPlayerName(player).." ("..ida..")"
							end
							headDisplayId = N_0xbfefe3321a3f5015(iPed, imeIgr, false, false, "", false)
							if NetworkIsPlayerTalking(player) then
								if has_value(staffTable,GetPlayerServerId(player)) then 
									SetMpGamerTagBigText(headDisplayId, "Admin")
									SetMpGamerTagVisibility(headDisplayId, 3, true)
									SetMpGamerTagAlpha(headDisplayId, 4, 225)							
									etMpGamerTagVisibility(headDisplayId, 4, true)
									SetMpGamerTagColour(headDisplayId, 3, 6)
								else
									SetMpGamerTagVisibility(headDisplayId, 3, false)
									SetMpGamerTagAlpha(headDisplayId, 4, 225)							
									SetMpGamerTagVisibility(headDisplayId, 4, true)
								end
							else
								if has_value(staffTable,GetPlayerServerId(player)) then 
									SetMpGamerTagBigText(headDisplayId, "Admin")
									SetMpGamerTagVisibility(headDisplayId, 3, true)
									SetMpGamerTagColour(headDisplayId, 3, 6)
								else
									SetMpGamerTagVisibility(headDisplayId, 3, false)
								end
								SetMpGamerTagVisibility(headDisplayId, 4, false)
							end
						else
							SetMpGamerTagVisibility(headDisplayId, 3, false)
							SetMpGamerTagVisibility(headDisplayId, 4, false)
						end
					else
						SetMpGamerTagVisibility(headDisplayId, 3, false)
						SetMpGamerTagVisibility(headDisplayId, 4, false)
					end
				end
			end
		end
	end
end

function has_value (tab, val)
    for i, v in ipairs (tab) do
        if (v == val) then
            return true
        end
    end
    return false
end


Citizen.CreateThread(function()
	while true do
		ManageHeadLabels()
		Citizen.Wait(500)
	end
end)

-- Citizen.CreateThread(function()
-- 	while true do
-- 		Citizen.Wait(0)
		
-- 		if (IsControlJustPressed(1, 212) and IsControlJustPressed(1, 213)) then
-- 			ESX.TriggerServerCallback('esx-races:DohvatiPermisiju', function(br)
-- 				if br == 1 then
-- 					SetNuiFocus(true, true)
-- 					getPlayers(true)
-- 				end
-- 			end)
-- 		end
-- 	end
-- end)

RegisterCommand('viewname', function(source, args, rawCommand)
    if duznost then
		if not viewname then
			viewname = true
			ESX.ShowNotification("Upalili ste viewname!")
		else
			viewname = false
			ESX.ShowNotification("Ugasili ste viewname!")
		end
	else
		ESX.ShowNotification("Niste na admin duznosti!")
	end
end, false)

RegisterCommand('kick', function(source, args, rawCommand)
    if duznost then
		if args[1] then
			if tonumber(args[1]) then
				local player = tonumber(args[1])
				local reason = args
				table.remove(reason, 1)
				if(#reason == 0)then
					reason = "Kickan: Izbaceni ste sa servera"
				else
					reason = "Kickan: " .. table.concat(reason, " ")
				end
				TriggerServerEvent("amenu:Kick", player, reason)
			else
				TriggerEvent('chat:addMessage', { args = {"^1SYSTEM", "Krivi ID igraca"}})
			end
		else
			TriggerEvent('chat:addMessage', { args = {"^1SYSTEM", "Krivi ID igraca"}})
		end
	else
		ESX.ShowNotification("Niste na admin duznosti!")
	end
end, false)

RegisterCommand('announce', function(source, args, rawCommand)
    if duznost then
		if args[1] ~= nil then
			TriggerServerEvent("amenu:Announce", args)
			local komando = "/announce "..table.concat(args, " ")
			TriggerServerEvent("DiscordBot:RegCmd", GetPlayerServerId(PlayerId()), komando)
		else
			TriggerEvent('chat:addMessage', { args = {"^1SYSTEM", " /announce [Poruka]"} })
		end
	else
		ESX.ShowNotification("Niste na admin duznosti!")
	end
end, false)

RegisterCommand('freeze', function(source, args, rawCommand)
    if duznost then
		if args[1] then
			if tonumber(args[1]) then
				local player = tonumber(args[1])
				TriggerServerEvent("amenu:Freeze", player)
			else
				TriggerEvent('chat:addMessage', { args = {"^1SYSTEM", "Krivi ID igraca"}})
			end
		else
			TriggerEvent('chat:addMessage', { args = {"^1SYSTEM", "Krivi ID igraca"}})
		end
	else
		ESX.ShowNotification("Niste na admin duznosti!")
	end
end, false)

RegisterCommand('bring', function(source, args, rawCommand)
    if duznost then
		if args[1] then
			if tonumber(args[1]) then
				local player = tonumber(args[1])
				TriggerServerEvent("amenu:Bring", player)
			else
				TriggerEvent('chat:addMessage', { args = {"^1SYSTEM", "Krivi ID igraca"}})
			end
		else
			TriggerEvent('chat:addMessage', { args = {"^1SYSTEM", "Krivi ID igraca"}})
		end
	else
		ESX.ShowNotification("Niste na admin duznosti!")
	end
end, false)

RegisterCommand('slap', function(source, args, rawCommand)
    if duznost then
		if args[1] then
			if tonumber(args[1]) then
				local player = tonumber(args[1])
				TriggerServerEvent("amenu:Slap", player)
			else
				TriggerEvent('chat:addMessage', { args = {"^1SYSTEM", "Krivi ID igraca"}})
			end
		else
			TriggerEvent('chat:addMessage', { args = {"^1SYSTEM", "Krivi ID igraca"}})
		end
	else
		ESX.ShowNotification("Niste na admin duznosti!")
	end
end, false)

RegisterCommand('goto', function(source, args, rawCommand)
    if duznost then
		if args[1] then
			if tonumber(args[1]) then
				local player = tonumber(args[1])
				TriggerServerEvent("amenu:Goto", player)
			else
				TriggerEvent('chat:addMessage', { args = {"^1SYSTEM", "Krivi ID igraca"}})
			end
		else
			TriggerEvent('chat:addMessage', { args = {"^1SYSTEM", "Krivi ID igraca"}})
		end
	else
		ESX.ShowNotification("Niste na admin duznosti!")
	end
end, false)

RegisterCommand('slay', function(source, args, rawCommand)
    if duznost then
		if args[1] then
			if tonumber(args[1]) then
				local player = tonumber(args[1])
				TriggerServerEvent("amenu:Slay", player)
			else
				TriggerEvent('chat:addMessage', { args = {"^1SYSTEM", "Krivi ID igraca"}})
			end
		else
			TriggerEvent('chat:addMessage', { args = {"^1SYSTEM", "Krivi ID igraca"}})
		end
	else
		ESX.ShowNotification("Niste na admin duznosti!")
	end
end, false)

RegisterCommand('crash', function(source, args, rawCommand)
    if duznost then
		if args[1] then
			if tonumber(args[1]) then
				local player = tonumber(args[1])
				TriggerServerEvent("amenu:Crash", player)
			else
				TriggerEvent('chat:addMessage', { args = {"^1SYSTEM", "Krivi ID igraca"}})
			end
		else
			TriggerEvent('chat:addMessage', { args = {"^1SYSTEM", "Krivi ID igraca"}})
		end
	else
		ESX.ShowNotification("Niste na admin duznosti!")
	end
end, false)

RegisterCommand('setadmin', function(source, args, rawCommand)
    if duznost then
		local player = tonumber(args[1])
		local level = tonumber(args[2])
		if args[1] then
			if player then
				if level then
					TriggerServerEvent("amenu:SetAdmin", player, level)
				else
					ESX.ShowNotification("Krivi broj!")
				end
			else
				ESX.ShowNotification("Igrac nije u igri!")
			end
		else
			ESX.ShowNotification("Koristi: setadmin [user-id] [permission-level]")
		end
	else
		ESX.ShowNotification("Niste na admin duznosti!")
	end
end, false)

RegisterCommand('setgroup', function(source, args, rawCommand)
    if duznost then
		local player = tonumber(args[1])
		local group = args[2]
		if args[1] then
			if player then
				TriggerServerEvent("amenu:SetGroup", player, group)
			else
				ESX.ShowNotification("Igrac nije u igri")
			end
		else
			ESX.ShowNotification("Koristi: setgroup [user-id] [group]")
		end
	else
		ESX.ShowNotification("Niste na admin duznosti!")
	end
end, false)

RegisterCommand('setmoney', function(source, args, rawCommand)
    if duznost then
		local target = tonumber(args[1])
		local money_type = args[2]
		local money_amount = tonumber(args[3])
		TriggerServerEvent("amenu:SetMoney", target, money_type, money_amount)
	else
		ESX.ShowNotification("Niste na admin duznosti!")
	end
end, false)

RegisterCommand('giveaccountmoney', function(source, args, rawCommand)
    if duznost then
		local player = tonumber(args[1])
		local account = args[2]
		local amount  = tonumber(args[3])
		TriggerServerEvent("amenu:AccountMoney", player, account, amount)
	else
		ESX.ShowNotification("Niste na admin duznosti!")
	end
end, false)

--esx_marker
RegisterCommand("tpm", function(source)
	if duznost then
		TeleportToWaypoint()
		TriggerServerEvent("DiscordBot:RegCmd", GetPlayerServerId(PlayerId()), "/tpm")
	else
		ESX.ShowNotification("Niste na admin duznosti!")
	end
end)
--esx_marker
TeleportToWaypoint = function()
    ESX.TriggerServerCallback("esx_marker:fetchUserRank", function(playerRank)
        if playerRank == "admin" or playerRank == "superadmin" or playerRank == "mod" then
            local WaypointHandle = GetFirstBlipInfoId(8)

            if DoesBlipExist(WaypointHandle) then
                local waypointCoords = GetBlipInfoIdCoord(WaypointHandle)

                for height = 1, 1000 do
                    SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)

                    local foundGround, zPos = GetGroundZFor_3dCoord(waypointCoords["x"], waypointCoords["y"], height + 0.0)

                    if foundGround then
                        SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)

                        break
                    end

                    Citizen.Wait(5)
                end

                ESX.ShowNotification("Teleportiran.")
            else
                ESX.ShowNotification("Stavite vas marker prvo.")
            end
        else
            ESX.ShowNotification("Nemate ovlasti za ovu komandu.")
        end
    end)
end	

RegisterCommand('+adminmenu2', function()
    ESX.TriggerServerCallback('esx-races:DohvatiPermisiju', function(br)
		if br == 1 then
			SetNuiFocus(true, true)
			SendNUIMessage({type = 'openQuick'})
		end
	end)
end, false)
RegisterKeyMapping('+adminmenu2', 'Otvori quick admin menu', 'keyboard', 'F2')

RegisterCommand('+adminmenu', function()
    ESX.TriggerServerCallback('esx-races:DohvatiPermisiju', function(br)
		if br == 1 then
			if duznost then
				SetNuiFocus(true, true)
				getPlayers(true)
			else
				ESX.ShowNotification("Niste na admin duznosti!")
			end
		end
	end)
end, false)
RegisterKeyMapping('+adminmenu', 'Otvori admin menu', 'keyboard', 'HOME')

RegisterNetEvent('es_admin:setGroup')
AddEventHandler('es_admin:setGroup', function(g)
	group = g
end)

RegisterNetEvent('duznost:Saljem')
AddEventHandler('duznost:Saljem', function(br)
	duznost = br
end)

RegisterNUICallback('close', function(data, cb)
	SetNuiFocus(false)
end)

RegisterNetEvent('amenu:PrikaziObavijest')
AddEventHandler('amenu:PrikaziObavijest', function(args)
	SendNUIMessage({type = 'obavijest', tekst = args})
end)

RegisterNUICallback('ADuznost', function(data, cb)
	SetNuiFocus(false)
	SendNUIMessage({type = 'closeQuick'})
	ESX.TriggerServerCallback('esx-races:DohvatiPermisiju', function(br)
		if br == 1 then
			ExecuteCommand("aduty")
		end
	end)
end)

RegisterNUICallback('Nevidljiv', function(data, cb)
	if duznost then
		SetNuiFocus(false)
		SendNUIMessage({type = 'closeQuick'})
		ESX.TriggerServerCallback('esx-races:DohvatiPermisiju', function(br)
			if br == 1 then
				if nevidljivost == false then
					SetEntityVisible(PlayerPedId(), false)
					ESX.ShowNotification("Nevidjlivost je uključena!")
					nevidljivost = true
				else
					SetEntityVisible(PlayerPedId(), true)
					ESX.ShowNotification("Nevidjlivost je isključena!")
					nevidljivost = false
				end
			end
		end)
	else
		ESX.ShowNotification("Niste na admin duznosti!")
	end
end)

RegisterNUICallback('Vozilo', function(data, cb)
	if duznost then
		SetNuiFocus(false)
		SendNUIMessage({type = 'closeQuick'})
		ESX.TriggerServerCallback('esx-races:DohvatiPermisiju', function(br)
			if br == 1 then
				local koord = GetEntityCoords(PlayerPedId())
				local head = GetEntityHeading(PlayerPedId())
				ESX.Game.SpawnVehicle("sultanrs", koord, head, function(vehicle)
					TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
				end)
			end
		end)
	else
		ESX.ShowNotification("Niste na admin duznosti!")
	end
end)

RegisterNUICallback('Marker', function(data, cb)
	if duznost then
		SetNuiFocus(false)
		SendNUIMessage({type = 'closeQuick'})
		ESX.TriggerServerCallback('esx-races:DohvatiPermisiju', function(br)
			if br == 1 then
				ExecuteCommand("tpm")
			end
		end)
	else
		ESX.ShowNotification("Niste na admin duznosti!")
	end
end)

RegisterNUICallback('Heal', function(data, cb)
	if duznost then
		SetNuiFocus(false)
		SendNUIMessage({type = 'closeQuick'})
		ESX.TriggerServerCallback('esx-races:DohvatiPermisiju', function(br)
			if br == 1 then
				ExecuteCommand("heal")
			end
		end)
	else
		ESX.ShowNotification("Niste na admin duznosti!")
	end
end)

RegisterNUICallback('ObrisiVozilo', function(data, cb)
	if duznost then
		SetNuiFocus(false)
		SendNUIMessage({type = 'closeQuick'})
		ESX.TriggerServerCallback('esx-races:DohvatiPermisiju', function(br)
			if br == 1 then
				ExecuteCommand("dv")
			end
		end)
	else
		ESX.ShowNotification("Niste na admin duznosti!")
	end
end)

RegisterNUICallback('PopraviVozilo', function(data, cb)
	if duznost then
		SetNuiFocus(false)
		SendNUIMessage({type = 'closeQuick'})
		ESX.TriggerServerCallback('esx-races:DohvatiPermisiju', function(br)
			if br == 1 then
				ExecuteCommand("fix")
			end
		end)
	else
		ESX.ShowNotification("Niste na admin duznosti!")
	end
end)

RegisterNUICallback('Ubij', function(data, cb)
	if duznost then
		SetNuiFocus(false)
		SendNUIMessage({type = 'closeQuick'})
		ESX.TriggerServerCallback('esx-races:DohvatiPermisiju', function(br)
			if br == 1 then
				SetEntityHealth(PlayerPedId(), 0)
			end
		end)
	else
		ESX.ShowNotification("Niste na admin duznosti!")
	end
end)

RegisterNUICallback('NoClip', function(data, cb)
	if duznost then
		SetNuiFocus(false)
		SendNUIMessage({type = 'closeQuick'})
		ESX.TriggerServerCallback('esx-races:DohvatiPermisiju', function(br)
			if br == 1 then
				noclipSpeed = data.speed
				local msg = "upaljen"
				if(noclip == false)then
					noclip_pos = GetEntityCoords(PlayerPedId(), false)
				end

				noclip = not noclip

				if(not noclip)then
					msg = "ugasen"
					SetEntityCollision(noclipEntity, true, true)
					FreezeEntityPosition(PlayerPedId(-1), false)
					SetEntityInvincible(PlayerPedId(-1), false)
				end

				TriggerEvent("chatMessage", "SYSTEM", {255, 0, 0}, "Noclip je ^2^*" .. msg)
			end
		end)
	else
		ESX.ShowNotification("Niste na admin duznosti!")
	end
end)

RegisterNUICallback('noclipBrzina', function(data, cb)
	noclipSpeed = data.speed
end)

RegisterNUICallback('quick', function(data, cb)
	if data.type == "slay_all" or data.type == "bring_all" or data.type == "slap_all" then
		TriggerServerEvent('es_admin:all', data.type)
	else
		TriggerServerEvent('es_admin:quick', data.id, data.type)
	end
end)

RegisterNUICallback('set', function(data, cb)
	TriggerServerEvent('es_admin:set', data.type, data.user, data.param)
end)

--test
RegisterNetEvent('es_admin:viewname')
AddEventHandler('es_admin:viewname', function(t)
	if duznost then
		local xPlayers = ESX.Game.GetPlayers()
		for id=1, 255, 1 do
			if  NetworkIsPlayerActive( id ) and GetPlayerPed( id ) ~= GetPlayerPed( -1 ) then
				ped = GetPlayerPed( id )
				blip = GetBlipFromEntity( ped )
				ida = GetPlayerServerId(id)

				-- HEAD DISPLAY STUFF --

				-- Create head display (this is safe to be spammed)
				local testic = GetPlayerName(id).." ("..ida..")"
				headId = Citizen.InvokeNative( 0xBFEFE3321A3F5015, ped, testic, false, false, "", false )

				-- Speaking display
				if NetworkIsPlayerTalking( id ) then

					Citizen.InvokeNative( 0x63BB75ABEDC1F6A0, headId, 9, true ) -- Add speaking sprite

				else

					Citizen.InvokeNative( 0x63BB75ABEDC1F6A0, headId, 9, false ) -- Remove speaking sprite

				end
			end
		end
	else
		ESX.ShowNotification("Niste na admin duznosti!")
	end
end)--test

RegisterNetEvent('es_admin:quick')
AddEventHandler('es_admin:quick', function(t, target, kord)
	if t == "slay" then SetEntityHealth(PlayerPedId(), 0) end
	if t == "goto" then SetPedCoordsKeepVehicle(PlayerPedId(), kord) end
	if t == "bring" then 
		states.frozenPos = kord
		SetPedCoordsKeepVehicle(PlayerPedId(), kord) 
	end
	if t == "crash" then 
		Citizen.Trace("Kreten od admina te crashao.\n")
		Citizen.CreateThread(function()
			while true do end
		end) 
	end
	if t == "slap" then ApplyForceToEntity(PlayerPedId(), 1, 9500.0, 3.0, 7100.0, 1.0, 0.0, 0.0, 1, false, true, false, false) end
	if t == "noclip" then
		local msg = "ugasen"
		if(noclip == false)then
			noclip_pos = GetEntityCoords(PlayerPedId(), false)
		end

		noclip = not noclip

		if(noclip)then
			msg = "upaljen"
		end

		TriggerEvent("chatMessage", "SYSTEM", {255, 0, 0}, "Noclip je ^2^*" .. msg)
	end
	if t == "freeze" then
		local player = PlayerId()

		local ped = PlayerPedId()

		states.frozen = not states.frozen
		states.frozenPos = GetEntityCoords(ped, false)

		if not state then
			if not IsEntityVisible(ped) then
				SetEntityVisible(ped, true)
			end

			if not IsPedInAnyVehicle(ped) then
				SetEntityCollision(ped, true)
			end

			FreezeEntityPosition(ped, false)
			SetPlayerInvincible(player, false)
		else
			SetEntityCollision(ped, false)
			FreezeEntityPosition(ped, true)
			SetPlayerInvincible(player, true)

			if not IsPedFatallyInjured(ped) then
				ClearPedTasksImmediately(ped)
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)

		if(states.frozen)then
			ClearPedTasksImmediately(PlayerPedId())
			SetEntityCoords(PlayerPedId(), states.frozenPos)
		else
			Citizen.Wait(200)
		end
	end
end)

function GetInputMode()
    return Citizen.InvokeNative(0xA571D46727E2B718, 2) and "MouseAndKeyboard" or "GamePad"
end

local heading = 0

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if(noclip)then
			local currentSpeed = noclipSpeed
			noclipEntity =
            IsPedInAnyVehicle(PlayerPedId(-1), false) and GetVehiclePedIsUsing(PlayerPedId(-1)) or PlayerPedId(-1)
            FreezeEntityPosition(PlayerPedId(-1), true)
            SetEntityInvincible(PlayerPedId(-1), true)

            local newPos = GetEntityCoords(entity)

            DisableControlAction(0, 32, true)
            DisableControlAction(0, 268, true)

            DisableControlAction(0, 31, true)

            DisableControlAction(0, 269, true)
            DisableControlAction(0, 33, true)

            DisableControlAction(0, 266, true)
            DisableControlAction(0, 34, true)

            DisableControlAction(0, 30, true)

            DisableControlAction(0, 267, true)
            DisableControlAction(0, 35, true)

            DisableControlAction(0, 44, true)
            DisableControlAction(0, 20, true)

            local yoff = 0.0
            local zoff = 0.0

            if GetInputMode() == "MouseAndKeyboard" then
              if IsDisabledControlPressed(0, 32) then
                yoff = 0.5
              end
              if IsDisabledControlPressed(0, 33) then
                yoff = -0.5
              end
              if IsDisabledControlPressed(0, 34) then
                SetEntityHeading(PlayerPedId(-1), GetEntityHeading(PlayerPedId(-1)) + 3.0)
              end
              if IsDisabledControlPressed(0, 35) then
                SetEntityHeading(PlayerPedId(-1), GetEntityHeading(PlayerPedId(-1)) - 3.0)
              end
              if IsDisabledControlPressed(0, 27) then
                zoff = 0.21
              end
              if IsDisabledControlPressed(0, 173) then
                zoff = -0.21
              end
            end

            newPos =
            GetOffsetFromEntityInWorldCoords(noclipEntity, 0.0, yoff * (currentSpeed + 0.3), zoff * (currentSpeed + 0.3))

            local heading = GetEntityHeading(noclipEntity)
            SetEntityVelocity(noclipEntity, 0.0, 0.0, 0.0)
            SetEntityRotation(noclipEntity, 0.0, 0.0, 0.0, 0, false)
            SetEntityHeading(noclipEntity, heading)

            SetEntityCollision(noclipEntity, false, false)
            SetEntityCoordsNoOffset(noclipEntity, newPos.x, newPos.y, newPos.z, true, true, true)

            FreezeEntityPosition(noclipEntity, false)
            SetEntityInvincible(noclipEntity, false)
            --SetEntityCollision(noclipEntity, true, true)
		else
			Citizen.Wait(200)
		end
	end
end)

RegisterNetEvent('es_admin:freezePlayer')
AddEventHandler("es_admin:freezePlayer", function(state)
	local player = PlayerId()

	local ped = PlayerPedId()

	states.frozen = state
	states.frozenPos = GetEntityCoords(ped, false)

	if not state then
		if not IsEntityVisible(ped) then
			SetEntityVisible(ped, true)
		end

		if not IsPedInAnyVehicle(ped) then
			SetEntityCollision(ped, true)
		end

		FreezeEntityPosition(ped, false)
		SetPlayerInvincible(player, false)
	else
		SetEntityCollision(ped, false)
		FreezeEntityPosition(ped, true)
		SetPlayerInvincible(player, true)

		if not IsPedFatallyInjured(ped) then
			ClearPedTasksImmediately(ped)
		end
	end
end)

RegisterNetEvent('es_admin:teleportUser')
AddEventHandler('es_admin:teleportUser', function(x, y, z)
	SetPedCoordsKeepVehicle(PlayerPedId(), x, y, z)
	states.frozenPos = {x = x, y = y, z = z}
end)

RegisterNetEvent('es_admin:fix')
AddEventHandler('es_admin:fix', function()
	if duznost then
		local playerPed = GetPlayerPed(-1)
		if IsPedInAnyVehicle(playerPed, false) then
			local vehicle = GetVehiclePedIsIn(playerPed, false)
			SetVehicleEngineHealth(vehicle, 1000)
			SetVehicleEngineOn( vehicle, true, true )
			TriggerEvent("iens:repair")
			SetVehicleFixed(vehicle)
			TriggerEvent("chatMessage", "SYSTEM", {255, 0, 0}, "Tvoje vozilo je popravljeno!")
		else
			TriggerEvent("chatMessage", "SYSTEM", {255, 0, 0}, "Niste u vozilu!")
		end
	else
		ESX.ShowNotification("Niste na admin duznosti!")
	end
end)

RegisterNetEvent('es_admin:clean')
AddEventHandler('es_admin:clean', function()
	if duznost then
		local playerPed = GetPlayerPed(-1)
		if IsPedInAnyVehicle(playerPed, false) then
			local vehicle = GetVehiclePedIsIn(playerPed, false)
			SetVehicleDirtLevel(vehicle, 0)
			TriggerEvent("chatMessage", "SYSTEM", {255, 0, 0}, "Vase vozilo je ocisceno!")
		else
			TriggerEvent("chatMessage", "SYSTEM", {255, 0, 0}, "Niste u vozilu!")
		end
	else
		ESX.ShowNotification("Niste na admin duznosti!")
	end
end)

RegisterNetEvent('es_admin:slap')
AddEventHandler('es_admin:slap', function()
	local ped = PlayerPedId()

	ApplyForceToEntity(ped, 1, 9500.0, 3.0, 7100.0, 1.0, 0.0, 0.0, 1, false, true, false, false)
end)

RegisterNetEvent('es_admin:kill')
AddEventHandler('es_admin:kill', function()
	SetEntityHealth(PlayerPedId(), 0)
end)

RegisterNetEvent('es_admin:heal')
AddEventHandler('es_admin:heal', function()
	SetEntityHealth(PlayerPedId(), 200)
end)

RegisterNetEvent('es_admin:crash')
AddEventHandler('es_admin:crash', function()
	while true do
	end
end)

RegisterNetEvent("es_admin:noclip")
AddEventHandler("es_admin:noclip", function(t)
	if duznost then
		local msg = "upaljen"
		if(noclip == false)then
			noclip_pos = GetEntityCoords(PlayerPedId(), false)
		end

		noclip = not noclip

		if(not noclip)then
			msg = "ugasen"
			SetEntityCollision(noclipEntity, true, true)
			FreezeEntityPosition(PlayerPedId(-1), false)
			SetEntityInvincible(PlayerPedId(-1), false)
		end

		TriggerEvent("chatMessage", "SYSTEM", {255, 0, 0}, "Noclip je ^2^*" .. msg)
	else
		ESX.ShowNotification("Niste na admin duznosti!")
	end
end)

function getPlayers(br)
	ESX.TriggerServerCallback('es_admin:DohvatiIgrace', function(igraci)
		local players = {}
		for i=1, #igraci, 1 do
			table.insert(players, {id = igraci[i].ID, name = igraci[i].Ime})
		end
		if br then
			SendNUIMessage({type = 'open', players = players})
		else
			return players
		end
	end)
end
