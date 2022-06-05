ESX = nil
local Objekti = {}
local Radis = false
local Vozilo = nil
local Vozilo2 = nil
local Oprema = false
local tablicaVozila = ""
local Blip = nil
local PosaoBlip = nil
local ograda = nil
local ograda2 = nil
local ograda3 = nil
local Broj = 0
local Cekic = nil
local DuznostPed = nil
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

function ProvjeriPosao()
	ESX.PlayerData = ESX.GetPlayerData()
	SpawnNpcove()
	refreshBlip()
end

function refreshBlip()
	if ESX.PlayerData.posao ~= nil then
		if PosaoBlip ~= nil then
			if DoesBlipExist(PosaoBlip) then
				RemoveBlip(PosaoBlip)
				PosaoBlip = nil
			end
		end
		--if ESX.PlayerData.posao.name == Config.Posao then
			PosaoBlip = AddBlipForCoord(Config.Oprema.Koord)
			SetBlipSprite  (PosaoBlip, 238)
			SetBlipDisplay (PosaoBlip, 4)
			SetBlipScale   (PosaoBlip, 1.2)
			SetBlipCategory(PosaoBlip, 3)
			SetBlipColour  (PosaoBlip, 5)
			SetBlipAsShortRange(PosaoBlip, true)

			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString("Farmer")
			EndTextCommandSetBlipName(PosaoBlip)
		--end
	end
end

function SpawnNpcove()
	if DuznostPed ~= nil then
		DeleteEntity(DuznostPed)
		exports.qtarget:RemoveZone('farmer_duznost')
		DuznostPed = nil
	end
	if VoziloPed ~= nil then
		DeleteEntity(VoziloPed)
		exports.qtarget:RemoveZone('farmer_vozila')
		VoziloPed = nil
	end
	if ESX.PlayerData.posao.name == Config.Posao then
		local pedmodel = GetHashKey("s_m_y_airworker")
		LoadModel(pedmodel)
		DuznostPed = CreatePed(0, pedmodel, Config.Oprema.Koord - vector3(0.0, 0.0, 1.0), Config.Oprema.Heading, false, true)
		SetEntityInvincible(DuznostPed, true)
		SetBlockingOfNonTemporaryEvents(DuznostPed, true)
		SetPedDiesWhenInjured(DuznostPed, false)
		SetPedFleeAttributes(DuznostPed, 2)
		FreezeEntityPosition(DuznostPed, true)
		SetPedCanPlayAmbientAnims(DuznostPed, false)
		SetPedCanRagdollFromPlayerImpact(DuznostPed, false)

		VoziloPed = CreatePed(0, pedmodel, Config.SpawnVozilaPed.Koord - vector3(0.0, 0.0, 1.0), Config.SpawnVozilaPed.Heading, false, true)
		SetEntityInvincible(VoziloPed, true)
		SetBlockingOfNonTemporaryEvents(VoziloPed, true)
		SetPedDiesWhenInjured(VoziloPed, false)
		SetPedFleeAttributes(VoziloPed, 2)
		FreezeEntityPosition(VoziloPed, true)
		SetPedCanPlayAmbientAnims(VoziloPed, false)
		SetPedCanRagdollFromPlayerImpact(VoziloPed, false)
		SetModelAsNoLongerNeeded(pedmodel)

		exports.qtarget:AddEntityZone("farmer", DuznostPed, 
		{
			name="farmer_duznost",
			debugPoly=false,
			useZ = true
		}, {
			options = {
				{
					event = "farmer:UzmiDuznost",
					icon = "far fa-comment",
					label = _U('radna_odjeca'),
					posao = Config.Posao
				},
				{
					event = "farmer:OstaviDuznost",
					icon = "fas fa-sign-out-alt",
					label = _U('civilna_odjeca'),
					posao = Config.Posao
				},
			},
			distance = 2.5
		})
		exports.qtarget:AddEntityZone("farmer2", VoziloPed, 
		{
			name="farmer_vozila",
			debugPoly=false,
			useZ = true
		}, {
			options = {
				{
					event = "farmer:Vozilo",
					icon = "fa fa-car",
					label = "Oranje njive",
					broj = 1,
					canInteract = function(entity) return Oprema end
				},
				{
					event = "farmer:Vozilo",
					icon = "fa fa-user",
					label = "Postavljanje ograde",
					broj = 2,
					canInteract = function(entity) return Oprema end
				},
			},
			distance = 2.5,
		})
	else
		local pedmodel = GetHashKey("s_m_y_airworker")
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

		exports.qtarget:AddEntityZone("farmer", DuznostPed, 
		{
			name="farmer_duznost",
			debugPoly=false,
			useZ = true
		}, {
			options = {
				{
					event = "farmer:ZaposliSe",
					icon = "far fa-comment",
					label = "Zaposlite se",
					posao ~= Config.Posao
				}
			},
			distance = 2.5
		})
	end
