--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- ORIGINAL SCRIPT BY Marcio FOR CFX-ESX
-- Script serveur No Brain 
-- www.nobrain.org
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
ESX = nil
local Pedovi = {}
local Spawno = false
local Broj = 0
local Posao = 0
local Prikazo = 0
local Blip
local Objekti = {}
local Blipara				  = {}
local Radis = false
local Odradio = 1
local DuznostPed              = nil
local VoziloPed 			  = nil
local Ralica = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while ESX.GetPlayerData().posao == nil do
		Citizen.Wait(100)
	end
	ProvjeriPosao()
	SpawnNpcove()
	DodajBlip()
end)
--------------------------------------------------------------------------------
-- NE RIEN MODIFIER
--------------------------------------------------------------------------------
local isInService = false
local hasAlreadyEnteredMarker = false
local lastZone                = nil
local Blips                   = {}

local plaquevehicule = ""
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}
local Blipara				  = {}
--------------------------------------------------------------------------------
function ProvjeriPosao()
	ESX.PlayerData = ESX.GetPlayerData()
end

function DodajBlip()
	local blip = AddBlipForCoord(Config.Oprema.Koord.x, Config.Oprema.Koord.y, Config.Oprema.Koord.z)
	SetBlipSprite  (blip, 477)
	SetBlipDisplay (blip, 4)
	SetBlipScale   (blip, 0.8)
	SetBlipCategory(blip, 3)
	SetBlipColour  (blip, 0)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Cistac snijega")
	EndTextCommandSetBlipName(blip)
end

LoadModel = function(model)
	RequestModel(model)

	while not HasModelLoaded(model) do
		Wait(10)
	end
end

function SpawnNpcove()
	if DuznostPed ~= nil then
		DeleteEntity(DuznostPed)
		exports.qtarget:RemoveZone('ralica_duznost')
		DuznostPed = nil
	end
	if ESX.PlayerData.posao.name == Config.Posao then
		local pedmodel = GetHashKey("s_m_m_dockwork_01")
		LoadModel(pedmodel)
		DuznostPed = CreatePed(0, pedmodel, Config.Oprema.Koord - vector3(0.0, 0.0, 1.0), Config.Oprema.Heading, false, true)
		SetEntityInvincible(DuznostPed, true)
		SetBlockingOfNonTemporaryEvents(DuznostPed, true)
		SetPedDiesWhenInjured(DuznostPed, false)
		SetPedFleeAttributes(DuznostPed, 2)
		FreezeEntityPosition(DuznostPed, true)
		SetPedCanPlayAmbientAnims(DuznostPed, false)
		SetPedCanRagdollFromPlayerImpact(DuznostPed, false)
		SetModelAsNoLongerNeeded(pedmodel)

		exports.qtarget:AddEntityZone("ralica", DuznostPed, 
		{
			name="ralica_duznost",
			debugPoly=false,
			useZ = true
		}, {
			options = {
				{
					event = "ralica:UzmiDuznost",
					icon = "far fa-comment",
					label = _U('radna_odjeca'),
					posao = Config.Posao
				},
				{
					event = "ralica:OstaviDuznost",
					icon = "fas fa-sign-out-alt",
					label = _U('civilna_odjeca'),
					posao = Config.Posao
				},
			},
			distance = 2.5
		})
	else
		local pedmodel = GetHashKey("s_m_m_dockwork_01")
		LoadModel(pedmodel)
		DuznostPed = CreatePed(0, pedmodel, Config.Oprema.Koord - vector3(0.0, 0.0, 1.0), Config.Oprema.Heading, false, true)
		SetEntityInvincible(DuznostPed, true)
		SetBlockingOfNonTemporaryEvents(DuznostPed, true)
		SetPedDiesWhenInjured(DuznostPed, false)
		SetPedFleeAttributes(DuznostPed, 2)
		FreezeEntityPosition(DuznostPed, true)
		SetPedCanPlayAmbientAnims(DuznostPed, false)
		SetPedCanRagdollFromPlayerImpact(DuznostPed, false)
		SetModelAsNoLongerNeeded(pedmodel)

		exports.qtarget:AddEntityZone("ralica", DuznostPed, 
		{
			name="ralica_duznost",
			debugPoly=false,
			useZ = true
		}, {
			options = {
				{
					event = "ralica:ZaposliSe",
					icon = "far fa-comment",
					label = "Zaposlite se",
					posao ~= Config.Posao
				}
			},
			distance = 2.5
		})
	end
end

RegisterNetEvent('ralica:ZaposliSe')
AddEventHandler('ralica:ZaposliSe', function()
	TriggerEvent("upit:OtvoriPitanje", "esx_ralica", "Upit za posao", "Dali se zelite zaposliti kao cistac snijega?")
end)

