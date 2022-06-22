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
local PosaoPed = nil
local VoziloPed = nil

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
	else
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
					event = "kosac:UzmiDuznost",
					icon = "far fa-comment",
					label = _U('job_wear'),
					posao = Config.Posao
				},
				{
					event = "kosac:OstaviDuznost",
					icon = "fas fa-sign-out-alt",
					label = _U('citizen_wear'),
					posao = Config.Posao
				},
			},
			distance = 2.5
		})
		SetModelAsNoLongerNeeded(pedmodel)
	end
end

RegisterNetEvent('kosac:UzmiDuznost')
AddEventHandler('kosac:UzmiDuznost', function()
	if not isInService then
		isInService = true
		setUniform(PlayerPedId())
		if VoziloPed ~= nil then
			DeleteEntity(VoziloPed)
			exports.qtarget:RemoveZone('kosac_vozila')
			VoziloPed = nil
		end
		local pedmodel = GetHashKey("s_m_m_gardener_01")
		VoziloPed = CreatePed(0, pedmodel, Config.Zones.VehicleSpawner.Pos, Config.Zones.VehicleSpawner.Heading, false, true)
		SetEntityInvincible(VoziloPed, true)
		SetBlockingOfNonTemporaryEvents(VoziloPed, true)
		SetPedDiesWhenInjured(VoziloPed, false)
		SetPedFleeAttributes(VoziloPed, 2)
		FreezeEntityPosition(VoziloPed, true)
		SetPedCanPlayAmbientAnims(VoziloPed, false)
		SetPedCanRagdollFromPlayerImpact(VoziloPed, false)
		SetModelAsNoLongerNeeded(pedmodel)
	
		exports.qtarget:AddEntityZone("kosac2", VoziloPed, 
		{
			name="kosac_vozila",
			debugPoly=false,
			useZ = true
		}, {
			options = {
				{
					event = "kosac:Vozilo",
					icon = "fa fa-car",
					label = "Mower",
					broj = 1,
					canInteract = function(entity) return isInService end
				},
				{
					event = "kosac:Vozilo",
					icon = "fa fa-user",
					label = "Obicna kosilica",
					broj = 2,
					canInteract = function(entity) return isInService end
				},
			},
			distance = 2.5,
		})
	end
end)

RegisterNetEvent('kosac:Vozilo')
AddEventHandler('kosac:Vozilo', function(data)
	if data.broj == 1 then
		if Vozilo ~= nil then
			ESX.Game.DeleteVehicle(Vozilo)
			Vozilo = nil
		end
		ESX.Streaming.RequestModel("mower")
		Vozilo = CreateVehicle("mower", Config.Zones.VehicleSpawnPoint.Pos.x, Config.Zones.VehicleSpawnPoint.Pos.y, Config.Zones.VehicleSpawnPoint.Pos.z, 315.28479003906, true, false)
		platenum = math.random(10000, 99999)
		SetModelAsNoLongerNeeded("mower")
		SetVehicleNumberPlateText(Vozilo, "WAL"..platenum)             
		tablicaVozila = "WAL"..platenum			
		TaskWarpPedIntoVehicle(GetPlayerPed(-1), Vozilo, -1)
		Radis = true
		TriggerEvent("dpemotes:Radim", true)
		SpawnObjekte()
	elseif data.broj == 2 then
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
end)

RegisterNetEvent('kosac:OstaviDuznost')
AddEventHandler('kosac:OstaviDuznost', function()
	if isInService then
		isInService = false
		ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
			TriggerEvent('skinchanger:loadSkin', skin)
		end)
		TriggerEvent("dpemotes:Radim", false)
		if VoziloPed ~= nil then
			DeleteEntity(VoziloPed)
			exports.qtarget:RemoveZone('kosac_vozila')
			VoziloPed = nil
		end
	end
end)

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
					ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
						TriggerEvent('skinchanger:loadSkin', skin)
					end)
					TriggerEvent("dpemotes:Radim", false)
				end
			end
			if data.current.value == 'job_wear' then
				if not isInService then
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
							TriggerServerEvent("biznis:DodajTuru", ESX.PlayerData.posao.name)
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
									TriggerServerEvent("biznis:DodajTuru", ESX.PlayerData.posao.name)
									table.remove(Objekti, i)
									if #Objekti == 0 then
										--local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
										--ESX.Game.DeleteVehicle(vehicle)
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

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setPosao')
AddEventHandler('esx:setPosao', function(job)
	ESX.PlayerData.posao = job
	SpawnNpcove()
	ZavrsiPosao()
end)