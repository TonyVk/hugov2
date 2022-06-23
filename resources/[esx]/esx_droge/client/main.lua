ESX                             = nil
local hasAlreadyEnteredMarker = false
local lastZone                = nil
local CurrentAction           = nil
local CurrentActionMsg        = ''
local runspeed = 1.20 --(Change the run speed here !!! MAXIMUM IS 1.49 !!! )
local onDrugs = false
local locations = {}
local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}
local spawned = false
local displayed = false
local menuOpen = false
local process = true
local Droge = {}

local spawned2 = false
local locations2 = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
    ESX.TriggerServerCallback('droge:DohvatiDroge', function(vr)
		Droge = vr
        Wait(2000)
        SpawnNPC()
	end)
end)

RegisterNetEvent('droge:VratiDroge')
AddEventHandler('droge:VratiDroge', function(vr)
    for i=1, #Droge, 1 do
        if Droge[i].Ped ~= nil then
            DeleteEntity(Droge[i].Ped)
            Droge[i].Ped = nil
            exports.qtarget:RemoveZone("marihuana_ped")
        end
	end
	Droge = vr
    if spawned then
        locations = {}
    end
    spawned = false

    if spawned2 then
        locations2 = {}
    end
    spawned2 = false
    SpawnNPC()
end)

LoadModel = function(model)
	RequestModel(model)

	while not HasModelLoaded(model) do
		Wait(10)
	end
end

function SpawnNPC()
    local pedmodel = GetHashKey("s_m_y_dealer_01")
	LoadModel(pedmodel)
	for i=1, #Droge, 1 do
		if Droge[i] ~= nil and Droge[i].vrsta == 3 and Droge[i].heading ~= nil then
			Droge[i].Ped = CreatePed(0, pedmodel, Droge[i].branje, Droge[i].heading, false, true)
			SetEntityInvincible(Droge[i].Ped, true)
			SetBlockingOfNonTemporaryEvents(Droge[i].Ped, true)
			SetPedDiesWhenInjured(Droge[i].Ped, false)
			SetPedFleeAttributes(Droge[i].Ped, 2)
			FreezeEntityPosition(Droge[i].Ped, true)
			SetPedCanPlayAmbientAnims(Droge[i].Ped, false)
			SetPedCanRagdollFromPlayerImpact(Droge[i].Ped, false)
			exports.qtarget:AddEntityZone("marihuana", Droge[i].Ped, 
			{
				name = "marihuana_ped",
				debugPoly = false,
				useZ = true
			}, {
				options = {
					{
						event = "marihuana:KupiSjeme",
						icon = "far fa-comment",
						label = "Kupi sjeme marihuane ($200)",
						idzona = i
					}
				},
				distance = 2.5
			})
		end
	end
	SetModelAsNoLongerNeeded(pedmodel)
end

RegisterNetEvent('marihuana:KupiSjeme')
AddEventHandler('marihuana:KupiSjeme', function(data)
	OpenDrugShop(data.idzona)
end)

function OpenDrugShop(i)
	ESX.UI.Menu.CloseAll()
	local elements = {}
	menuOpen = true
	table.insert(elements, {
        label = ('%s - <span style="color:green;">%s</span>'):format("Sjeme", 200),
        name = "seed",
        price = 200,

        -- menu properties
        type = 'slider',
        value = 1,
        min = 1,
        max = 20
	})
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'drug_shop', {
		title    = "Diler",
		--align    = 'top-left',
		elements = elements
	}, function(data, menu)
        if #(GetEntityCoords(PlayerPedId())-Droge[i].branje) > 4.0 then
            menuOpen = false
            menu.close()
        else
            local torba = 0
            TriggerEvent('skinchanger:getSkin', function(skin)
                torba = skin['bags_1']
            end)
            if torba == 40 or torba == 41 or torba == 44 or torba == 45 then
                TriggerServerEvent('droge:prodajih', data.current.name, data.current.value, true)
            else
                TriggerServerEvent('droge:prodajih', data.current.name, data.current.value, false)
            end
        end
	end, function(data, menu)
		menu.close()
		menuOpen = false
	end)
end