end

RegisterNetEvent('farmer:ZaposliSe')
AddEventHandler('farmer:ZaposliSe', function()
	TriggerEvent("upit:OtvoriPitanje", "esx_farmer", "Upit za posao", "Dali se zelite zaposliti kao farmer?")
end)

RegisterNUICallback(
    "zatvoriupit",
    function(data, cb)
		local br = data.br
		if br == 1 then
			TriggerServerEvent('esx_joblisting:setJob', 2)
			ESX.ShowNotification("Zaposlio si se kao farmer!")
		end
    end
)

RegisterNetEvent('farmer:Vozilo')
AddEventHandler('farmer:Vozilo', function(data)
	if data.broj == 1 then
		if Vozilo ~= nil then
			ESX.Game.DeleteVehicle(Vozilo)
			Vozilo = nil
		end
		if Vozilo2 ~= nil then
			ESX.Game.DeleteVehicle(Vozilo2)
			Vozilo2 = nil
		end
		ZavrsiPosao()
		local poz = nil
		for i=1, #Config.SpawnVozila.Koordinate, 1 do
			if ESX.Game.IsSpawnPointClear(Config.SpawnVozila.Koordinate[i].Koord, 5.0) then
				poz = i
				break
			end
		end
		if poz ~= nil then
			ESX.Streaming.RequestModel("tractor2")
			Vozilo = CreateVehicle("tractor2", Config.SpawnVozila.Koordinate[poz].Koord, Config.SpawnVozila.Koordinate[poz].Heading, true, false)
			randNum = math.random(10000, 99999)
			SetVehicleNumberPlateText(Vozilo, "REV"..randNum)             
			tablicaVozila = "REV"..randNum			
			TaskWarpPedIntoVehicle(GetPlayerPed(-1), Vozilo, -1)
			SetModelAsNoLongerNeeded("tractor2")
			ESX.Streaming.RequestModel("raketrailer")
			Vozilo2 = CreateVehicle("raketrailer", Config.SpawnVozila.Koordinate[poz].Koord, Config.SpawnVozila.Koordinate[poz].Heading, false, false)
			SetModelAsNoLongerNeeded("raketrailer")
			AttachVehicleToTrailer(Vozilo, Vozilo2, 1.1)
			Radis = true
			SpawnObjekte()
		else
			ESX.ShowNotification("Trenutno nema dostupnih traktora.")
		end
	elseif data.broj == 2 then
		DoScreenFadeOut(1000)
		while not IsScreenFadedOut() do
			Wait(100)
		end
		SetEntityCoords(PlayerPedId(), 2571.19, 4877.61, 36.49)
		SetEntityHeading(PlayerPedId(), 268.33)
		Wait(100)
		DoScreenFadeIn(1000)
		ESX.ShowNotification("Pritisnite tipku E da pocnete postavljati ogradu.", 5000)
		while not IsControlJustPressed(0, 38) do
			Wait(0)
		end
		ESX.Game.SpawnLocalObject('gr_prop_gr_hammer_01', {
			x = 2571.19,
			y = 4877.61,
			z = 36.49
		}, function(obj)
			Cekic = obj
			AttachEntityToEntity(
				Cekic, 
				PlayerPedId(), 
				GetPedBoneIndex(PlayerPedId(), 6286), 
				0.064, 
				0.098, 
				-0.05, 
				0.0, 
				0.0, 
				0.0, 
				true, 
				false, 
				false, 
				false, 
				1, 
				true
			)
		end)
		ESX.ShowNotification("Poceli ste s postavljanjem ograde.")
		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)
		local forward   = GetEntityForwardVector(playerPed)
		local x, y, z   = table.unpack(coords + forward * 0.8)
		Ograda(vector3(x,y,z), GetEntityHeading(playerPed))
	end