RegisterNUICallback(
    "zatvoriupit",
    function(data, cb)
		local br = data.br
		if br == 1 then
			TriggerServerEvent('esx_joblisting:setJob', 7)
			ESX.ShowNotification("Zaposlio si se kao cistac snijega!")
		end
    end
)

RegisterNetEvent('ralica:UzmiDuznost')
AddEventHandler('ralica:UzmiDuznost', function()
	if not isInService then
		isInService = true
		setUniform(PlayerPedId())
		if VoziloPed ~= nil then
			DeleteEntity(VoziloPed)
			exports.qtarget:RemoveZone('ralica_vozila')
			VoziloPed = nil
		end
		local pedmodel = GetHashKey("s_m_y_dockwork_01")
		LoadModel(pedmodel)
		VoziloPed = CreatePed(0, pedmodel, Config.SpawnVozilaPed.Koord - vector3(0.0, 0.0, 1.0), Config.SpawnVozilaPed.Heading, false, true)
		SetEntityInvincible(VoziloPed, true)
		SetBlockingOfNonTemporaryEvents(VoziloPed, true)
		SetPedDiesWhenInjured(VoziloPed, false)
		SetPedFleeAttributes(VoziloPed, 2)
		FreezeEntityPosition(VoziloPed, true)
		SetPedCanPlayAmbientAnims(VoziloPed, false)
		SetPedCanRagdollFromPlayerImpact(VoziloPed, false)
		SetModelAsNoLongerNeeded(pedmodel)

		exports.qtarget:AddEntityZone("ralica2", VoziloPed, 
		{
			name="ralica_vozila",
			debugPoly=false,
			useZ = true
		}, {
			options = {
				{
					event = "ralica:Vozilo",
					icon = "fa fa-car",
					label = "Ciscenje snijega",
					broj = 1,
					canInteract = function(entity) return isInService end
				}
			},
			distance = 2.5,
		})
	end
end)

RegisterNetEvent('ralica:Vozilo')
AddEventHandler('ralica:Vozilo', function(data)
	if data.broj == 1 then
		if not Radis then
			local model = GetHashKey("biff")
			ESX.Game.SpawnVehicle(model, Config.Zones.VehicleSpawnPoint.Pos, 53.884044647217, function(vehicle)
				Ralica = vehicle
				platenum = math.random(10000, 99999)
				SetVehicleNumberPlateText(vehicle, "HUG"..platenum)
				plaquevehicule = "HUG"..platenum
				TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)   
				SetModelAsNoLongerNeeded(model)
			end)
			PokreniPosao()
			Radis = true
		end
	end
end)

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
				SetModelAsNoLongerNeeded(outfit.ped)
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
				SetModelAsNoLongerNeeded(outfit.ped)
			end
		end
	end)
end

RegisterNetEvent('ralica:OstaviDuznost')
AddEventHandler('ralica:OstaviDuznost', function()
	if isInService then
		isInService = false
		ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
			TriggerEvent('skinchanger:loadSkin', skin)
		end)
		ZavrsiPosao()
		if VoziloPed ~= nil then
			DeleteEntity(VoziloPed)
			exports.qtarget:RemoveZone('ralica_vozila')
			VoziloPed = nil
		end
	end
end)