RegisterCommand("uredidroge", function(source, args, raw)
	ESX.TriggerServerCallback('DajMiPermLevelCall', function(perm)
		if perm == 69 then
			ESX.UI.Menu.CloseAll()
			local elements = {
				{label = "Heroin", value = "heroin"},
                {label = "Kokain", value = "kokain"},
                {label = "Marihuana", value = "marihuana"}
			}

			ESX.UI.Menu.Open(
				'default', GetCurrentResourceName(), 'udr',
				{
					title    = "Izaberite drogu",
					align    = 'top-left',
					elements = elements,
				},
				function(data, menu)
					if data.current.value == "heroin" then
                        elements = {
                            {label = "Postavite koordinate skupljanja", value = 1}
                        }
            
                        ESX.UI.Menu.Open(
                            'default', GetCurrentResourceName(), 'udkor',
                            {
                                title    = "Izaberite opciju",
                                align    = 'top-left',
                                elements = elements,
                            },
                            function(data2, menu2)
                                local koord = GetEntityCoords(PlayerPedId())
                                TriggerServerEvent("droge:PostaviKoord", 1, data2.current.value, koord-vector3(0.0, 0.0, 1.0), nil)
                                menu2.close()
                                menu.close()
                            end,
                            function(data2, menu2)
                                menu2.close()
                                menu.close()
                            end
                        )
                    elseif data.current.value == "kokain" then
                        elements = {
                            {label = "Postavite koordinate skupljanja", value = 1}
                        }
            
                        ESX.UI.Menu.Open(
                            'default', GetCurrentResourceName(), 'udkor',
                            {
                                title    = "Izaberite opciju",
                                align    = 'top-left',
                                elements = elements,
                            },
                            function(data2, menu2)
                                local koord = GetEntityCoords(PlayerPedId())
                                TriggerServerEvent("droge:PostaviKoord", 2, data2.current.value, koord-vector3(0.0, 0.0, 1.0), nil)
                                menu2.close()
                                menu.close()
                            end,
                            function(data2, menu2)
                                menu2.close()
                                menu.close()
                            end
                        )
                    elseif data.current.value == "marihuana" then
                        elements = {
                            {label = "Postavite koordinate kupovine sjemena", value = 1}
                        }
            
                        ESX.UI.Menu.Open(
                            'default', GetCurrentResourceName(), 'udkoraa',
                            {
                                title    = "Izaberite opciju",
                                align    = 'top-left',
                                elements = elements,
                            },
                            function(data2, menu2)
                                local koord = GetEntityCoords(PlayerPedId())
                                local head = GetEntityHeading(PlayerPedId())
                                TriggerServerEvent("droge:PostaviKoord", 3, data2.current.value, koord-vector3(0.0, 0.0, 1.0), head)
                                menu2.close()
                                menu.close()
                            end,
                            function(data2, menu2)
                                menu2.close()
                                menu.close()
                            end
                        )
                    end
				end,
				function(data, menu)
					menu.close()
				end
			)
		end
	end)
end, false)

RegisterNetEvent('es_admin:setPerm')
AddEventHandler('es_admin:setPerm', function()
	ESX.TriggerServerCallback('esx-races:DohvatiPermisiju', function(br)
		perm = br
	end)
end)

-- Useitem thread
RegisterNetEvent('esx_koristiHeroin:useItem')
AddEventHandler('esx_koristiHeroin:useItem', function(itemName)
	if onDrugs == false then
		ESX.UI.Menu.CloseAll()

		if itemName == 'heroin' then
			onDrugs = true
			local lib, anim = 'anim@mp_player_intcelebrationmale@face_palm', 'face_palm'
			local playerPed = PlayerPedId()
			ESX.ShowNotification('Osjecate kako vam zivci pocinju raditi protiv vas...')
			TriggerServerEvent("esx_koristiHeroin:removeItem", "heroin")
			local playerPed = PlayerPedId()
			SetEntityHealth(playerPed, 150)
			SetPedArmour(playerPed, 25)
			SetRunSprintMultiplierForPlayer(PlayerId(), 0.5)
			ESX.Streaming.RequestAnimDict(lib, function()
				TaskPlayAnim(playerPed, lib, anim, 8.0, -8.0, -1, 32, 0, false, false, false)

				Citizen.Wait(500)
				while IsEntityPlayingAnim(playerPed, lib, anim, 3) do
					Citizen.Wait(0)
					DisableAllControlActions(0)
				end

				TriggerEvent('esx_koristiHeroin:runMan')
			end)
		end
	else
		ESX.ShowNotification("Vec ste pod utjecajom droge!")
	end
end)

