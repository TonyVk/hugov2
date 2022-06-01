ESX = nil
local Objekti = {}
local Spawno = false
local Broj = 0
local Radis = false
local Vozilo = nil
local Prikolica = nil
local Mower = nil
local Kosilica = nil
local SpawnMarker = false
local Ulica = false
local Blipic = nil
local ObjBr = 1
local Cpovi = {}
local PosaoPed = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while ESX.GetPlayerData().posao == nil do
		Citizen.Wait(100)
	end
	ProvjeriPosao()
end)

local isInService = false
local hasAlreadyEnteredMarker = false
local lastZone                = nil
local Blips                   = {}

local tablicaVozila = ""
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}
local Blipara				  = {}
--------------------------------------------------------------------------------
function ProvjeriPosao()
	ESX.PlayerData = ESX.GetPlayerData()
	DodajBlip()
	SpawnCpove()
	SpawnNpcove()
end
function DodajBlip()
	local blip = AddBlipForCoord(Config.ZaposliSe.Pos.x, Config.ZaposliSe.Pos.y, Config.ZaposliSe.Pos.z)
	SetBlipSprite  (blip, Config.ZaposliSe.Sprite)
	SetBlipDisplay (blip, 4)
	SetBlipScale   (blip, 1.2)
	SetBlipCategory(blip, 3)
	SetBlipColour  (blip, Config.ZaposliSe.BColor)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Kosac")
	EndTextCommandSetBlipName(blip)
end
function SpawnCpove()
	if #Cpovi > 0 then
		for i=1, #Cpovi, 1 do
		  	if Cpovi[i] ~= nil then
			  	if Cpovi[i].Spawnan then
					DeleteCheckpoint(Cpovi[i].ID)
					Cpovi[i].Spawnan = false
			  	end
		  	end
		end
	end
	Cpovi = {}
	--[[for k,v in pairs(Config.Zones) do
		if v.Type ~= -1 then
			table.insert(Cpovi, {ID = check, Tip = 2, Koord = v.Pos, Spawnan = false, r = v.Color.r, g = v.Color.g, b = v.Color.b})
		end
	end]]
	if JesiKosac() then
		for k,v in pairs(Config.Cloakroom) do
			table.insert(Cpovi, {ID = check, Tip = 1, Koord = v.Pos, Spawnan = false, r = v.Color.r, g = v.Color.g, b = v.Color.b})
		end
	end
end
function SpawnNpcove()
	if PosaoPed ~= nil then
		DeleteEntity(PosaoPed)
		exports.qtarget:RemoveZone('kosac_posao')
		PosaoPed = nil
	end
	if ESX.PlayerData.posao.name ~= "kosac" then
		local pedmodel = GetHashKey("s_m_m_gardener_01")
		LoadModel(pedmodel)
		PosaoPed = CreatePed(0, pedmodel, Config.ZaposliSe.Pos - vector3(0.0, 0.0, 1.0), Config.ZaposliSe.Heading, false, true)
		SetEntityInvincible(PosaoPed, true)
		SetBlockingOfNonTemporaryEvents(PosaoPed, true)
		SetPedDiesWhenInjured(PosaoPed, false)
		SetPedFleeAttributes(PosaoPed, 2)
		FreezeEntityPosition(PosaoPed, true)
		SetPedCanPlayAmbientAnims(PosaoPed, false)
		SetPedCanRagdollFromPlayerImpact(PosaoPed, false)

		exports.qtarget:AddEntityZone("kosac", PosaoPed, 
		{
			name="kosac_posao",
			debugPoly=false,
			useZ = true
		}, {
			options = {
				{
					event = "kosac:ZaposliSe",
					icon = "far fa-comment",
					label = "Zaposlite se",
					posao ~= Config.Posao
				},
			},
			distance = 2.5
		})
		SetModelAsNoLongerNeeded(pedmodel)
	end
end
RegisterNetEvent('kosac:ZaposliSe')
AddEventHandler('kosac:ZaposliSe', function()
	TriggerEvent("upit:OtvoriPitanje", "esx_kosac", "Upit za posao", "Dali se zelite zaposliti kao kosac?")
end)
LoadModel = function(model)
	RequestModel(model)

	while not HasModelLoaded(model) do
		Wait(10)
	end