function PokreniPosao()
	TriggerServerEvent("ralica:ZapoceoPosao", true)
	for i=1, #Config.Objekti, 1 do
		ESX.Game.SpawnLocalObject('prop_snow_bush_02_a', {
			x = Config.Objekti[i].x,
			y = Config.Objekti[i].y,
			z = Config.Objekti[i].z-1.6
		}, function(obj)
			--PlaceObjectOnGroundProperly(obj)
			Objekti[i] = obj
			FreezeEntityPosition(Objekti[i], true)
		end)
		Blipara[i] = AddBlipForCoord(Config.Objekti[i].x,  Config.Objekti[i].y,  Config.Objekti[i].z)
		SetBlipSprite (Blipara[i], 1)
		SetBlipDisplay(Blipara[i], 8)
		SetBlipColour (Blipara[i], 2)
		SetBlipScale  (Blipara[i], 1.0)
		SetBlipAsShortRange(Blipara[i], true)
	end
	Broj = #Config.Objekti
	Spawno = true
	Posao = 1
	ESX.ShowNotification("Ocistite cestu!")
	SetBlipRoute(Blipara[1],  true)
	-- DISPLAY MISSION MARKERS AND MARKERS
	Citizen.CreateThread(function()
		local waitara = 500
		while Spawno do
			Citizen.Wait(waitara)
			local naso = 0
			if CurrentAction ~= nil then
				waitara = 0
				naso = 1
				SetTextComponentFormat('STRING')
				AddTextComponentString(CurrentActionMsg)
				DisplayHelpTextFromStringLabel(0, 0, 1, -1)
				if DoesBlipExist(Blip) then
					RemoveBlip(Blip)
				end
				if IsControlJustReleased(0, 38) and IsJobRalica() then
					if CurrentAction == 'Obrisi' then
						ZavrsiPosao()
					end
					CurrentAction = nil
				end
			end

			local coords = GetEntityCoords(GetPlayerPed(-1))
			
			local isInMarker  = false
			local currentZone = nil

			for k,v in pairs(Config.Zones) do
				if(#(coords-v.Pos) < v.Size.x) then
					waitara = 0
					naso = 1
					isInMarker  = true
					currentZone = k
				end
			end
			
			if isInMarker and not hasAlreadyEnteredMarker then
				hasAlreadyEnteredMarker = true
				lastZone                = currentZone
				TriggerEvent('esx_ralica:hasEnteredMarker', currentZone)
			end

			if not isInMarker and hasAlreadyEnteredMarker then
				hasAlreadyEnteredMarker = false
				TriggerEvent('esx_ralica:hasExitedMarker', lastZone)
			end
			
			for k,v in pairs(Config.Zones) do

				if isInService and (IsJobRalica() and v.Type ~= -1 and #(coords-v.Pos) < Config.DrawDistance) then
					waitara = 0
					naso = 1
					DrawMarker(v.Type, v.Pos, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
				end

			end

			if naso == 0 then
				waitara = 500
			end
		end
	end)
	-- Key Controls
	Citizen.CreateThread(function()
		while Spawno do
			Citizen.Wait(20)
			if Spawno == true and Broj > 0 then
				local tablica = GetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(-1), false))
				if tablica == plaquevehicule then
					local kord = GetEntityCoords(PlayerPedId())
					if #(kord-Config.Objekti[Odradio]) <= 10 then
						ESX.Game.DeleteObject(Objekti[Odradio])
						if DoesBlipExist(Blipara[Odradio]) then
							RemoveBlip(Blipara[Odradio])
						end
						Broj = Broj-1
						TriggerServerEvent("esx_ralica:platiTuljanu")
						TriggerServerEvent("biznis:DodajTuru", ESX.PlayerData.posao.name)
						if Broj == 0 then
							--local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
							--ESX.Game.DeleteVehicle(vehicle)
							for k,v in pairs(Config.Zones) do
								if k == "VehicleDeletePoint" then
									--SetNewWaypoint(v.Pos.x, v.Pos.y)
									if DoesBlipExist(Blip) then
										RemoveBlip(Blip)
									end
									Blip = AddBlipForCoord(v.Pos)
									SetBlipSprite(Blip, 1)
									SetBlipColour (Blip, 5)
									SetBlipAlpha(Blip, 255)
									SetBlipRoute(Blip,  true) -- waypoint to blip
								end
							end
							Spawno = false
							Radis = false
							TriggerServerEvent("ralica:ZapoceoPosao", false)
							Broj = 0
							Odradio = 1
							ESX.ShowNotification("Uspjesno zavrsen posao, vratite kamion do firme!")
						else
							Odradio = Odradio+1
							SetBlipRoute(Blipara[Odradio],  true)
						end
					end
				end
			end
		end
	end)
end

function IsATruck()
	local isATruck = false
	local playerPed = GetPlayerPed(-1)
	for i=1, #Config.Trucks, 1 do
		if IsVehicleModel(GetVehiclePedIsUsing(playerPed), Config.Trucks[i]) then
			isATruck = true
			break
		end
	end
	return isATruck
end

function IsJobRalica()
	if ESX.PlayerData ~= nil then
		local ralica = false
		if ESX.PlayerData.posao.name ~= nil and ESX.PlayerData.posao.name == 'ralica' then
			ralica = true
		end
		return ralica
	end
end

AddEventHandler('esx_ralica:hasEnteredMarker', function(zone)
	if zone == 'VehicleDeletePoint' then
		if isInService and IsJobRalica() then
			CurrentAction     = 'Obrisi'
            CurrentActionMsg  = "Pritisnite E da vratite vozilo!"
		end
	end
end)

function ZavrsiPosao()
	TriggerServerEvent("ralica:ZapoceoPosao", false)
	for i=1, #Config.Objekti, 1 do
		if Objekti[i] ~= nil then
			ESX.Game.DeleteObject(Objekti[i])
			if DoesBlipExist(Blipara[i]) then
				RemoveBlip(Blipara[i])
			end
		end
	end
	Broj = 0
	if Ralica ~= nil then
		ESX.Game.DeleteVehicle(Ralica)
	end
	Spawno = false
	Radis = false
	Odradio = 1
end

AddEventHandler('esx_ralica:hasExitedMarker', function(zone)
	ESX.UI.Menu.CloseAll()    
    CurrentAction = nil
    CurrentActionMsg = ''
end)

-------------------------------------------------
-- Fonctions
-------------------------------------------------
-- Fonction selection nouvelle mission livraison
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