AddEventHandler('esx:onPlayerDeath', function(data)
	if onDrugs == true then
		DoScreenFadeOut(1000)
		Citizen.Wait(1000)
		DoScreenFadeIn(1000)
		ClearTimecycleModifier()
		ResetPedMovementClipset(GetPlayerPed(-1), 0)
		SetRunSprintMultiplierForPlayer(PlayerId(),0.5)
		ClearAllPedProps(GetPlayerPed(-1), true)
		SetPedMotionBlur(GetPlayerPed(-1), false)
		ESX.ShowNotification('Utjecaj droge popusta')
        onDrugs = false
	end
end)

-- Cocaine effect (Run really fast)
RegisterNetEvent('esx_koristiHeroin:runMan')
AddEventHandler('esx_koristiHeroin:runMan', function()
    RequestAnimSet("move_m@hurry_butch@b")
    while not HasAnimSetLoaded("move_m@hurry_butch@b") do
        Citizen.Wait(0)
    end
	count = 0
    DoScreenFadeOut(1000)
    Citizen.Wait(1000)
    SetPedMotionBlur(GetPlayerPed(-1), true)
    SetTimecycleModifier("spectator5")
    SetPedMovementClipset(GetPlayerPed(-1), "move_m@hurry_butch@b", true)
	SetRunSprintMultiplierForPlayer(PlayerId(), 0.5)
    DoScreenFadeIn(1000)
	repeat
		Citizen.Wait(10000)
		count = count  + 1
	until count == 8
    DoScreenFadeOut(1000)
    Citizen.Wait(1000)
    DoScreenFadeIn(1000)
    ClearTimecycleModifier()
    ResetPedMovementClipset(GetPlayerPed(-1), 0)
	SetRunSprintMultiplierForPlayer(PlayerId(),1.0)
    ClearAllPedProps(GetPlayerPed(-1), true)
    SetPedMotionBlur(GetPlayerPed(-1), false)
    ESX.ShowNotification('Utjecaj droge popusta...')
    onDrugs = false
end)

Citizen.CreateThread( function()
	Citizen.Wait(10000)
	while true do
	    Citizen.Wait(1000)
        for i=1, #Droge, 1 do
            if Droge[i].vrsta == 1 and Droge[i].branje ~= nil then
                if #(GetEntityCoords(PlayerPedId())-Droge[i].branje) <= 200 then
                    if spawned == false then
                        TriggerEvent('Heroin:start')
                        TriggerEvent('Heroin:start')
                        TriggerEvent('Heroin:start')
                        TriggerEvent('Heroin:start')
                        TriggerEvent('Heroin:start')
                        TriggerEvent('Heroin:start')
                        TriggerEvent('Heroin:start')
                        TriggerEvent('Heroin:start')
                        TriggerEvent('Heroin:start')
                        TriggerEvent('Heroin:start')
                        TriggerEvent('Heroin:start')
                        spawned = true
                    end
                else
                    if spawned then
                        locations = {}
                    end
                    spawned = false
                end
            end
        end
	end
end)
			
AddEventHandler('heroin:hasEnteredMarker', function(zone)
	
end)

AddEventHandler('heroin:hasExitedMarker', function(zone)
	ESX.UI.Menu.CloseAll()    
    CurrentAction = nil
    CurrentActionMsg = ''
end)

Citizen.CreateThread(function()
	local waitara = 500
    while true do
        Citizen.Wait(waitara)
        local naso2 = 0
        local kordic = GetEntityCoords(PlayerPedId())
        if ESX ~= nil then
            if not IsPedInAnyVehicle(PlayerPedId()) then
                for k in pairs(locations) do
                    if #(locations[k]-kordic) < 150 then
                        waitara = 0
                        naso2 = 1
                        DrawMarker(3, locations[k], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 200, 0, 110, 0, 1, 0, 0)	
                        if #(locations[k]-kordic) < 1.0 then
                            TriggerEvent('Heroin:new', k)
                            TaskStartScenarioInPlace(PlayerPedId(), 'world_human_gardener_plant', 0, false)
                            Citizen.Wait(2000)
                            ClearPedTasks(PlayerPedId())
                            ClearPedTasksImmediately(PlayerPedId())
                            local torba = 0
                            TriggerEvent('skinchanger:getSkin', function(skin)
                                torba = skin['bags_1']
                            end)
                            if torba == 40 or torba == 41 or torba == 44 or torba == 45 then
                                TriggerServerEvent('Heroin:get', true)
                            else
                                TriggerServerEvent('Heroin:get', false)
                            end
                        end
                    
                    end
                end
            end
        end
        if naso2 == 0 then
            waitara = 500
        end
    end
end)