end
-- MENUS
function MenuCloakRoom()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'cloakroom',
		{
			title    = _U('cloakroom'),
			elements = {
				{label = _U('job_wear'), value = 'job_wear'},
				{label = _U('citizen_wear'), value = 'citizen_wear'}
			}
		},
		function(data, menu)
			if data.current.value == 'citizen_wear' then
				if isInService then
					isInService = false
					for i=1, #Cpovi, 1 do
						if Cpovi[i] ~= nil and Cpovi[i].Tip == 2 then
							if Cpovi[i].Spawnan then
								DeleteCheckpoint(Cpovi[i].ID)
								Cpovi[i].Spawnan = false
								table.remove(Cpovi, i)
							end
						end
					end
					ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
						TriggerEvent('skinchanger:loadSkin', skin)
					end)
					TriggerEvent("dpemotes:Radim", false)
				end
			end
			if data.current.value == 'job_wear' then
				if not isInService then
					for k,v in pairs(Config.Zones) do
						if v.Type ~= -1 then
							table.insert(Cpovi, {ID = check, Tip = 2, Koord = v.Pos, Spawnan = false, r = v.Color.r, g = v.Color.g, b = v.Color.b})
						end
					end
					isInService = true
					setUniform(PlayerPedId())
				end
			end
			menu.close()
		end,
		function(data, menu)
			menu.close()
		end
	)
end

function MenuVehicleSpawner()
	local elements = {}

	for i=1, #Config.Trucks, 1 do
		table.insert(elements, {label = GetLabelText(GetDisplayNameFromVehicleModel(Config.Trucks[i])), value = Config.Trucks[i]})
	end
	table.insert(elements, {label = "Obicna kosilica", value = "kosilica"})

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'vehiclespawner',
		{
			title    = _U('vehiclespawner'),
			elements = elements
		},
		function(data, menu)
		if data.current.value == "mower" then
			if Vozilo ~= nil then
				ESX.Game.DeleteVehicle(Vozilo)
				Vozilo = nil
			end
			ESX.Streaming.RequestModel(data.current.value)
			Vozilo = CreateVehicle(data.current.value, Config.Zones.VehicleSpawnPoint.Pos.x, Config.Zones.VehicleSpawnPoint.Pos.y, Config.Zones.VehicleSpawnPoint.Pos.z, 315.28479003906, true, false)
			platenum = math.random(10000, 99999)
			SetModelAsNoLongerNeeded(data.current.value)
			SetVehicleNumberPlateText(Vozilo, "WAL"..platenum)             
			tablicaVozila = "WAL"..platenum			
			TaskWarpPedIntoVehicle(GetPlayerPed(-1), Vozilo, -1)
			Radis = true
			TriggerEvent("dpemotes:Radim", true)
			SpawnObjekte()
		elseif data.current.value == "kosilica" then
			SetPlayerInvincible(PlayerId(), true)
			ESX.ShowNotification("Ukoliko zelite zavrsiti posao upisite /zavrsikosenje")
			SetEntityCoords(PlayerPedId(), -1348.0754394531, 128.62022399902, 55.238655090332, false, false, false, true)
			SetEntityHeading(PlayerPedId(), 220.04908752441)
			if Kosilica ~= nil then
				DeleteObject(Kosilica)
			end
			ESX.Streaming.RequestAnimDict("anim@heists@box_carry@", function()
				TaskPlayAnim(PlayerPedId(),"anim@heists@box_carry@", "idle", 8.0, 8.0, -1, 50)
			end)
			local modele = "prop_lawnmower_01"
			ESX.Streaming.RequestModel(modele)
			Kosilica = CreateObject(GetHashKey(modele), GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.0, -5.0), true, false, false)
			AttachEntityToEntityPhysically(Kosilica, PlayerPedId(), 0, GetEntityBoneIndexByName(PlayerPedId(), "SKEL_Pelvis"), 0.175, 0.90, -0.86, -0.075, 0.90, -0.86, 0.0, 0.5, 181.0, 10000.0, true, true, true, false, 2)
			SetModelAsNoLongerNeeded(modele)
			TriggerEvent("dpemotes:Radim", true)
			Radis = true
			SpawnObjekte2()
		end

			menu.close()
		end,
		function(data, menu)
			menu.close()
		end
	)
end

RegisterCommand('zavrsikosenje', function(source, args, rawCommand)
	if Kosilica ~= nil then
		ZavrsiPosao()
	else
		ESX.ShowNotification("Ne kosite travu!")
	end
end, false)