end)

function Ograda(cord, head)
	local hedara	= nil
	local endara = false
	ESX.ShowNotification("Sa strelicama lijevo i desno okrecete ogradu", 7000)
	ESX.ShowNotification("S lijevom tipkom misa postavljate ogradu i udarate stupove", 7000)
	ESX.ShowNotification("S tipkom X mozete zavrsiti posao", 7000)
	ESX.Game.SpawnLocalObject('prop_fncwood_08b', {
		x = cord.x,
		y = cord.y,
		z = cord.z
	}, function(obj)
		ograda2 = obj
		SetEntityHeading(obj, head)
		PlaceObjectOnGroundProperly(obj)
		local getara = GetEntityCoords(obj)
		SetEntityCoords(obj, getara.x, getara.y, getara.z-0.1)
		local kord = nil
		local kordara = nil
		local kordara2 = nil
		local moze = true
		while moze do
			Wait(1)
			DisableControlAction(0, 24, true)
			DisableControlAction(2, 37, true)
			DisableControlAction(0, 106, true)
			DisableControlAction(0, 167, true)
			DisableControlAction(0, 45, true)
			DisableControlAction(0, 140, true)
			DisableControlAction(0, 263, true)
			if IsControlPressed(0, 174) then
				local head = GetEntityHeading(obj)
				SetEntityHeading(obj, head-0.1)
			end
			if IsControlPressed(0, 175) then
				local head = GetEntityHeading(obj)
				SetEntityHeading(obj, head+0.1)
			end
			if IsControlJustPressed(0, 176) then
				kord = GetEntityCoords(obj)
				hedara = GetEntityHeading(obj)
				kordara = GetOffsetFromEntityInWorldCoords(obj, 2.1, 0.0, 0.0)
				kordara2 = kordara
				ESX.Game.DeleteObject(obj)
				ograda2 = nil
				if ograda == nil then
					ESX.Game.SpawnLocalObject('prop_fncwood_14a', {
						x = kord.x,
						y = kord.y,
						z = kord.z
					}, function(obj)
						ograda = obj
						PlaceObjectOnGroundProperly(obj)
						local getara = GetEntityCoords(obj)
						SetEntityCoords(obj, getara.x, getara.y, getara.z-0.1)
					end)
				end
				if ograda2 == nil then
					ESX.Game.SpawnLocalObject('prop_fncwood_14a', {
						x = kordara.x,
						y = kordara.y,
						z = kordara.z
					}, function(obj)
						ograda2 = obj
						PlaceObjectOnGroundProperly(obj)
						local getara = GetEntityCoords(obj)
						SetEntityCoords(obj, getara.x, getara.y, getara.z-0.1)
					end)
				end
				moze = false
			end
			if IsControlJustPressed(0, 73) then
				ESX.Game.DeleteObject(obj)
				ograda2 = nil
				endara = true
				moze = false
				DoScreenFadeOut(1000)
				while not IsScreenFadedOut() do
					Wait(100)
				end
				ZavrsiPosao()
				SetEntityCoords(PlayerPedId(), 2448.11, 5010.2, 46.6)
				SetEntityHeading(PlayerPedId(), 77.42)
				Wait(100)
				DoScreenFadeIn(1000)
			end
		end
		if not endara then
			moze = true
			while moze do
				Wait(1)
				DisableControlAction(0, 24, true)
				DisableControlAction(2, 37, true)
				DisableControlAction(0, 106, true)
				DisableControlAction(0, 167, true)
				DisableControlAction(0, 45, true)
				DisableControlAction(0, 140, true)
				DisableControlAction(0, 263, true)
				if kord ~= nil and ograda ~= nil then
					DrawMarker(0, kord, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 2.0, 1.0, 0, 0, 0, 100, false, true, 2, false, false, false, false)
					if #(GetEntityCoords(PlayerPedId())-kord) <= 1.0 then
						RequestAnimDict("melee@small_wpn@streamed_core")
						while not HasAnimDictLoaded("melee@small_wpn@streamed_core") do
							Citizen.Wait(100)
						end
						local moze2 = true
						local proso = true
						local br = 0
						while moze2 do
							Wait(1)
							DisableControlAction(0, 24, true)
							DisableControlAction(2, 37, true)
							DisableControlAction(0, 106, true)
							DisableControlAction(0, 167, true)
							DisableControlAction(0, 45, true)
							DisableControlAction(0, 140, true)
							DisableControlAction(0, 263, true)
							if IsDisabledControlJustPressed(0, 24) and proso then
								proso = false
								TaskPlayAnim(PlayerPedId(),"melee@small_wpn@streamed_core","car_down_attack", 8.0, -8, -1, 2, 0, 0, 0, 0)
								Wait(400)
								local corda = GetEntityCoords(ograda)
								SetEntityCoords(ograda, corda.x, corda.y, corda.z-0.02)
								Wait(300)
								proso = true
								br = br+1
								if br == 10 then
									moze2 = false
									kord = nil
								end
							end
						end
						ClearPedTasksImmediately(PlayerPedId())
						RemoveAnimDict("melee@small_wpn@streamed_core")
					end
				end
				if kordara ~= nil and ograda2 ~= nil then
					DrawMarker(0, kordara, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 2.0, 1.0, 0, 0, 0, 100, false, true, 2, false, false, false, false)
					if #(GetEntityCoords(PlayerPedId())-kordara) <= 1.0 then
						RequestAnimDict("melee@small_wpn@streamed_core")
						while not HasAnimDictLoaded("melee@small_wpn@streamed_core") do
							Citizen.Wait(100)
						end
						local moze2 = true
						local proso = true
						local br = 0
						while moze2 do
							Wait(1)
							DisableControlAction(0, 24, true)
							DisableControlAction(2, 37, true)
							DisableControlAction(0, 106, true)
							DisableControlAction(0, 167, true)
							DisableControlAction(0, 45, true)
							DisableControlAction(0, 140, true)
							DisableControlAction(0, 263, true)
							if IsDisabledControlJustPressed(0, 24) and proso then
								proso = false
								TaskPlayAnim(PlayerPedId(),"melee@small_wpn@streamed_core","car_down_attack", 8.0, -8, -1, 2, 0, 0, 0, 0)
								Wait(400)
								local corda = GetEntityCoords(ograda2)
								SetEntityCoords(ograda2, corda.x, corda.y, corda.z-0.02)
								Wait(300)
								proso = true
								br = br+1
								if br == 10 then
									moze2 = false
									kordara = nil
								end
							end
						end
						ClearPedTasksImmediately(PlayerPedId())
						RemoveAnimDict("melee@small_wpn@streamed_core")
					end
				end
				if kord == nil and kordara == nil then
					ESX.Game.DeleteObject(ograda)
					ograda = nil
					ESX.Game.DeleteObject(ograda2)
					ograda2 = nil
					ESX.Game.SpawnLocalObject('prop_fncwood_08b', {
						x = cord.x,
						y = cord.y,
						z = cord.z
					}, function(obj)
						PlaceObjectOnGroundProperly(obj)
						local getara = GetEntityCoords(obj)
						SetEntityCoords(obj, getara.x, getara.y, getara.z-0.5)
						table.insert(Objekti, {id = obj})
						ograda = obj
						SetEntityHeading(obj, hedara)
					end)
					TriggerServerEvent("farmer:EoPlace2")
					TriggerServerEvent("biznis:DodajTuru", ESX.PlayerData.posao.name)
					Broj = Broj+1
					moze = false
				end
			end
			while ograda == nil do
				Wait(1)
			end
			if Broj > 5 then
				ESX.ShowNotification("Zavrsili ste postavljanje ograde.")
				DoScreenFadeOut(1000)
				while not IsScreenFadedOut() do
					Wait(100)
				end
				ZavrsiPosao()
				SetEntityCoords(PlayerPedId(), 2448.11, 5010.2, 46.6)
				SetEntityHeading(PlayerPedId(), 77.42)
				Wait(100)
				DoScreenFadeIn(1000)
			else
				local kordo = GetOffsetFromEntityInWorldCoords(ograda, 2.1, 0.0, 0.0)
				Ograda(kordo, GetEntityHeading(ograda))
				ograda = nil
			end
		end
	end)