RegisterNetEvent('Heroin:start')
AddEventHandler('Heroin:start', function()
	local set = false
    local kord = nil
	Citizen.Wait(10)
	for i=1, #Droge, 1 do
        if Droge[i].vrsta == 1 and Droge[i].branje ~= nil then
            kord = Droge[i].branje
            break
        end
    end
    if kord ~= nil then
        local x,y,z = table.unpack(kord)
        local rnX = x + math.random(-40, 40)
        local rnY = y + math.random(-40, 40)
        
        local u, Z = GetGroundZFor_3dCoord(rnX ,rnY ,300.0,0)

        local vect = vector3(rnX, rnY, Z+0.3)
        table.insert(locations, vect);
    end
end)

RegisterNetEvent('Heroin:new')
AddEventHandler('Heroin:new', function(id)
	local set = false
    local kord = nil
	Citizen.Wait(10)
	for i=1, #Droge, 1 do
        if Droge[i].vrsta == 1 and Droge[i].branje ~= nil then
            kord = Droge[i].branje
            break
        end
    end
    if kord ~= nil then
        local x,y,z = table.unpack(kord)
        local rnX = x + math.random(-40, 40)
        local rnY = y + math.random(-40, 40)
        
        local u, Z = GetGroundZFor_3dCoord(rnX ,rnY ,300.0,0)
        
        local vect = vector3(rnX, rnY, Z+0.3)
        locations[id] = vect
        ClearPedTasks(PlayerPedId())
    end
end)

RegisterNetEvent('Heroin:message')
AddEventHandler('Heroin:message', function(message)
	ESX.ShowNotification(message)
end)
			
function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

--Kokain
RegisterNetEvent('esx_drogica:useItem')
AddEventHandler('esx_drogica:useItem', function(itemName)
	if onDrugs == false then
		ESX.UI.Menu.CloseAll()

		if itemName == 'cocaine' then
			onDrugs = true
			local lib, anim = 'anim@mp_player_intcelebrationmale@face_palm', 'face_palm'
			local playerPed = PlayerPedId()
			ESX.ShowNotification('Osjecate kako vam zivci pocinju raditi protiv vas...')
			TriggerServerEvent("esx_drogica:removeItem", "cocaine")
			local playerPed = PlayerPedId()
			SetEntityHealth(playerPed, GetEntityMaxHealth(playerPed))
			SetPedArmour(playerPed, 100)
			ESX.Streaming.RequestAnimDict(lib, function()
				TaskPlayAnim(playerPed, lib, anim, 8.0, -8.0, -1, 32, 0, false, false, false)

				Citizen.Wait(500)
				while IsEntityPlayingAnim(playerPed, lib, anim, 3) do
					Citizen.Wait(0)
					DisableAllControlActions(0)
				end

				TriggerEvent('esx_drogica:runMan')
			end)
		end
	else
		ESX.ShowNotification("Vec ste nadrogirani!")
	end
end)

-- Cocaine effect (Run really fast)
RegisterNetEvent('esx_drogica:runMan')
AddEventHandler('esx_drogica:runMan', function()
    RequestAnimSet("move_m@hurry_butch@b")
    while not HasAnimSetLoaded("move_m@hurry_butch@b") do
        Citizen.Wait(0)
    end
	count = 0
    DoScreenFadeOut(1000)
    Citizen.Wait(1000)
    SetPedMotionBlur(GetPlayerPed(-1), true)
    SetTimecycleModifier("spectator5")
    SetPedMovementClipset(GetPlayerPed(-1), "move_m@hurry_butch@b", true)
	SetRunSprintMultiplierForPlayer(PlayerId(), runspeed)
    DoScreenFadeIn(1000)
	repeat
		ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.1)
		TaskJump(GetPlayerPed(-1), false, true, false)
		Citizen.Wait(5000)
		count = count  + 1
	until count == 6
    DoScreenFadeOut(1000)
    Citizen.Wait(1000)
    DoScreenFadeIn(1000)
    ClearTimecycleModifier()
    ResetPedMovementClipset(GetPlayerPed(-1), 0)
	SetRunSprintMultiplierForPlayer(PlayerId(),1.0)
    ClearAllPedProps(GetPlayerPed(-1), true)
    SetPedMotionBlur(GetPlayerPed(-1), false)
    ESX.ShowNotification('Dolazite sebi...')
    onDrugs = false