function setUniform(playerPed)
	TriggerEvent('skinchanger:getSkin', function(skin)
		if skin.sex == 0 then
			if Config.Uniforms.EUP == false or Config.Uniforms.EUP == nil then
				if Config.Uniforms["uniforma"].male then
					TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms["uniforma"].male)
				else
					ESX.ShowNotification("Nema postavljene uniforme!")
				end
			else
				local jobic = "EUPuniforma"
				local outfit = Config.Uniforms[jobic].male
				local ped = playerPed

				RequestModel(outfit.ped)

				while not HasModelLoaded(outfit.ped) do
					Wait(0)
				end

				if GetEntityModel(ped) ~= GetHashKey(outfit.ped) then
					SetPlayerModel(PlayerId(), outfit.ped)
				end

				ped = PlayerPedId()

				for _, comp in ipairs(outfit.components) do
				   SetPedComponentVariation(ped, comp[1], comp[2] - 1, comp[3] - 1, 0)
				end

				for _, comp in ipairs(outfit.props) do
					if comp[2] == 0 then
						ClearPedProp(ped, comp[1])
					else
						SetPedPropIndex(ped, comp[1], comp[2] - 1, comp[3] - 1, true)
					end
				end
			end
			
		else
			if Config.Uniforms.EUP == false then
				if Config.Uniforms["uniforma"].female then
					TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms["uniforma"].female)
				else
					ESX.ShowNotification(_U('no_outfit'))
				end
			else
				local jobic = "EUPuniforma"
				local outfit = Config.Uniforms[jobic].female
				local ped = playerPed

				RequestModel(outfit.ped)

				while not HasModelLoaded(outfit.ped) do
					Wait(0)
				end

				if GetEntityModel(ped) ~= GetHashKey(outfit.ped) then
					SetPlayerModel(PlayerId(), outfit.ped)
				end

				ped = PlayerPedId()

				for _, comp in ipairs(outfit.components) do
				   SetPedComponentVariation(ped, comp[1], comp[2] - 1, comp[3] - 1, 0)
				end

				for _, comp in ipairs(outfit.props) do
					if comp[2] == 0 then
						ClearPedProp(ped, comp[1])
					else
						SetPedPropIndex(ped, comp[1], comp[2] - 1, comp[3] - 1, true)
					end
				end
			end


		end
	end)
end

function SpawnObjekte2()
	for i=1, #Config.Objekti2, 1 do
		ESX.Game.SpawnLocalObject('prop_veg_grass_02_a', {
				x = Config.Objekti2[i].x,
				y = Config.Objekti2[i].y,
				z = Config.Objekti2[i].z-1.7
		}, function(obj)
			local blip = AddBlipForCoord(Config.Objekti2[i].x,  Config.Objekti2[i].y,  Config.Objekti2[i].z)
			SetBlipSprite (blip, 1)
			SetBlipDisplay(blip, 8)
			SetBlipColour (blip, 2)
			SetBlipScale  (blip, 1.4)
			table.insert(Objekti, {id = obj, koord = vector3(Config.Objekti2[i].x, Config.Objekti2[i].y, Config.Objekti2[i].z-1.7), blip = blip})
		end)
	end
	ESX.ShowNotification("Pokosite travu!")
	SetPedCanSwitchWeapon(PlayerPedId(), false)
	SetCurrentPedWeapon(PlayerPedId(),GetHashKey("WEAPON_UNARMED"),true)
	ResetPedMovementClipset(PlayerPedId())
	Citizen.CreateThread(function()
		while Kosilica ~= nil do
			Citizen.Wait(20)
			if JesiKosac() then
				local koord = GetEntityCoords(Kosilica)
				for i=1, #Objekti, 1 do
					if Objekti[i] ~= nil then
						if #(Objekti[i].koord-koord) <= 1.4 then
							ESX.Game.DeleteObject(Objekti[i].id)
							if DoesBlipExist(Objekti[i].blip) then
								RemoveBlip(Objekti[i].blip)
							end
							TriggerServerEvent("kosac:EoPlace2")
							table.remove(Objekti, i)
							if #Objekti == 0 then
								DeleteObject(Kosilica)
								Kosilica = nil
								ClearPedSecondaryTask(PlayerPedId())
								ESX.ShowNotification("Uspjesno zavrsen posao!")
							end
						end
					end
				end
			else
				ZavrsiPosao()
			end
		end
	end)
	Citizen.CreateThread(function()
		while Kosilica ~= nil do
			Citizen.Wait(1)
			DisableControlAction(0, 21, true)
			DisableControlAction(0, 22, true)
			DisableControlAction(0, 24, true)
			DisableControlAction(0, 25, true)
			DisableControlAction(0, 140, true)
			DisableControlAction(0, 141, true)
		end
	end)