end

RegisterNetEvent('farmer:UzmiDuznost')
AddEventHandler('farmer:UzmiDuznost', function()
	if Vozilo ~= nil then
		ESX.Game.DeleteVehicle(Vozilo)
		Vozilo = nil
	end
	if Vozilo2 ~= nil then
		ESX.Game.DeleteVehicle(Vozilo2)
		Vozilo2 = nil
	end
	ZavrsiPosao()
	Oprema = true
	postaviUniformu(PlayerPedId())
end)

LoadModel = function(model)
	RequestModel(model)

	while not HasModelLoaded(model) do
		Wait(10)
	end
end

RegisterNetEvent('farmer:OstaviDuznost')
AddEventHandler('farmer:OstaviDuznost', function()
	if Vozilo ~= nil then
		ESX.Game.DeleteVehicle(Vozilo)
		Vozilo = nil
	end
	if Vozilo2 ~= nil then
		ESX.Game.DeleteVehicle(Vozilo2)
		Vozilo2 = nil
	end
	ZavrsiPosao()
	Oprema = false
	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
		TriggerEvent('skinchanger:loadSkin', skin)
	end)
end)

function postaviUniformu(playerPed)
	TriggerEvent('skinchanger:getSkin', function(skin)
		if skin.sex == 0 then
			if Config.Uniforme.male then
				TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforme.male)
			else
				ESX.ShowNotification("Nema postavljene uniforme!")
			end
		else
			if Config.Uniforme.female then
				TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforme.female)
			else
				ESX.ShowNotification("Nema postavljene uniforme!")
			end
		end
	end)