end)

Citizen.CreateThread( function()
	Citizen.Wait(10000)
	while true do
		Citizen.Wait(1000)
        for i=1, #Droge, 1 do
            if Droge[i].vrsta == 2 and Droge[i].branje ~= nil then
                if #(GetEntityCoords(PlayerPedId())-Droge[i].branje) <= 200 then
                    if spawned2 == false then
                        TriggerEvent('esx_drogica:start')
                        TriggerEvent('esx_drogica:start')
                        TriggerEvent('esx_drogica:start')
                        TriggerEvent('esx_drogica:start')
                        TriggerEvent('esx_drogica:start')
                        TriggerEvent('esx_drogica:start')
                        TriggerEvent('esx_drogica:start')
                        TriggerEvent('esx_drogica:start')
                        TriggerEvent('esx_drogica:start')
                        TriggerEvent('esx_drogica:start')
                        TriggerEvent('esx_drogica:start')
                        spawned2 = true
                    end
                else
                    if spawned2 then
                        locations2 = {}
                    end
                    spawned2 = false
                end
            end
        end
	end
end)

Citizen.CreateThread(function()
	local waitara = 500
    while true do
		Citizen.Wait(waitara)
		if ESX ~= nil then
            if not IsPedInAnyVehicle(PlayerPedId()) then
                local kordic = GetEntityCoords(PlayerPedId())
                for k in pairs(locations2) do
                    if locations2[k] ~= nil and #(kordic-locations2[k]) < 150 then
                        waitara = 0
                        naso2 = 1
                        DrawMarker(3, locations2[k], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 200, 0, 110, 0, 1, 0, 0)	
                        if #(kordic-locations2[k]) < 1.0 then
                            local kordara = locations2[k]
                            TriggerEvent('esx_drogica:new', k)
                            TaskStartScenarioInPlace(PlayerPedId(), 'world_human_gardener_plant', 0, false)
                            Citizen.Wait(2000)
                            ClearPedTasks(PlayerPedId())
                            ClearPedTasksImmediately(PlayerPedId())
                            kordic = GetEntityCoords(PlayerPedId())
                            if not IsEntityDead(PlayerPedId()) and #(kordic-kordara) < 1.5 then
                                local torba = 0
                                TriggerEvent('skinchanger:getSkin', function(skin)
                                    torba = skin['bags_1']
                                end)
                                if torba == 40 or torba == 41 or torba == 44 or torba == 45 then
                                    TriggerServerEvent('esx_drogica:get', true)
                                else
                                    TriggerServerEvent('esx_drogica:get', false)
                                end
                            end
                        end
                    end
                end
            end
		end
		if naso2 == 0 then
			waitara = 500
		end
    end
end)

RegisterNetEvent('esx_drogica:start')
AddEventHandler('esx_drogica:start', function()
	local set = false
    local kord = nil
	Citizen.Wait(10)
	for i=1, #Droge, 1 do
        if Droge[i].vrsta == 2 and Droge[i].branje ~= nil then
            kord = Droge[i].branje
            break
        end
    end
    if kord ~= nil then
        local x,y,z = table.unpack(kord)
        
        local rnX = x + math.random(-35, 35)
        local rnY = y + math.random(-35, 35)
        
        local u, Z = GetGroundZFor_3dCoord(rnX ,rnY ,300.0,0)
        
        local vect = vector3(rnX, rnY, Z+0.3)
        table.insert(locations2, vect);
    end
end)

RegisterNetEvent('esx_drogica:new')
AddEventHandler('esx_drogica:new', function(id)
	local set = false
    local kord = nil
	Citizen.Wait(10)
	for i=1, #Droge, 1 do
        if Droge[i].vrsta == 2 and Droge[i].branje ~= nil then
            kord = Droge[i].branje
            break
        end
    end
    if kord ~= nil then
        local x,y,z = table.unpack(kord)
        
        local rnX = x + math.random(-35, 35)
        local rnY = y + math.random(-35, 35)
        
        local u, Z = GetGroundZFor_3dCoord(rnX ,rnY ,300.0,0)
        
        local vect = vector3(rnX, rnY, Z+0.3)
        
        locations2[id] = vect
        ClearPedTasks(PlayerPedId())
    end
end)