end

function SpawnObjekte()
	for i=1, #Config.Objekti, 1 do
		ESX.Game.SpawnLocalObject('prop_veg_grass_02_a', {
				x = Config.Objekti[i].x,
				y = Config.Objekti[i].y,
				z = Config.Objekti[i].z+1.0
		}, function(obj)
			local blip = AddBlipForCoord(Config.Objekti[i].x,  Config.Objekti[i].y,  Config.Objekti[i].z)
			SetBlipSprite (blip, 1)
			SetBlipDisplay(blip, 8)
			SetBlipColour (blip, 2)
			SetBlipScale  (blip, 1.4)
			table.insert(Objekti, {id = obj, koord = vector3(Config.Objekti[i].x, Config.Objekti[i].y, Config.Objekti[i].z+1.0), blip = blip})
		end)
	end
	Broj = #Config.Objekti
	Spawno = true
	ESX.ShowNotification("Pokosite travu!")
	Citizen.CreateThread(function()
		while Vozilo ~= nil do
			Citizen.Wait(20)
			if JesiKosac() then
				if IsPedInAnyVehicle(PlayerPedId(), false) then
					local tablica = GetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(-1), false))
					if tablica == tablicaVozila then
						for i=1, #Objekti, 1 do
							if Objekti[i] ~= nil then
								if #(Objekti[i].koord-GetEntityCoords(PlayerPedId())) <= 2 then
									Wait(600)
									ESX.Game.DeleteObject(Objekti[i].id)
									if DoesBlipExist(Objekti[i].blip) then
										RemoveBlip(Objekti[i].blip)
									end
									TriggerServerEvent("kosac:EoPlace")
									table.remove(Objekti, i)
									if #Objekti == 0 then
										local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
										ESX.Game.DeleteVehicle(vehicle)
										ESX.ShowNotification("Uspjesno zavrsen posao!")
									end
								end
							end
						end
					end
				else
					ZavrsiPosao()
				end
			else
				ZavrsiPosao()
			end
		end
	end)
end

function JesiKosac()
	if ESX.PlayerData.posao ~= nil then
		local kosac = false
		if ESX.PlayerData.posao.name ~= nil and ESX.PlayerData.posao.name == 'kosac' then
			kosac = true
		end
		return kosac
	end
end

RegisterNUICallback(
    "zatvoriupit",
    function(data, cb)
		local br = data.br
		if br == 1 then
			TriggerServerEvent('esx_joblisting:setJob', 4)
			ESX.ShowNotification("Zaposlio si se kao kosac!")
		end
    end
)

AddEventHandler('esx_kosac:hasEnteredMarker', function(zone)
	if zone == 'CloakRoom' then
		MenuCloakRoom()
	end
	
	if zone == "posao" then
		TriggerEvent("upit:OtvoriPitanje", "esx_kosac", "Upit za posao", "Dali se zelite zaposliti kao kosac?")
	end

	if zone == 'VehicleSpawner' then
		if isInService and JesiKosac() and Radis == false then
			MenuVehicleSpawner()
		end
	end
	
	if zone == 'VehicleDeletePoint' or zone == "VehicleDeletePoint2" then
		if isInService and JesiKosac() then
			CurrentAction     = 'Obrisi'
            CurrentActionMsg  = "Pritisnite E da vratite vozilo!"
			--ZavrsiPosao()
		end
	end
end)

function ZavrsiPosao()
	Radis = false
	SetPlayerInvincible(PlayerId(), false)
	if Kosilica == nil then
		for i=1, #Objekti, 1 do
			if Objekti[i] ~= nil then
				ESX.Game.DeleteObject(Objekti[i].id)
				if DoesBlipExist(Objekti[i].blip) then
					RemoveBlip(Objekti[i].blip)
				end
			end
		end
		if Vozilo ~= nil then
			ESX.Game.DeleteVehicle(Vozilo)
			Vozilo = nil
		end
		Objekti = {}
	else
		for i=1, #Config.Objekti2, 1 do
			if Objekti[i] ~= nil then
				ESX.Game.DeleteObject(Objekti[i].id)
				if DoesBlipExist(Objekti[i].blip) then
					RemoveBlip(Objekti[i].blip)
				end
			end
		end
		Objekti = {}
		if Kosilica ~= nil then
			DeleteObject(Kosilica)
		end
		Kosilica = nil
		ClearPedSecondaryTask(PlayerPedId())
	end