end

function SpawnObjekte()
		local njiva = math.random(4)
		if njiva == 1 then
			for i=1, #Config.Objekti, 1 do
				ESX.Game.SpawnLocalObject('prop_grass_dry_02', {
						x = Config.Objekti[i].x,
						y = Config.Objekti[i].y,
						z = Config.Objekti[i].z
				}, function(obj)
					local blip = AddBlipForCoord(Config.Objekti[i].x,  Config.Objekti[i].y,  Config.Objekti[i].z)
					SetBlipSprite (blip, 1)
					SetBlipDisplay(blip, 8)
					SetBlipColour (blip, 2)
					SetBlipScale  (blip, 1.4)
					table.insert(Objekti, {id = obj, koord = vector3(Config.Objekti[i].x, Config.Objekti[i].y, Config.Objekti[i].z), blip = blip})
				end)
			end
		elseif njiva == 2 then
			for i=1, #Config.Objekti2, 1 do
				ESX.Game.SpawnLocalObject('prop_grass_dry_02', {
						x = Config.Objekti2[i].x,
						y = Config.Objekti2[i].y,
						z = Config.Objekti2[i].z
				}, function(obj)
					local blip = AddBlipForCoord(Config.Objekti2[i].x,  Config.Objekti2[i].y,  Config.Objekti2[i].z)
					SetBlipSprite (blip, 1)
					SetBlipDisplay(blip, 8)
					SetBlipColour (blip, 2)
					SetBlipScale  (blip, 1.4)
					table.insert(Objekti, {id = obj, koord = vector3(Config.Objekti2[i].x, Config.Objekti2[i].y, Config.Objekti2[i].z), blip = blip})
				end)
			end
		elseif njiva == 3 then
			for i=1, #Config.Objekti3, 1 do
				ESX.Game.SpawnLocalObject('prop_grass_dry_02', {
						x = Config.Objekti3[i].x,
						y = Config.Objekti3[i].y,
						z = Config.Objekti3[i].z
				}, function(obj)
					local blip = AddBlipForCoord(Config.Objekti3[i].x,  Config.Objekti3[i].y,  Config.Objekti3[i].z)
					SetBlipSprite (blip, 1)
					SetBlipDisplay(blip, 8)
					SetBlipColour (blip, 2)
					SetBlipScale  (blip, 1.4)
					table.insert(Objekti, {id = obj, koord = vector3(Config.Objekti3[i].x, Config.Objekti3[i].y, Config.Objekti3[i].z), blip = blip})
				end)
			end
		elseif njiva == 4 then
			for i=1, #Config.Objekti4, 1 do
				ESX.Game.SpawnLocalObject('prop_grass_dry_02', {
						x = Config.Objekti4[i].x,
						y = Config.Objekti4[i].y,
						z = Config.Objekti4[i].z
				}, function(obj)
					local blip = AddBlipForCoord(Config.Objekti4[i].x,  Config.Objekti4[i].y,  Config.Objekti4[i].z)
					SetBlipSprite (blip, 1)
					SetBlipDisplay(blip, 8)
					SetBlipColour (blip, 2)
					SetBlipScale  (blip, 1.4)
					table.insert(Objekti, {id = obj, koord = vector3(Config.Objekti4[i].x, Config.Objekti4[i].y, Config.Objekti4[i].z), blip = blip})
				end)
			end
		end
		Citizen.CreateThread(function()
			while Radis do
				Citizen.Wait(20)
				if jelFarmer() then
					if IsPedInAnyVehicle(PlayerPedId(), false) then
						for i=1, #Objekti, 1 do
							if Objekti[i] ~= nil then
								if #(Objekti[i].koord-GetEntityCoords(Vozilo2)) <= 2 then
									Citizen.Wait(600)
									ESX.Game.DeleteObject(Objekti[i].id)
									if DoesBlipExist(Objekti[i].blip) then
										RemoveBlip(Objekti[i].blip)
									end
									TriggerServerEvent("farmer:EoPlace")
									TriggerServerEvent("biznis:DodajTuru", ESX.PlayerData.posao.name)
									table.remove(Objekti, i)
									if #Objekti == 0 then
										if DoesBlipExist(Blip) then
											RemoveBlip(Blip)
										end
										Blip = AddBlipForCoord(Config.VracanjeVozila.x, Config.VracanjeVozila.y, Config.VracanjeVozila.z)
										SetBlipSprite(Blip, 1)
										SetBlipColour (Blip, 5)
										SetBlipAlpha(Blip, 255)
										SetBlipRoute(Blip,  true)
										ESX.ShowNotification("Vratite traktor na oznaceno mjesto kako bih ste zavrsili s poslom!")
										local vratio = false
										while not vratio do
											DrawMarker(1, Config.VracanjeVozila, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 3.0, 3.0, 1.0, 255, 0, 0, 100, false, true, 2, false, false, false, false)
											if #(Config.VracanjeVozila-GetEntityCoords(PlayerPedId())) <= 2 then
												ZavrsiPosao()
												vratio = true
											end
											Citizen.Wait(1)
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
		ESX.ShowNotification("Preorite njivu!")
end

function jelFarmer()
	if ESX.PlayerData.posao ~= nil then
		local kosac = false
		if ESX.PlayerData.posao.name ~= nil and ESX.PlayerData.posao.name == Config.Posao then
			kosac = true
		end
		return kosac
	end
end

function ZavrsiPosao()
	for i=1, #Objekti, 1 do
		if Objekti[i] ~= nil then
			ESX.Game.DeleteObject(Objekti[i].id)
			if Objekti[i].blip ~= nil then
				if DoesBlipExist(Objekti[i].blip) then
					RemoveBlip(Objekti[i].blip)
				end
			end
		end
	end
	if DoesBlipExist(Blip) then
		RemoveBlip(Blip)
	end
	if Vozilo ~= nil then
		ESX.Game.DeleteVehicle(Vozilo)
	end
	if Vozilo2 ~= nil then
		ESX.Game.DeleteVehicle(Vozilo2)
	end
	if Cekic ~= nil then
		DeleteObject(Cekic)
		Cekic = nil
	end
	Objekti = {}
	Vozilo = nil
	Vozilo2 = nil
	Radis = false
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setPosao')
AddEventHandler('esx:setPosao', function(job)
	ESX.PlayerData.posao = job
	--refreshBlip()
	ZavrsiPosao()
	SpawnNpcove()
end)