end

AddEventHandler('esx_kosac:hasExitedMarker', function(zone)
	ESX.UI.Menu.CloseAll()    
    CurrentAction = nil
    CurrentActionMsg = ''
end)

function round(num, numDecimalPlaces)
    local mult = 5^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

-- DISPLAY MISSION MARKERS AND MARKERS
Citizen.CreateThread(function()
	local waitara = 1000
	while true do
		Citizen.Wait(waitara)
		local naso = 0
		local isInMarker  = false
		local currentZone = nil
		if JesiKosac() then
			local coords      = GetEntityCoords(GetPlayerPed(-1))

			if #Cpovi > 0 then
				for i=1, #Cpovi, 1 do
					if Cpovi[i] ~= nil then
						if #(coords-Cpovi[i].Koord) > 100 then
							if Cpovi[i].Spawnan then
								DeleteCheckpoint(Cpovi[i].ID)
								Cpovi[i].Spawnan = false
							end
						else
							if Cpovi[i].Spawnan == false then
								local kord = Cpovi[i].Koord
								local range = 2.0
								local check = CreateCheckpoint(47, kord.x, kord.y, kord.z, 0, 0, 0, range, Cpovi[i].r, Cpovi[i].g, Cpovi[i].b, 100)
								SetCheckpointCylinderHeight(check, range, range, range)
								Cpovi[i].ID = check
								Cpovi[i].Spawnan = true
							end
						end
					end
				end
				for i=1, #Cpovi, 1 do
					if Cpovi[i] ~= nil and Cpovi[i].Spawnan then
						if #(coords-Cpovi[i].Koord) < 1.5 then
							if Cpovi[i].Tip == 1 then
								isInMarker  = true
								currentZone = "CloakRoom"
								break
							elseif Cpovi[i].Tip == 2 then
								isInMarker  = true
								currentZone = "VehicleSpawner"
								break
							end
						end
					end
				end
			end
			
			if isInMarker and not hasAlreadyEnteredMarker then
				hasAlreadyEnteredMarker = true
				lastZone                = currentZone
				TriggerEvent('esx_kosac:hasEnteredMarker', currentZone)
			end

			if not isInMarker and hasAlreadyEnteredMarker then
				hasAlreadyEnteredMarker = false
				TriggerEvent('esx_kosac:hasExitedMarker', lastZone)
			end
		else
			--[[local coords = GetEntityCoords(GetPlayerPed(-1))
			if(Config.ZaposliSe.Type ~= -1 and #(coords-Config.ZaposliSe.Pos) < Config.DrawDistance) then
				waitara = 0
				naso = 1
				DrawMarker(Config.ZaposliSe.Type, Config.ZaposliSe.Pos, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.ZaposliSe.Size.x, Config.ZaposliSe.Size.y, Config.ZaposliSe.Size.z, Config.ZaposliSe.Color.r, Config.ZaposliSe.Color.g, Config.ZaposliSe.Color.b, 100, false, true, 2, false, false, false, false)
			end
			if #(coords-Config.ZaposliSe.Pos) < Config.ZaposliSe.Size.x then
				waitara = 0
				naso = 1
				isInMarker  = true
				currentZone = "posao"
			end
			if isInMarker and not hasAlreadyEnteredMarker then
				hasAlreadyEnteredMarker = true
				lastZone                = currentZone
				TriggerEvent('esx_kosac:hasEnteredMarker', currentZone)
			end

			if not isInMarker and hasAlreadyEnteredMarker then
				hasAlreadyEnteredMarker = false
				TriggerEvent('esx_kosac:hasExitedMarker', lastZone)
			end]]
		end
		if naso == 0 then
			waitara = 1000
		end
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setPosao')
AddEventHandler('esx:setPosao', function(job)
	ESX.PlayerData.posao = job
	SpawnCpove()
	SpawnNpcove()
	ZavrsiPosao()
end)