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

ESX =					nil
local Vehicles =		{}
local PlayerData		= {}
local lsMenuIsShowed	= false
local isInLSMarker		= false
local isInLSMarker2		= false
local myCar				= {}
local Narudzba 			= {}
local TrenutniTune      = nil
local prop_ent = nil
local prop_ent2 = nil
local prop_ent3 = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	ProvjeriPosao()
end)

function ProvjeriPosao()
	PlayerData = ESX.GetPlayerData()
	ESX.TriggerServerCallback('esx_lscustom:getVehiclesPrices', function(vehicles)
		Vehicles = vehicles
	end)
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
	ESX.TriggerServerCallback('esx_lscustom:getVehiclesPrices', function(vehicles)
		Vehicles = vehicles
	end)
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

RegisterNetEvent('esx_lscustom:installMod')
AddEventHandler('esx_lscustom:installMod', function()
	local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
	myCar = ESX.Game.GetVehicleProperties(vehicle)
	TriggerServerEvent('esx_lscustom:refreshOwnedVehicle', myCar)
end)

RegisterNetEvent('stage:Provjera')
AddEventHandler('stage:Provjera', function(currentSeat)
	local globalplate  = ESX.Math.Trim(GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId(), false)))
	if currentSeat == -1 then
		if globalplate ~= nil or globalplate ~= "" or globalplate ~= " " then
			ESX.TriggerServerCallback('stage:ProvjeriVozilo',function(st)
				local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
				SetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fInitialDragCoeff', gDragCoef) --stage 0 -10.0
				SetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fInitialDriveMaxFlatVel', gFlatVel)
				print(GetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fInitialDragCoeff'))
				local DragCoef = GetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fInitialDragCoeff')
				local FlatVel = GetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fInitialDriveMaxFlatVel')
				local drag = 8
				local speed = 0.4
				print(st.stage)
				if st.stage == 1 then
					drag = 8-2
					speed = 0.3
				elseif st.stage == 2 then
					drag = 8-4
					speed = 0.2
				elseif st.stage == 3 then
					drag = 8-6
					speed = 0.1
				elseif st.stage == 4 then
					drag = 0
					speed = 0.0
				end
				local br = DragCoef+drag
				local br2 = FlatVel-(FlatVel*speed)
				SetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fInitialDragCoeff', br) --stage 0 -10.0
				SetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fInitialDriveMaxFlatVel', br2)
				ModifyVehicleTopSpeed(vehicle, 16.11)
				if st.motor ~= nil then
					DragCoef = GetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fInitialDragCoeff')
					FlatVel = GetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fInitialDriveMaxFlatVel')
					if DragCoef >= 20.0 then
						drag = DragCoef*0.7
						speed = 1.4
					end
					if DragCoef < 20.0 and DragCoef > 10.0 then
						drag = DragCoef*0.3
						speed = 0.4
					end
					if DragCoef <= 10.0 and DragCoef > 6.0 then
						drag = DragCoef*0.1
						speed = 0.1
					end
					if DragCoef <= 6.0 then
						drag = DragCoef*0.02
						speed = 0.02
					end
					br = DragCoef-drag
					br2 = FlatVel+(FlatVel*speed)
					SetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fInitialDragCoeff', br)
					SetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fInitialDriveMaxFlatVel', br2)
					ModifyVehicleTopSpeed(vehicle, 16.11)
				end
				print(GetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fInitialDragCoeff'))
			end, globalplate)
		end
	end
end)

RegisterNetEvent('esx_lscustom:cancelInstallMod')
AddEventHandler('esx_lscustom:cancelInstallMod', function()
	local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
	if (GetPedInVehicleSeat(vehicle, -1) ~= PlayerPedId()) then
		vehicle = GetPlayersLastVehicle(PlayerPedId())
	end
	ESX.Game.SetVehicleProperties(vehicle, myCar)
	if not (myCar.modTurbo) then
		ToggleVehicleMod(vehicle,  18, false)
	end
	if not (myCar.modXenon) then
		ToggleVehicleMod(vehicle,  22, false)
	end
	if not (myCar.windowTint) then
		SetVehicleWindowTint(vehicle, 0)
	end
end)

function OpenLSMenu(elems, menuName, menuTitle, parent)
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), menuName,
	{
		title    = menuTitle,
		align    = 'top-left',
		elements = elems
	}, function(data, menu)
		local isRimMod, found, isMjenjac, isSvijetla, isDodaci, isSwap, isStage, isZracni = false, false, false, false, false, false, false, false
		local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
		local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
		local tablica = vehicleProps.plate
		local price = 0

		if data.current.modType == "modFrontWheels" then
			isRimMod = true
		end
		
		if data.current.modType == "mjenjac" then
			isMjenjac = true
		end
		
		if data.current.modType == "swap" then
			isSwap = true
		end

		if data.current.modType == "zracni" then
			isZracni = true
		end

		if data.current.modType == "stage" then
			isStage = true
		end
		
		if data.current.modType == "dodaci" then
			isDodaci = true
		end
		
		if data.current.modType == "svijetlaColor" then
			isSvijetla = true
		end

		for k,v in pairs(Config.Menus) do

			if k == data.current.modType or isRimMod or isMjenjac or isSvijetla or isDodaci or isSwap or isStage or isZracni then

				if data.current.label == _U('by_default') or string.match(data.current.label, _U('installed')) then
					ESX.ShowNotification(_U('already_own', data.current.label))
				else
					TriggerEvent('esx_lscustom:cancelInstallMod')
				end

				menu.close()
				found = true
				break
			end

		end

		if not found then
			GetAction(data.current)
		end
	end, function(data, menu) -- on cancel
		menu.close()
		TriggerEvent('esx_lscustom:cancelInstallMod')

		local playerPed = PlayerPedId()
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		SetVehicleDoorsShut(vehicle, false)

		if parent == nil then
			lsMenuIsShowed = false
			local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
			FreezeEntityPosition(vehicle, false)
			myCar = {}
		end
	end, function(data, menu) -- on change
		UpdateMods(data.current)
	end)
end

function DajPlayerId(ped)
	for _, player in ipairs(GetActivePlayers()) do
		if ped == GetPlayerPed(player) then
			return player
		end
	end
end

function OpenLSMenu2(elems, menuName, menuTitle, parent)
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), menuName,
	{
		title    = menuTitle,
		align    = 'top-left',
		elements = elems
	}, function(data, menu)
		local isRimMod, found, isMjenjac, isSvijetla, isDodaci, isSwap, isStage, isZracni, isPopravak = false, false, false, false, false, false, false, false, false
		local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
		local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
		local tablica = vehicleProps.plate

		if data.current.modType == "modFrontWheels" then
			isRimMod = true
		end

		if data.current.modType == "mjenjac" then
			isMjenjac = true
		end
		
		if data.current.modType == "swap" then
			isSwap = true
		end

		if data.current.modType == "zracni" then
			isZracni = true
		end

		if data.current.modType == "popravak" then
			isPopravak = true
		end

		if data.current.modType == "stage" then
			isStage = true
		end
		
		if data.current.modType == "dodaci" then
			isDodaci = true
		end
		
		if data.current.modType == "svijetlaColor" then
			isSvijetla = true
		end

		for k,v in pairs(Config.Menus) do

			if k == data.current.modType or isRimMod or isMjenjac or isSvijetla or isDodaci or isSwap or isStage or isZracni or isPopravak then

				if data.current.label == _U('by_default') or string.match(data.current.label, _U('installed')) then
					ESX.ShowNotification(_U('already_own', data.current.label))
					--TriggerEvent('esx_lscustom:installMod')
				else
					local vehiclePrice = 50000
					local price = 0

					for i=1, #Vehicles, 1 do
						if GetEntityModel(vehicle) == GetHashKey(Vehicles[i].model) then
							vehiclePrice = Vehicles[i].price
							break
						end
					end

					if isRimMod then
						price = math.floor(vehiclePrice * data.current.price / 800)
					elseif isSvijetla then
						price = math.floor(vehiclePrice * 1.10 / 800)
					elseif isMjenjac then
						price = 5000
					elseif isSwap then
						price = math.floor(vehiclePrice * 0.40)
					elseif isZracni then
						price = math.floor(vehiclePrice * 0.10)
					elseif isStage then
						if data.current.modNum == 1 then
							price = math.floor(vehiclePrice * 0.20)
						elseif data.current.modNum == 2 then
							price = math.floor(vehiclePrice * 0.30)
						elseif data.current.modNum == 3 then
							price = math.floor(vehiclePrice * 0.40)
						elseif data.current.modNum == 4 then
							price = math.floor(vehiclePrice * 0.50)
						end
					elseif isPopravak then
						if data.current.modNum == 1 then
							price = math.floor(vehiclePrice * 0.20)
						elseif data.current.modNum == 2 then
							price = math.floor(vehiclePrice * 0.10)
						elseif data.current.modNum == 3 then
							price = math.floor(vehiclePrice * 0.15)
						elseif data.current.modNum == 4 then
							price = math.floor(vehiclePrice * 0.05)
						end
					elseif isDodaci then
						price = 50
					elseif v.modType == 11 or v.modType == 12 or v.modType == 13 or v.modType == 15 or v.modType == 16 then
						price = math.floor(vehiclePrice * v.price[data.current.modNum + 1] / 800)
					elseif v.modType == 17 then
						price = math.floor(vehiclePrice * v.price[1] / 800)
					else
						price = math.floor(vehiclePrice * v.price / 800)
					end
					ESX.ShowNotification("Dodali ste dio na popis narudzbe!")
					local labelic = data.current.label
					labelic = string.match(labelic, "(.*)-")
					if menuTitle ~= data.current.label then
						labelic = menuTitle.." "..labelic
					end
					local naso = false
					for i=1, #Narudzba, 1 do
						if Narudzba[i] ~= nil and Narudzba[i].modType == data.current.modType then
							Narudzba[i].modNum = data.current.modNum
							Narudzba[i].price = price
							Narudzba[i].label = labelic
							Narudzba[i].odradi = data.current.odradi
							Narudzba[i].wheelType = data.current.wheelType
							naso = true
							break
						end
					end
					if not naso then
						table.insert(Narudzba, {tablica = tablica, price = price, modType = data.current.modType, modNum = data.current.modNum, label = labelic, odradi = data.current.odradi, wheelType = data.current.wheelType})
					end
					TriggerEvent('esx_lscustom:cancelInstallMod')
				end

				menu.close()
				found = true
				break
			end

		end

		if not found then
			GetAction(data.current)
		end
	end, function(data, menu) -- on cancel
		menu.close()
		TriggerEvent('esx_lscustom:cancelInstallMod')

		local playerPed = PlayerPedId()
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		SetVehicleDoorsShut(vehicle, false)

		if parent == nil then
			local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
			FreezeEntityPosition(vehicle, false)
			myCar = {}
			if #Narudzba > 0 then
				ESX.ShowNotification("Pritisnite enter na artikl koji zelite obrisati s narudzbe", 5000)
				local elems = {}
				table.insert(elems, {label = "Naruci dijelove", modType = "zavrsi", modValue = "zavrsi"})
				table.insert(elems, {label = "Vrati se narucivati", modType = "vrati", modValue = "vrati"})
				for i=1, #Narudzba, 1 do
					table.insert(elems, {label = Narudzba[i].label, modType = Narudzba[i].modType, modValue = Narudzba[i].modValue})
				end
				ESX.UI.Menu.Open('default', GetCurrentResourceName(), "menu_narudzba",
				{
					title    = "Narudzba",
					align    = 'top-left',
					elements = elems
				}, function(data, menu)
					if data.current.modType == "zavrsi" then
						if not IsVehicleSeatFree(vehicle, -1) then
							local pedara = GetPedInVehicleSeat(vehicle, -1)
							local plID = DajPlayerId(pedara)
							local srwID = GetPlayerServerId(plID)
							local cijena = 0
							for i=1, #Narudzba, 1 do
								cijena = cijena+Narudzba[i].price
							end
							TriggerServerEvent('esx_billing:posaljiTuljana', srwID, 'society_mechanic', "Mehanicar | Dijelovi", cijena)
							TriggerServerEvent("meh:NaruciDijelove", Narudzba, srwID)
							ESX.ShowNotification("Narucili ste dijelove")
						else
							ESX.ShowNotification("Nema vozaca! Narudzba je ponistena!")
						end
						Narudzba = {}
						lsMenuIsShowed = false
						menu.close()
					elseif data.current.modType == "vrati" then
						ESX.ShowNotification("Vratili ste se narucivati")
						menu.close()
						--lsMenuIsShowed = false
						GetAction({value = 'main'})
					else
						for i=1, #Narudzba, 1 do
							if Narudzba[i] ~= nil and Narudzba[i].modType == data.current.modType then
								table.remove(Narudzba, i)
								ESX.ShowNotification("Uspjesno obrisan artikl "..data.current.label)
								break
							end
						end
						GetAction({value = 'main'})
					end
				end, function(data, menu)
					menu.close()
					lsMenuIsShowed = false
					ESX.ShowNotification("Odustali ste od narudzbe")
					Narudzba = {}
				end)
			else
				lsMenuIsShowed = false
			end
		end
	end, function(data, menu) -- on change
		--UpdateMods(data.current)
	end)
end

function UpdateMods(data)
	if data ~= nil then
		local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)

		if data.modType ~= nil then
			local props = {}
			
			if data.wheelType ~= nil then
				props['wheels'] = data.wheelType
				ESX.Game.SetVehicleProperties(vehicle, props)
				props = {}
			elseif data.modType == 'neonColor' then
				if data.modNum[1] == 0 and data.modNum[2] == 0 and data.modNum[3] == 0 then
					props['neonEnabled'] = { false, false, false, false }
				else
					props['neonEnabled'] = { true, true, true, true }
				end
				ESX.Game.SetVehicleProperties(vehicle, props)
				props = {}
			elseif data.modType == 'tyreSmokeColor' then
				props['modSmokeEnabled'] = true
				ESX.Game.SetVehicleProperties(vehicle, props)
				props = {}
			end
			props[data.modType] = data.modNum
			ESX.Game.SetVehicleProperties(vehicle, props)
		end
	end
end

function makeEntityFaceEntity( entity1, entity2 )
    local p1 = GetEntityCoords(entity1, true)
    local p2 = GetEntityCoords(entity2, true)

    local dx = p2.x - p1.x
    local dy = p2.y - p1.y

    local heading = GetHeadingFromVector_2d(dx, dy)
    SetEntityHeading( entity1, heading )
end

local gOff
local oGuma = {}
local staraGuma = {}
function UpdateMods2(nar, data)
	if data ~= nil then
		local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
		local globalplate = GetVehicleNumberPlateText(vehicle)

		if data.modType ~= nil then
			local props = {}
			if data.wheelType ~= nil then
				local modele = "prop_wheel_01"
				ESX.Streaming.RequestModel(modele)
				local mx, my, mz = table.unpack(TrenutniTune.UzmiMotor)
				mz = mz-0.30
				oGuma[4] = CreateObject(GetHashKey(modele), mx, my, mz, false, false, false)
				oGuma[3] = CreateObject(GetHashKey(modele), mx, my, mz+0.15, false, false, false)
				oGuma[2] = CreateObject(GetHashKey(modele), mx, my, mz+0.30, false, false, false)
				oGuma[1] = CreateObject(GetHashKey(modele), mx, my, mz+0.45, false, false, false)
				local playerRotation = GetEntityRotation(oGuma[1], 2)
				local x,y,z = table.unpack(playerRotation)
				SetEntityRotation(oGuma[1], x+90.0, y, z, 2, true)
				SetEntityRotation(oGuma[2], x+90.0, y, z, 2, true)
				SetEntityRotation(oGuma[3], x+90.0, y, z, 2, true)
				SetEntityRotation(oGuma[4], x+90.0, y, z, 2, true)
				FreezeEntityPosition(oGuma[1], true)
				FreezeEntityPosition(oGuma[2], true)
				FreezeEntityPosition(oGuma[3], true)
				FreezeEntityPosition(oGuma[4], true)
				SetModelAsNoLongerNeeded(modele)
				ESX.ShowNotification("Skinite tockove s auta.")
				FreezeEntityPosition(vehicle, true)
				TaskLeaveVehicle(PlayerPedId(), vehicle, 0)
				local orgRot = GetEntityRotation(vehicle, 2)
				local guma
				for i=1, 4, 1 do
					local uzeodio = false
					if i == 1 then
						guma = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, "wheel_lf"))
					elseif i == 2 then
						guma = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, "wheel_rf"))
					elseif i == 3 then
						guma = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, "wheel_lr"))
					elseif i == 4 then
						guma = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, "wheel_rr"))
					end
					while not uzeodio do
						DrawMarker(23, guma.x, guma.y, guma.z-0.3, 0, 0, 0, 0, 0, 0, 1.501, 1.5001, 0.5001, 238, 227, 79, 200, 0, 0, 0, 0)
						if #(GetEntityCoords(PlayerPedId())-guma) <= 1.5 then
							uzeodio = true
						end
						Wait(1)
					end
					local model = 'imp_prop_car_jack_01a'
					local head = GetEntityHeading(vehicle)
					RequestModel(model)
					while not HasModelLoaded(model) do
						Citizen.Wait(1)
					end
					local vehjack = CreateObject(GetHashKey(model), guma.x, guma.y, guma.z, false, false, false)
					FreezeEntityPosition(vehjack, true)
					SetEntityNoCollisionEntity(vehicle, vehjack, false)
					if i == 1 then
						local novecoord = GetOffsetFromEntityInWorldCoords(vehicle, -0.8, 0.6, 0.0) --prednja lijeva
						SetEntityHeading(vehjack, head+90.0) --prednja lijeva
						SetEntityCoords(vehjack, novecoord)
						PlaceObjectOnGroundProperly(vehjack)
						SetModelAsNoLongerNeeded(model)
						local playerRotation = GetEntityRotation(vehicle, 2)
						local vehcoord = GetEntityCoords(vehicle)
						local x,y,z = table.unpack(playerRotation)
						x = x+1.5
						y = y+1.5
						SetEntityRotation(vehicle, x, y, z, 2, true)
						SetEntityCoordsNoOffset(vehicle, vehcoord.x, vehcoord.y, vehcoord.z + 0.05, true, true, true)
					elseif i == 2 then
						local novecoord = GetOffsetFromEntityInWorldCoords(vehicle, 0.8, 0.7, 0.0) --prednja desna
						SetEntityHeading(vehjack, head-90.0) --prednja desna
						SetEntityCoords(vehjack, novecoord)
						PlaceObjectOnGroundProperly(vehjack)
						SetModelAsNoLongerNeeded(model)
						local playerRotation = GetEntityRotation(vehicle, 2)
						local vehcoord = GetEntityCoords(vehicle)
						local x,y,z = table.unpack(playerRotation)
						x = x+1.5
						y = y-1.5
						SetEntityRotation(vehicle, x, y, z, 2, true)
						SetEntityCoordsNoOffset(vehicle, vehcoord.x, vehcoord.y, vehcoord.z + 0.05, true, true, true)
					elseif i == 3 then
						local novecoord = GetOffsetFromEntityInWorldCoords(vehicle, -0.8, -0.7, 0.0) --zadnja lijeva
						SetEntityHeading(vehjack, head+90.0) --zadnja lijeva
						SetEntityCoords(vehjack, novecoord)
						PlaceObjectOnGroundProperly(vehjack)
						SetModelAsNoLongerNeeded(model)
						local playerRotation = GetEntityRotation(vehicle, 2)
						local vehcoord = GetEntityCoords(vehicle)
						local x,y,z = table.unpack(playerRotation)
						x = x-1.5
						y = y+1.5
						SetEntityRotation(vehicle, x, y, z, 2, true)
						SetEntityCoordsNoOffset(vehicle, vehcoord.x, vehcoord.y, vehcoord.z + 0.05, true, true, true)
					else
						local novecoord = GetOffsetFromEntityInWorldCoords(vehicle, 0.8, -0.6, 0.0) --zadnja desna
						SetEntityHeading(vehjack, head-90.0) --zadnja desna
						SetEntityCoords(vehjack, novecoord)
						PlaceObjectOnGroundProperly(vehjack)
						SetModelAsNoLongerNeeded(model)
						local playerRotation = GetEntityRotation(vehicle, 2)
						local vehcoord = GetEntityCoords(vehicle)
						local x,y,z = table.unpack(playerRotation)
						x = x-1.5
						y = y-1.5
						SetEntityRotation(vehicle, x, y, z, 2, true)
						SetEntityCoordsNoOffset(vehicle, vehcoord.x, vehcoord.y, vehcoord.z + 0.05, true, true, true)
					end
					if i == 1 then
						gOff = GetVehicleWheelXOffset(vehicle, 0)
						SetVehicleWheelXOffset(vehicle, 0, -1500)
					elseif i == 2 then
						gOff = GetVehicleWheelXOffset(vehicle, 1)
						SetVehicleWheelXOffset(vehicle, 1, -1500)
					elseif i == 3 then
						gOff = GetVehicleWheelXOffset(vehicle, 2)
						SetVehicleWheelXOffset(vehicle, 2, -1500)
					elseif i == 4 then
						gOff = GetVehicleWheelXOffset(vehicle, 3)
						SetVehicleWheelXOffset(vehicle, 3, -1500)
					end
					local ad = "anim@heists@box_carry@"
					RequestAnimDict(ad)
					while not HasAnimDictLoaded(ad) do
						Citizen.Wait(1000)
					end
					ESX.ShowNotification("Ostavite gumu na oznaceno mjesto!")
					TaskPlayAnim( PlayerPedId(), ad, "idle", 3.0, -8, -1, 63, 0, 0, 0, 0 )
					local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
					local modele = 'prop_wheel_01'
					ESX.Streaming.RequestModel(modele)
					staraGuma[i] = CreateObject(GetHashKey(modele), x, y, z+0.2,  false,  false, false)
					AttachEntityToEntity(staraGuma[i], PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), 0.025, 0.00, 0.355, -75.0, 470.0, 0.0, true, true, false, true, 1, true)
					SetModelAsNoLongerNeeded(modele)
					uzeodio = false
					while not uzeodio do
						DrawMarker(23, TrenutniTune.OstaviMotor, 0, 0, 0, 0, 0, 0, 1.501, 1.5001, 0.5001, 238, 227, 79, 200, 0, 0, 0, 0)
						if #(GetEntityCoords(PlayerPedId())-TrenutniTune.OstaviMotor) <= 1.5 then
							uzeodio = true
						end
						Wait(1)
					end
					ESX.Streaming.RequestAnimSet("move_ped_crouched")
					ESX.Streaming.RequestAnimSet("MOVE_M@TOUGH_GUY@")
					SetPedMovementClipset(PlayerPedId(), "move_ped_crouched", 0.55 )
					SetPedStrafeClipset(PlayerPedId(), "move_ped_crouched_strafing")
					Wait(150)
					DetachEntity(staraGuma[i], true, true)
					ClearPedTasksImmediately(PlayerPedId())
					Wait(50)
					ResetPedMovementClipset( PlayerPedId() )
					ResetPedStrafeClipset(PlayerPedId())
					SetPedMovementClipset( PlayerPedId(),"MOVE_M@TOUGH_GUY@", 0.5)
					RemoveAnimSet("move_ped_crouched")
					RemoveAnimSet("MOVE_M@TOUGH_GUY@")
					uzeodio = false
					while not uzeodio do
						DrawMarker(23, TrenutniTune.UzmiMotor, 0, 0, 0, 0, 0, 0, 1.501, 1.5001, 0.5001, 238, 227, 79, 200, 0, 0, 0, 0)
						if #(GetEntityCoords(PlayerPedId())-TrenutniTune.UzmiMotor) <= 1.5 then
							uzeodio = true
						end
						Wait(1)
					end
					ESX.ShowNotification("Postavite gumu na auto!")
					TaskPlayAnim( PlayerPedId(), ad, "idle", 3.0, -8, -1, 63, 0, 0, 0, 0 )
					RemoveAnimDict(ad)
					AttachEntityToEntity(oGuma[i], PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), 0.025, 0.00, 0.355, -75.0, 470.0, 0.0, true, true, false, true, 1, true)
					uzeodio = false
					while not uzeodio do
						DrawMarker(23, guma.x, guma.y, guma.z-0.3, 0, 0, 0, 0, 0, 0, 1.501, 1.5001, 0.5001, 238, 227, 79, 200, 0, 0, 0, 0)
						if #(GetEntityCoords(PlayerPedId())-guma) <= 1.5 then
							uzeodio = true
						end
						Wait(1)
					end
					DeleteObject(vehjack)
					SetEntityRotation(vehicle, orgRot.x, orgRot.y, orgRot.z, 2, true)
					local vehcoord = GetEntityCoords(vehicle)
					SetEntityCoordsNoOffset(vehicle, vehcoord.x, vehcoord.y, vehcoord.z - 0.05, true, true, true)
					ClearPedTasksImmediately(PlayerPedId())
					DetachEntity(oGuma[i], true, true)
					DeleteObject(oGuma[i])
					oGuma[i] = nil
					if i == 1 then
						SetVehicleWheelXOffset(vehicle, 0, gOff)
					elseif i == 2 then
						SetVehicleWheelXOffset(vehicle, 1, gOff)
					elseif i == 3 then
						SetVehicleWheelXOffset(vehicle, 2, gOff)
					elseif i == 4 then
						SetVehicleWheelXOffset(vehicle, 3, gOff)
					end
				end
				for i=1, 4, 1 do
					if oGuma[i] ~= nil then
						DeleteObject(oGuma[i])
					end
					if staraGuma[i] ~= nil then
						DeleteObject(staraGuma[i])
					end
					oGuma[i] = nil
					staraGuma[i] = nil
				end
				FreezeEntityPosition(vehicle, false)
				props['wheels'] = data.wheelType
				ESX.Game.SetVehicleProperties(vehicle, props)
				props = {}
			elseif data.modType == 'neonColor' then
				if data.modNum[1] == 0 and data.modNum[2] == 0 and data.modNum[3] == 0 then
					props['neonEnabled'] = { false, false, false, false }
				else
					props['neonEnabled'] = { true, true, true, true }
				end
				FreezeEntityPosition(vehicle, false)
				ESX.Game.SetVehicleProperties(vehicle, props)
				props = {}
			elseif data.modType == 'tyreSmokeColor' then
				props['modSmokeEnabled'] = true
				ESX.Game.SetVehicleProperties(vehicle, props)
				FreezeEntityPosition(vehicle, false)
				props = {}
			elseif data.modType == 'stage' then
				TriggerServerEvent("stage:PromjeniStage", data.modNum, globalplate)
				Wait(500)
				TriggerEvent('stage:Provjera', -1)
				FreezeEntityPosition(vehicle, false)
			elseif data.modType == 'mjenjac' then
				local ped = PlayerPedId()
				TaskLeaveVehicle(ped, vehicle, 16)
				Wait(1000)
				makeEntityFaceEntity(ped, vehicle)
				local coords = GetEntityCoords(ped)
				local dict
				local model = 'prop_carjack'
				local offset = GetOffsetFromEntityInWorldCoords(ped, 0.0, -2.0, 0.0)
				local headin = GetEntityHeading(ped)
				--makeEntityFaceEntity(ped, vehicle)
				Wait(1000)
				local veh = vehicle
				FreezeEntityPosition(veh, true)
				local vehpos = GetEntityCoords(veh)
				dict = 'mp_car_bomb'
				RequestAnimDict(dict)
				RequestModel(model)
				while not HasAnimDictLoaded(dict) or not HasModelLoaded(model) do
					Citizen.Wait(1)
				end
				local vehjack = CreateObject(GetHashKey(model), vehpos.x, vehpos.y, vehpos.z - 0.5, false, false, false)
				SetModelAsNoLongerNeeded(model)
				
				AttachEntityToEntity(vehjack, veh, 0, 0.0, 0.0, -1.0, 0.0, 0.0, 0.0, false, false, false, false, 0, true)
				TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1250, 1, 0.0, 1, 1)
				Citizen.Wait(1250)
				SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.01, true, true, true)
				TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
				Citizen.Wait(1000)
				SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.025, true, true, true)
				TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
				Citizen.Wait(1000)
				SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.05, true, true, true)
				TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
				Citizen.Wait(1000)
				SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.1, true, true, true)
				TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
				Citizen.Wait(1000)
				SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.15, true, true, true)
				TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
				Citizen.Wait(1000)
				SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.2, true, true, true)
				TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
				Citizen.Wait(1000)
				SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.3, true, true, true)
				TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
				Citizen.Wait(1000)
				SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.4, true, true, true)
				TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
				SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.5, true, true, true)
				SetEntityCollision(veh, false, false)
				TaskPedSlideToCoord(ped, offset, headin, 1000)
				Citizen.Wait(1000)
				RemoveAnimDict(dict)
				dict = 'move_crawl'
				RequestAnimDict(dict)
				while not HasAnimDictLoaded(dict) do
					Citizen.Wait(100)
				end
				ESX.ShowPBar("Zamjena mjenjaca", 11000)
				TaskPlayAnimAdvanced(ped, dict, 'onback_bwd', coords, 0.0, 0.0, headin - 180, 1.0, 0.5, 3000, 1, 0.0, 1, 1)
				RemoveAnimDict(dict)
				dict = 'amb@world_human_vehicle_mechanic@male@base'
				Citizen.Wait(3000)
				RequestAnimDict(dict)
				while not HasAnimDictLoaded(dict) do
					Citizen.Wait(1)
				end
				TaskPlayAnim(ped, dict, 'base', 8.0, -8.0, 5000, 1, 0, false, false, false)
				RemoveAnimDict(dict)
				dict = 'move_crawl'
				Citizen.Wait(5000)
				local coords2 = GetEntityCoords(ped)
				RequestAnimDict(dict)
				while not HasAnimDictLoaded(dict) do
					Citizen.Wait(1)
				end
				TaskPlayAnimAdvanced(ped, dict, 'onback_fwd', coords2, 0.0, 0.0, headin - 180, 1.0, 0.5, 2000, 1, 0.0, 1, 1)
				RemoveAnimDict(dict)
				Citizen.Wait(3000)
				dict = 'mp_car_bomb'
				RequestAnimDict(dict)
				while not HasAnimDictLoaded(dict) do
					Citizen.Wait(1)
				end
				ClearPedTasksImmediately(playerPed)
				TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1250, 1, 0.0, 1, 1)
				Citizen.Wait(1250)
				SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.4, true, true, true)
				TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
				Citizen.Wait(1000)
				SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.3, true, true, true)
				TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
				Citizen.Wait(1000)
				SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.2, true, true, true)
				TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
				Citizen.Wait(1000)
				SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.15, true, true, true)
				TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
				Citizen.Wait(1000)
				SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.1, true, true, true)
				TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
				Citizen.Wait(1000)
				SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.05, true, true, true)
				TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
				Citizen.Wait(1000)
				SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.025, true, true, true)
				TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
				RemoveAnimDict(dict)
				dict = 'move_crawl'
				Citizen.Wait(1000)
				SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.01, true, true, true)
				TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
				SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z, true, true, true)
				FreezeEntityPosition(veh, false)
				Citizen.Wait(100)
				DetachEntity(vehjack, true, false)
				SetEntityCollision(vehjack, false, false)
				DeleteEntity(vehjack)
				SetEntityCollision(veh, true, true)
				RemoveAnimDict(dict)
				if data.modNum == 1 then
					TriggerEvent("EoTiIzSalona", 1)
				elseif data.modNum == 2 then
					TriggerEvent("EoTiIzSalona", 2)
				end
				TriggerServerEvent("meh:PromjeniMjenjac", data.modNum, globalplate)
				FreezeEntityPosition(vehicle, false)
			elseif data.modType == 'swap' then
				if prop_ent ~= nil then
					DeleteObject(prop_ent)
				end
				if prop_ent2 ~= nil then
					DeleteObject(prop_ent2)
				end
				if prop_ent3 ~= nil then
					DeleteObject(prop_ent3)
				end
				FreezeEntityPosition(vehicle, true)
				TaskLeaveVehicle(PlayerPedId(), vehicle, 0)
				local modele = "imp_prop_engine_hoist_02a"
				ESX.Streaming.RequestModel(modele)
				prop_ent = CreateObject(GetHashKey(modele), TrenutniTune.Motor, false, false, false)
				SetModelAsNoLongerNeeded(modele)

				modele = "prop_car_engine_01"
				ESX.Streaming.RequestModel(modele)
				prop_ent3 = CreateObject(GetHashKey(modele), TrenutniTune.UzmiMotor, false, false, false)
				SetModelAsNoLongerNeeded(modele)

				local uzeodio = false
				while not uzeodio do
					DrawMarker(23, TrenutniTune.Motor.x, TrenutniTune.Motor.y, TrenutniTune.Motor.z, 0, 0, 0, 0, 0, 0, 1.501, 1.5001, 0.5001, 238, 227, 79, 200, 0, 0, 0, 0)
					if #(GetEntityCoords(PlayerPedId())-TrenutniTune.Motor) <= 3.0 then
						uzeodio = true
					end
					Wait(1)
				end
				local engcoord = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, "engine"))
				local gepekcoord = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, "boot"))
				local haubacoord = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, "bonnet"))
				local brVrata = 5
				if #(engcoord-gepekcoord) < #(engcoord-haubacoord) then
					brVrata = 5
				else
					brVrata = 4
				end
				if engcoord.x == 0 and engcoord.y == 0 then
					brVrata = 4
				end
				SetVehicleDoorOpen(vehicle, brVrata, false, false)
				ESX.Streaming.RequestAnimDict("anim@heists@box_carry@", function()
					TaskPlayAnim(PlayerPedId(),"anim@heists@box_carry@", "idle", 8.0, 8.0, -1, 50)
					RemoveAnimDict("anim@heists@box_carry@")
				end)
				-- local modele = "imp_prop_engine_hoist_02a"
				-- ESX.Streaming.RequestModel(modele)
				-- prop_ent = CreateObject(GetHashKey(modele), GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.0, -5.0), false, false, false)
				AttachEntityToEntity(prop_ent, PlayerPedId(), GetEntityBoneIndexByName(PlayerPedId(), "SKEL_Pelvis"), -0.1, 1.3, -1.0, 0.0, -0.95, 178.8, 10000.0, false, false, false, 0, true)
				--SetModelAsNoLongerNeeded(modele)
				local veh = vehicle
				local dist = 2.0
				local coords = GetWorldPositionOfEntityBone(veh, GetEntityBoneIndexByName(veh, "engine"))
				if engcoord.x == 0 and engcoord.y == 0 then
					coords = haubacoord
					dist = 3.0
				end
				while #(coords-GetEntityCoords(PlayerPedId())) > dist do
					DrawMarker(23, coords.x, coords.y, coords.z, 0, 0, 0, 0, 0, 0, 1.501, 1.5001, 0.5001, 238, 227, 79, 200, 0, 0, 0, 0)
					Wait(1)
				end
				FreezeEntityPosition(PlayerPedId(), true)
				makeEntityFaceEntity(PlayerPedId(), vehicle)
				local head = GetEntityHeading(veh)
				modele = "prop_car_engine_01"
				ESX.Streaming.RequestModel(modele)
				prop_ent2 = CreateObject(GetHashKey(modele), coords.x, coords.y, coords.z-0.5, false, false, false)
				SetEntityHeading(prop_ent2, head)
				SetEntityNoCollisionEntity(prop_ent2, veh, false)
				SetModelAsNoLongerNeeded(modele)
				local novecoord = GetOffsetFromEntityInWorldCoords(prop_ent2, 0.0, 0.0, 0.8)
				local tadHeading = GetEntityHeading(prop_ent2)
				Wait(3000)
				while not SlideObject(
					prop_ent2, 
					novecoord.x,
					novecoord.y,
					novecoord.z,
					0.001, 
					0.001, 
					0.001, 
					false
				) do
					Wait(1)
				end
				DeleteEntity(prop_ent2)
				FreezeEntityPosition(PlayerPedId(), false)
				--uzeo motor
				modele = "prop_car_engine_01"
				ESX.Streaming.RequestModel(modele)
				prop_ent2 = CreateObject(GetHashKey(modele), GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.0, -5.0), false, false, false)
				AttachEntityToEntity(prop_ent2, prop_ent, 0, -0.1, -1.1, 1.2, 0.0, -0.95, 0.0, 10000.0, false, false, false, 0, true)
				SetModelAsNoLongerNeeded(modele)
				--makne taj motor
				local maknuoga = false
				while not maknuoga do
					DrawMarker(23, TrenutniTune.OstaviMotor.x, TrenutniTune.OstaviMotor.y, TrenutniTune.OstaviMotor.z, 0, 0, 0, 0, 0, 0, 1.501, 1.5001, 0.5001, 238, 227, 79, 200, 0, 0, 0, 0)
					if #(GetEntityCoords(PlayerPedId())-TrenutniTune.OstaviMotor) <= 2.0 then
						maknuoga = true
					end
					Wait(1)
				end
				DetachEntity(prop_ent2, true, true)
				--Zakaci drugi
				local zakacioga = false
				while not zakacioga do
					DrawMarker(23, TrenutniTune.UzmiMotor.x, TrenutniTune.UzmiMotor.y, TrenutniTune.UzmiMotor.z, 0, 0, 0, 0, 0, 0, 1.501, 1.5001, 0.5001, 238, 227, 79, 200, 0, 0, 0, 0)
					if #(GetEntityCoords(PlayerPedId())-TrenutniTune.UzmiMotor) <= 2.0 then
						zakacioga = true
					end
					Wait(1)
				end
				-- modele = "prop_car_engine_01"
				-- ESX.Streaming.RequestModel(modele)
				-- prop_ent3 = CreateObject(GetHashKey(modele), GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.0, -5.0), false, false, false)
				AttachEntityToEntity(prop_ent3, prop_ent, 0, -0.1, -1.1, 1.2, 0.0, -0.95, 0.0, 10000.0, false, false, false, 0, true)
				--SetModelAsNoLongerNeeded(modele)
				--Ugradi drugi
				while #(coords-GetEntityCoords(PlayerPedId())) > dist do
					DrawMarker(23, coords.x, coords.y, coords.z, 0, 0, 0, 0, 0, 0, 1.501, 1.5001, 0.5001, 238, 227, 79, 200, 0, 0, 0, 0)
					Wait(1)
				end
				FreezeEntityPosition(PlayerPedId(), true)
				makeEntityFaceEntity(PlayerPedId(), vehicle)
				head = tadHeading
				coords = novecoord
				DeleteEntity(prop_ent3)
				modele = "prop_car_engine_01"
				ESX.Streaming.RequestModel(modele)
				prop_ent3 = CreateObject(GetHashKey(modele), coords.x, coords.y, coords.z, false, false, false)
				SetEntityHeading(prop_ent3, head)
				SetEntityNoCollisionEntity(prop_ent3, veh, false)
				SetModelAsNoLongerNeeded(modele)
				local novecoord = GetWorldPositionOfEntityBone(veh, GetEntityBoneIndexByName(veh, "engine"))
				if novecoord.x == 0 and novecoord.y == 0 then
					novecoord = haubacoord
				end
				Wait(3000)
				while not SlideObject(
					prop_ent3, 
					novecoord.x,
					novecoord.y,
					novecoord.z-0.5,
					0.001, 
					0.001, 
					0.001, 
					false
				) do
					Wait(1)
				end
				FreezeEntityPosition(PlayerPedId(), false)
				DetachEntity(prop_ent3, true, true)
				DeleteEntity(prop_ent3)
				prop_ent3 = nil
				if prop_ent ~= nil then
					DeleteObject(prop_ent)
					prop_ent = nil
				end
				if prop_ent2 ~= nil then
					DeleteObject(prop_ent2)
					prop_ent2 = nil
				end
				if prop_ent3 ~= nil then
					DeleteObject(prop_ent3)
					prop_ent3 = nil
				end
				ClearPedTasksImmediately(PlayerPedId())
				local currentradio = GetPlayerRadioStationIndex(vehicle)
				ForceVehicleEngineAudio(vehicle, data.modNum)
				Citizen.Wait(200)
				print("changing radio")
				if currentradio ~= 255 then
					SetRadioToStationIndex(currentradio)
				else
					SetRadioToStationName("OFF")
				end
				local netid = VehToNet(vehicle)
				TriggerServerEvent("vozila:PromjeniZvuk", GetPlayerServerId(PlayerId()), netid, data.modNum)
				TriggerServerEvent("motor:PromjeniMotor", data.modNum, globalplate)
				SetVehicleDoorShut(vehicle, brVrata, false)
				FreezeEntityPosition(vehicle, false)
				--Wait(500)
				--TriggerEvent('stage:Provjera', -1)
			elseif data.modType == 'zracni' then
				TriggerServerEvent("ovjes:PromjeniOvjes", data.modNum, globalplate)
				FreezeEntityPosition(vehicle, false)
			elseif data.modType == 'popravak' then
				if data.modNum == 1 then
					local ped = PlayerPedId()
					TaskLeaveVehicle(ped, vehicle, 16)
					Wait(1000)
					local coords = GetEntityCoords(ped)
					local dict
					local model = 'prop_carjack'
					local offset = GetOffsetFromEntityInWorldCoords(ped, 0.0, -2.0, 0.0)
					local headin = GetEntityHeading(ped)
					makeEntityFaceEntity(ped, vehicle)
					Wait(1000)
					local veh = vehicle
					FreezeEntityPosition(veh, true)
					local vehpos = GetEntityCoords(veh)
					dict = 'mp_car_bomb'
					RequestAnimDict(dict)
					RequestModel(model)
					while not HasAnimDictLoaded(dict) or not HasModelLoaded(model) do
						Citizen.Wait(1)
					end
					local vehjack = CreateObject(GetHashKey(model), vehpos.x, vehpos.y, vehpos.z - 0.5, false, false, false)
					SetModelAsNoLongerNeeded(model)
					
					AttachEntityToEntity(vehjack, veh, 0, 0.0, 0.0, -1.0, 0.0, 0.0, 0.0, false, false, false, false, 0, true)
					TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1250, 1, 0.0, 1, 1)
					Citizen.Wait(1250)
					SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.01, true, true, true)
					TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
					Citizen.Wait(1000)
					SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.025, true, true, true)
					TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
					Citizen.Wait(1000)
					SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.05, true, true, true)
					TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
					Citizen.Wait(1000)
					SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.1, true, true, true)
					TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
					Citizen.Wait(1000)
					SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.15, true, true, true)
					TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
					Citizen.Wait(1000)
					SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.2, true, true, true)
					TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
					Citizen.Wait(1000)
					SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.3, true, true, true)
					TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
					Citizen.Wait(1000)
					SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.4, true, true, true)
					TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
					SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.5, true, true, true)
					SetEntityCollision(veh, false, false)
					TaskPedSlideToCoord(ped, offset, headin, 1000)
					Citizen.Wait(1000)
					RemoveAnimDict(dict)
					dict = 'move_crawl'
					RequestAnimDict(dict)
					while not HasAnimDictLoaded(dict) do
						Citizen.Wait(100)
					end
					ESX.ShowPBar("Popravak mjenjaca", 11000)
					TaskPlayAnimAdvanced(ped, dict, 'onback_bwd', coords, 0.0, 0.0, headin - 180, 1.0, 0.5, 3000, 1, 0.0, 1, 1)
					RemoveAnimDict(dict)
					dict = 'amb@world_human_vehicle_mechanic@male@base'
					Citizen.Wait(3000)
					RequestAnimDict(dict)
					while not HasAnimDictLoaded(dict) do
						Citizen.Wait(1)
					end
					TaskPlayAnim(ped, dict, 'base', 8.0, -8.0, 5000, 1, 0, false, false, false)
					RemoveAnimDict(dict)
					dict = 'move_crawl'
					Citizen.Wait(5000)
					local coords2 = GetEntityCoords(ped)
					RequestAnimDict(dict)
					while not HasAnimDictLoaded(dict) do
						Citizen.Wait(1)
					end
					TaskPlayAnimAdvanced(ped, dict, 'onback_fwd', coords2, 0.0, 0.0, headin - 180, 1.0, 0.5, 2000, 1, 0.0, 1, 1)
					RemoveAnimDict(dict)
					Citizen.Wait(3000)
					dict = 'mp_car_bomb'
					RequestAnimDict(dict)
					while not HasAnimDictLoaded(dict) do
						Citizen.Wait(1)
					end
					ClearPedTasksImmediately(playerPed)
					TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1250, 1, 0.0, 1, 1)
					Citizen.Wait(1250)
					SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.4, true, true, true)
					TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
					Citizen.Wait(1000)
					SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.3, true, true, true)
					TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
					Citizen.Wait(1000)
					SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.2, true, true, true)
					TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
					Citizen.Wait(1000)
					SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.15, true, true, true)
					TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
					Citizen.Wait(1000)
					SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.1, true, true, true)
					TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
					Citizen.Wait(1000)
					SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.05, true, true, true)
					TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
					Citizen.Wait(1000)
					SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.025, true, true, true)
					TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
					RemoveAnimDict(dict)
					dict = 'move_crawl'
					Citizen.Wait(1000)
					SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.01, true, true, true)
					TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
					SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z, true, true, true)
					FreezeEntityPosition(veh, false)
					Citizen.Wait(100)
					DetachEntity(vehjack, true, false)
					SetEntityCollision(vehjack, false, false)
					DeleteEntity(vehjack)
					SetEntityCollision(veh, true, true)
					RemoveAnimDict(dict)
					FreezeEntityPosition(veh, false)
				else
					FreezeEntityPosition(vehicle, true)
					TaskLeaveVehicle(PlayerPedId(), vehicle, 0)
					local bon = GetEntityBoneIndexByName(vehicle, "engine")
					if bon == -1 then
						bon = GetEntityBoneIndexByName(vehicle, "overheat")
					else
						bon = GetEntityBoneIndexByName(vehicle, "bonnet")
					end
					local engcoord = GetWorldPositionOfEntityBone(vehicle, bon)
					local gepekcoord = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, "boot"))
					local haubacoord = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, "bonnet"))
					local brVrata = 5
					if #(engcoord-gepekcoord) < #(engcoord-haubacoord) then
						brVrata = 5
					else
						brVrata = 4
					end
					SetVehicleDoorOpen(vehicle, brVrata, false, false)
					while #(engcoord-GetEntityCoords(PlayerPedId())) > 0.8 do
						DrawMarker(23, engcoord.x, engcoord.y, engcoord.z, 0, 0, 0, 0, 0, 0, 1.501, 1.5001, 0.5001, 238, 227, 79, 200, 0, 0, 0, 0)
						Wait(1)
					end
					FreezeEntityPosition(PlayerPedId(), true)
					makeEntityFaceEntity(PlayerPedId(), vehicle)
					TaskStartScenarioInPlace(PlayerPedId(), 'PROP_HUMAN_BUM_BIN', 0, true)
					ESX.ShowPBar("Popravljanje", 10000)
					Citizen.Wait(10000)
					FreezeEntityPosition(PlayerPedId(), false)
					ClearPedTasksImmediately(PlayerPedId())
					SetVehicleDoorShut(vehicle, brVrata, false)
					Wait(500)
					FreezeEntityPosition(vehicle, false)
				end
				if data.modNum == 2 then
					SetVehicleEngineHealth(vehicle, 1000.0)
				end
				SetVehicleUndriveable(vehicle, false)
				TriggerEvent("kvar:PopraviKvar", globalplate)
			elseif data.modType == "dodaci" then
				SetVehicleExtra(vehicle, data.modNum, data.odradi)
			end
			props[data.modType] = data.modNum
			ESX.Game.SetVehicleProperties(vehicle, props)
			SetVehicleUndriveable(vehicle, false)
			TriggerEvent("esx_lscustom:installMod")
			lsMenuIsShowed = false
			TriggerServerEvent("narudzbe:MakniDio", nar, data.modType)
		end
	end
end

function GetAction(data)
	if(data.value == "zavrsi") then
		TriggerEvent('esx_lscustom:cancelInstallMod')

		local playerPed = PlayerPedId()
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		SetVehicleDoorsShut(vehicle, false)
		parent = nil
		if parent == nil then
			--lsMenuIsShowed = false
			local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
			FreezeEntityPosition(vehicle, false)
			myCar = {}
		end
		ESX.UI.Menu.CloseAll()
		if #Narudzba > 0 then
			local elems = {}
			ESX.ShowNotification("Pritisnite enter na artikl koji zelite obrisati s narudzbe", 5000)
			table.insert(elems, {label = "Naruci dijelove", modType = "zavrsi", modValue = "zavrsi"})
			table.insert(elems, {label = "Vrati se narucivati", modType = "vrati", modValue = "vrati"})
			for i=1, #Narudzba, 1 do
				table.insert(elems, {label = Narudzba[i].label, modType = Narudzba[i].modType, modValue = Narudzba[i].modValue})
			end
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), "menu_narudzba",
			{
				title    = "Narudzba",
				align    = 'top-left',
				elements = elems
			}, function(data, menu)
				if data.current.modType == "zavrsi" then
					if not IsVehicleSeatFree(vehicle, -1) then
						local pedara = GetPedInVehicleSeat(vehicle, -1)
						local plID = DajPlayerId(pedara)
						local srwID = GetPlayerServerId(plID)
						local cijena = 0
						for i=1, #Narudzba, 1 do
							cijena = cijena+Narudzba[i].price
						end
						TriggerServerEvent('esx_billing:posaljiTuljana', srwID, 'society_mechanic', "Mehanicar | Dijelovi", cijena)
						TriggerServerEvent("meh:NaruciDijelove", Narudzba, srwID)
						ESX.ShowNotification("Narucili ste dijelove")
						FreezeEntityPosition(vehicle, false)
					else
						ESX.ShowNotification("Nema vozaca! Narudzba je ponistena!")
						FreezeEntityPosition(vehicle, false)
					end
					lsMenuIsShowed = false
					Narudzba = {}
					menu.close()
				elseif data.current.modType == "vrati" then
					ESX.ShowNotification("Vratili ste se narucivati")
					menu.close()
					--lsMenuIsShowed = false
					GetAction({value = 'main'})
				else
					for i=1, #Narudzba, 1 do
						if Narudzba[i] ~= nil and Narudzba[i].modType == data.current.modType then
							table.remove(Narudzba, i)
							ESX.ShowNotification("Uspjesno obrisan artikl "..data.current.label)
							break
						end
					end
					GetAction({value = 'main'})
				end
			end, function(data, menu)
				menu.close()
				ESX.ShowNotification("Odustali ste od narudzbe")
				Narudzba = {}
				lsMenuIsShowed = false
				FreezeEntityPosition(vehicle, false)
				--UpdateMods(data.current)
			end)
		else
			lsMenuIsShowed = false
		end
	else
		local elements  = {}
		local menuName  = ''
		local menuTitle = ''
		local parent    = nil

		local lime = "installed"
		local playerPed = PlayerPedId()
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		if PlayerData.job ~= nil and PlayerData.job.name == 'mechanic' then
			if GetPedInVehicleSeat(vehicle, 0) == playerPed then
				if not IsVehicleSeatFree(vehicle, -1) then
					lime = "izabrano"
				end
			end
		end

		local currentMods = ESX.Game.GetVehicleProperties(vehicle)

		if data.value == 'modSpeakers' or
			data.value == 'modTrunk' or
			data.value == 'modHydrolic' or
			data.value == 'modEngineBlock' or
			data.value == 'modAirFilter' or
			data.value == 'modStruts' or
			data.value == 'modTank' then
			SetVehicleDoorOpen(vehicle, 4, false)
			SetVehicleDoorOpen(vehicle, 5, false)
		elseif data.value == 'modDoorSpeaker' then
			SetVehicleDoorOpen(vehicle, 0, false)
			SetVehicleDoorOpen(vehicle, 1, false)
			SetVehicleDoorOpen(vehicle, 2, false)
			SetVehicleDoorOpen(vehicle, 3, false)
		else
			SetVehicleDoorsShut(vehicle, false)
		end

		local vehiclePrice = 50000

		for i=1, #Vehicles, 1 do
			if GetEntityModel(vehicle) == GetHashKey(Vehicles[i].model) then
				vehiclePrice = Vehicles[i].price
				break
			end
		end

		for k,v in pairs(Config.Menus) do
			if data.value == k and k ~= "zavrsi" then
				menuName  = k
				menuTitle = v.label
				parent    = v.parent
				if data.value == "svijetlaColor" and not currentMods.modXenon then
					ESX.ShowNotification("Vozilo mora imati ugradjena xenon svijetla!")
					return
				end

				if v.modType ~= nil then
					
					if v.modType == 22 then
						table.insert(elements, {label = " " .. _U('by_default'), modType = k, modNum = false})
					elseif v.modType == 'neonColor' or v.modType == 'tyreSmokeColor' then -- disable neon
						table.insert(elements, {label = " " ..  _U('by_default'), modType = k, modNum = {0, 0, 0}})
					elseif v.modType == 'color1' or v.modType == 'color2' or v.modType == 'pearlescentColor' or v.modType == 'wheelColor' then
						local num = myCar[v.modType]
						table.insert(elements, {label = " " .. _U('by_default'), modType = k, modNum = num})
					elseif v.modType == 17 then
						table.insert(elements, {label = " " .. _U('no_turbo'), modType = k, modNum = false})
					else
						if v.modType ~= "mjenjac" and v.modType ~= "dodaci" and v.modType ~= "stage" and v.modType ~= "swap" and v.modType ~= "zracni" and v.modType ~= "popravak" then
							table.insert(elements, {label = " " .. _U('by_default'), modType = k, modNum = -1})
						end
					end

					if v.modType == 14 then -- HORNS
						for j = 0, 51, 1 do
							local _label = ''
							if j == currentMods.modHorns then
								_label = "["..(j+1).."] "..GetHornName(j) .. ' - <span style="color:cornflowerblue;">'.. _U(lime) ..'</span>'
							else
								price = math.floor((vehiclePrice * v.price / 800)*1.30)
								_label = "["..(j+1).."] "..GetHornName(j) .. ' - <span style="color:green;">$' .. price .. ' </span>'
							end
							table.insert(elements, {label = _label, modType = k, modNum = j})
						end
					elseif v.modType == 'plateIndex' then -- PLATES
						for j = 0, 4, 1 do
							local _label = ''
							if j == currentMods.plateIndex then
								_label = "["..(j+1).."] "..GetPlatesName(j) .. ' - <span style="color:cornflowerblue;">'.. _U(lime) ..'</span>'
							else
								price = math.floor((vehiclePrice * v.price / 800)*1.30)
								_label = "["..(j+1).."] "..GetPlatesName(j) .. ' - <span style="color:green;">$' .. price .. ' </span>'
							end
							table.insert(elements, {label = _label, modType = k, modNum = j})
						end
					elseif v.modType == 22 then -- NEON
						local _label = ''
						if currentMods.modXenon then
							_label = _U('neon') .. ' - <span style="color:cornflowerblue;">'.. _U(lime) ..'</span>'
						else
							price = math.floor((vehiclePrice * v.price / 800)*1.30)
							_label = _U('neon') .. ' - <span style="color:green;">$' .. price .. ' </span>'
						end
						table.insert(elements, {label = _label, modType = k, modNum = true})
					elseif v.modType == 'neonColor' or v.modType == 'tyreSmokeColor' then -- NEON & SMOKE COLOR
						local neons = GetNeons()
						price = math.floor((vehiclePrice * v.price / 800)*1.30)
						for i=1, #neons, 1 do
							table.insert(elements, {
								label = "["..i.."] "..'<span style="color:rgb(' .. neons[i].r .. ',' .. neons[i].g .. ',' .. neons[i].b .. ');">' .. neons[i].label .. ' - <span style="color:green;">$' .. price .. '</span>',
								modType = k,
								modNum = { neons[i].r, neons[i].g, neons[i].b }
							})
						end
					elseif v.modType == 'color1' or v.modType == 'color2' or v.modType == 'pearlescentColor' or v.modType == 'wheelColor' then -- RESPRAYS
						local colors = GetColors(data.color)
						for j = 1, #colors, 1 do
							local _label = ''
							price = math.floor((vehiclePrice * v.price / 800)*1.30)
							_label = "["..j.."] "..colors[j].label .. ' - <span style="color:green;">$' .. price .. ' </span>'
							table.insert(elements, {label = _label, modType = k, modNum = colors[j].index})
						end
					elseif v.modType == 'swap' then
						local globalplate  = ESX.Math.Trim(GetVehicleNumberPlateText(vehicle))
						local _label = ''
						local provjera = false
						price = math.floor(vehiclePrice * 0.40)
						if globalplate ~= nil or globalplate ~= "" or globalplate ~= " " then
							ESX.TriggerServerCallback('stage:ProvjeriVozilo',function(st)
								if st ~= 0 then
									_label = 'Stock motor - <span style="color:green;">$' .. price .. ' </span>'
									table.insert(elements, {label = _label, modType = k, mlabel = "Stock motor", modNum = "stock"})
									for i = 1, #Config.Motori do
										if st.motor ~= Config.Motori[i].naziv then
											_label = Config.Motori[i].label..' - <span style="color:green;">$' .. price .. ' </span>'
											table.insert(elements, {label = _label, modType = k, mlabel = Config.Motori[i].label, modNum = Config.Motori[i].naziv})
										end
									end
								end
								provjera = true
							end, globalplate)
						end
						while not provjera do
							Wait(100)
						end
					elseif v.modType == 'zracni' then
						local globalplate  = ESX.Math.Trim(GetVehicleNumberPlateText(vehicle))
						local _label = ''
						local provjera = false
						price = math.floor(vehiclePrice * 0.10)
						if globalplate ~= nil or globalplate ~= "" or globalplate ~= " " then
							ESX.TriggerServerCallback('stage:ProvjeriVozilo',function(st)
								if st ~= 0 then
									if st.zracni == 0 then
										_label = 'Zracni ovjes'..' - <span style="color:green;">$' .. price .. ' </span>'
										table.insert(elements, {label = _label, modType = k, modNum = 1})
									else
										_label = 'Obicni ovjes'..' - <span style="color:green;">$' .. price .. ' </span>'
										table.insert(elements, {label = _label, modType = k, modNum = 0})
									end
								end
								provjera = true
							end, globalplate)
						end
						while not provjera do
							Wait(100)
						end
					elseif v.modType == 'stage' then
						local globalplate  = ESX.Math.Trim(GetVehicleNumberPlateText(vehicle))
						local _label = ''
						local provjera = false
						--price = 5000*1.30
						if globalplate ~= nil or globalplate ~= "" or globalplate ~= " " then
							ESX.TriggerServerCallback('stage:ProvjeriVozilo',function(st)
								provjera = true
								if st ~= 0 then
									st = tonumber(st.stage)
									if st < 4 then
										if st == 0 then
											price = math.floor(vehiclePrice * 0.20)
										elseif st == 1 then
											price = math.floor(vehiclePrice * 0.30)
										elseif st == 2 then
											price = math.floor(vehiclePrice * 0.40)
										elseif st == 3 then
											price = math.floor(vehiclePrice * 0.50)
										end
										_label = 'Stage '..(st+1)..' - <span style="color:green;">$' .. price .. ' </span>'
										table.insert(elements, {label = _label, modType = k, modNum = (st+1)})
									end
								end
							end, globalplate)
						end
						while not provjera do
							Wait(100)
						end
					elseif v.modType == 'mjenjac' then
						local globalplate  = ESX.Math.Trim(GetVehicleNumberPlateText(vehicle))
						local _label = ''
						price = 5000*1.30
						if globalplate ~= nil or globalplate ~= "" or globalplate ~= " " then
							ESX.TriggerServerCallback('mjenjac:ProvjeriVozilo',function(mj)
								if mj == 1 then
									_label = 'Automatski mjenjac - <span style="color:cornflowerblue;">'.. _U(lime) ..'</span>'
								else
									_label = 'Automatski mjenjac - <span style="color:green;">$' .. price .. ' </span>'
								end
								table.insert(elements, {label = _label, modType = k, modNum = 1})
								if mj == 2 then
									_label = 'Rucni mjenjac - <span style="color:cornflowerblue;">'.. _U(lime) ..'</span>'
								else
									_label = 'Rucni mjenjac - <span style="color:green;">$' .. price .. ' </span>'
								end
								table.insert(elements, {label = _label, modType = k, modNum = 2})
							end, globalplate)
						end
						Wait(200)
					elseif v.modType == 'popravak' then
						local globalplate  = ESX.Math.Trim(GetVehicleNumberPlateText(vehicle))
						local _label = ''
						local provjera = false
						if globalplate ~= nil or globalplate ~= "" or globalplate ~= " " then
							ESX.TriggerServerCallback('stage:ProvjeriVozilo',function(st)
								if st ~= 0 then
									if st.kvar == 1 then
										price = math.floor(vehiclePrice * 0.20)
										_label = 'Popravak mjenjaca'..' - <span style="color:green;">$' .. price .. ' </span>'
										table.insert(elements, {label = _label, modType = k, modNum = 1})
									elseif st.kvar == 2 then
										price = math.floor(vehiclePrice * 0.10)
										_label = 'Popravak pregrijavanja'..' - <span style="color:green;">$' .. price .. ' </span>'
										table.insert(elements, {label = _label, modType = k, modNum = 2})
									elseif st.kvar == 3 then
										price = math.floor(vehiclePrice * 0.15)
										_label = 'Popravak pumpe goriva'..' - <span style="color:green;">$' .. price .. ' </span>'
										table.insert(elements, {label = _label, modType = k, modNum = 3})
									elseif st.kvar == 4 then
										price = math.floor(vehiclePrice * 0.05)
										_label = 'Zamjena akumulatora'..' - <span style="color:green;">$' .. price .. ' </span>'
										table.insert(elements, {label = _label, modType = k, modNum = 4})
									end
								end
								provjera = true
							end, globalplate)
						end
						while not provjera do
							Wait(100)
						end
					elseif v.modType == 'dodaci' then
						local globalplate  = ESX.Math.Trim(GetVehicleNumberPlateText(vehicle))
						local _label = ''
						price = 50
						if globalplate ~= nil or globalplate ~= "" or globalplate ~= " " then
							for i = 1, 14 do
								if DoesExtraExist(vehicle, i) then
									if IsVehicleExtraTurnedOn(vehicle, i) then
										_label = 'Dodatak #'..i..' - <span style="color:cornflowerblue;">'.. 'instalirano' ..' $'..price..'</span>'
										table.insert(elements, {label = _label, modType = k, modNum = i, odradi = true})
									else
										_label = 'Dodatak #'..i..' - <span style="color:green;">$' .. price .. ' </span>'
										table.insert(elements, {label = _label, modType = k, modNum = i, odradi = false})
									end
								end
							end
						end
					elseif v.modType == 'windowTint' then -- WINDOWS TINT
						for j = 1, 5, 1 do
							local _label = ''
							if j == currentMods.modHorns then
								_label = "["..j.."] "..GetWindowName(j) .. ' - <span style="color:cornflowerblue;">'.. _U(lime) ..'</span>'
							else
								price = math.floor((vehiclePrice * v.price / 800)*1.30)
								_label = "["..j.."] "..GetWindowName(j) .. ' - <span style="color:green;">$' .. price .. ' </span>'
							end
							table.insert(elements, {label = _label, modType = k, modNum = j})
						end
					elseif v.modType == 23 then -- WHEELS RIM & TYPE
						local props = {}

						props['wheels'] = v.wheelType
						ESX.Game.SetVehicleProperties(vehicle, props)

						local modCount = GetNumVehicleMods(vehicle, v.modType)
						for j = 0, modCount, 1 do
							local modName = GetModTextLabel(vehicle, v.modType, j)
							if modName ~= nil then
								local _label = ''
								if j == currentMods.modFrontWheels and v.wheelType == currentMods.wheels then
									_label = "["..(j+1).."] "..GetLabelText(modName) .. ' - <span style="color:cornflowerblue;">'.. _U(lime) ..'</span>'
								else
									price = math.floor(vehiclePrice * v.price / 800)
									_label = "["..(j+1).."] "..GetLabelText(modName) .. ' - <span style="color:green;">$' .. price*1.30 .. ' </span>'
								end
								table.insert(elements, {label = _label, modType = 'modFrontWheels', modNum = j, wheelType = v.wheelType, price = v.price})
							end
						end
					elseif v.modType == 11 or v.modType == 12 or v.modType == 13 or v.modType == 15 or v.modType == 16 then
						SetVehicleModKit(vehicle, 0)
						local modCount = GetNumVehicleMods(vehicle, v.modType) -- UPGRADES
						if modCount > 0 then
							for j = 0, modCount, 1 do
								local _label = ''
								if j == currentMods[k] then
									_label = _U('level', j+1) .. ' - <span style="color:cornflowerblue;">'.. _U(lime) ..'</span>'
								else
									if v.price[j+1] == nil then
										v.price[j+1] = v.price[j]+30
									end
									price = math.floor((vehiclePrice * v.price[j+1] / 800)*1.30)
									_label = _U('level', j+1) .. ' - <span style="color:green;">$' .. price .. ' </span>'
								end
								table.insert(elements, {label = _label, modType = k, modNum = j})
								if j == modCount-1 then
									break
								end
							end
						end
					elseif v.modType == 17 then -- TURBO
						local _label = ''
						if currentMods[k] then
							_label = 'Turbo - <span style="color:cornflowerblue;">'.. _U(lime) ..'</span>'
						else
							_label = 'Turbo - <span style="color:green;">$' .. math.floor((vehiclePrice * v.price[1] / 800)*1.30) .. ' </span>'
						end
						table.insert(elements, {label = _label, modType = k, modNum = true})
					else
						local modCount = GetNumVehicleMods(vehicle, v.modType) -- BODYPARTS
						for j = 0, modCount, 1 do
							local modName = GetModTextLabel(vehicle, v.modType, j)
							if modName ~= nil then
								local _label = ''
								if j == currentMods[k] then
									_label = "["..(j+1).."] "..GetLabelText(modName) .. ' - <span style="color:cornflowerblue;">'.. _U(lime) ..'</span>'
								else
									price = math.floor((vehiclePrice * v.price / 800)*1.30)
									_label = "["..(j+1).."] "..GetLabelText(modName) .. ' - <span style="color:green;">$' .. price .. ' </span>'
								end
								table.insert(elements, {label = _label, modType = k, modNum = j})
							end
						end
					end
				else
					if data.value == 'svijetlaColor' then
						for j=1, 12, 1 do
							price = math.floor((vehiclePrice * 1.10 / 800)*1.30)
							if j == 1 then
								local ime = GetSvijetla(-1)
								_label = ime .. ' - <span style="color:green;">$' .. price .. ' </span>'
								if -1 == currentMods[k] then
									_label = "["..j.."] "..ime .. ' - <span style="color:cornflowerblue;">'.. _U(lime) ..'</span>'
								else
									_label = "["..j.."] "..ime .. ' - <span style="color:green;">$' .. price .. ' </span>'
								end
								table.insert(elements, {label = _label, modType = k, modNum = -1})
							else
								local ime = GetSvijetla(j-1)
								_label = ime .. ' - <span style="color:green;">$' .. price .. ' </span>'
								if j-1 == currentMods[k] then
									_label = "["..j.."] "..ime .. ' - <span style="color:cornflowerblue;">'.. _U(lime) ..'</span>'
								else
									_label = "["..j.."] "..ime .. ' - <span style="color:green;">$' .. price .. ' </span>'
								end
								table.insert(elements, {label = _label, modType = k, modNum = j-1})
							end
						end
					end
					if data.value == 'primaryRespray' or data.value == 'secondaryRespray' or data.value == 'pearlescentRespray' or data.value == 'modFrontWheelsColor' then
						for i=1, #Config.Colors, 1 do
							if data.value == 'primaryRespray' then
								table.insert(elements, {label = "["..i.."] "..Config.Colors[i].label, value = 'color1', color = Config.Colors[i].value})
							elseif data.value == 'secondaryRespray' then
								table.insert(elements, {label = "["..i.."] "..Config.Colors[i].label, value = 'color2', color = Config.Colors[i].value})
							elseif data.value == 'pearlescentRespray' then
								table.insert(elements, {label = "["..i.."] "..Config.Colors[i].label, value = 'pearlescentColor', color = Config.Colors[i].value})
							elseif data.value == 'modFrontWheelsColor' then
								table.insert(elements, {label = "["..i.."] "..Config.Colors[i].label, value = 'wheelColor', color = Config.Colors[i].value})
							end
						end
					else
						for l,w in pairs(v) do
							if l ~= 'label' and l ~= 'parent' then
								if PlayerData.job ~= nil and PlayerData.job.name == 'mechanic' then
									if GetPedInVehicleSeat(vehicle, 0) == playerPed then
										table.insert(elements, {label = w, value = l})
									elseif GetPedInVehicleSeat(vehicle, -1) == playerPed then
										if l ~= "zavrsi" and l ~= "popravak" then
											table.insert(elements, {label = w, value = l})
										end
									end
								else
									if l ~= "zavrsi" and l ~= "popravak" then
										table.insert(elements, {label = w, value = l})
									end
								end
							end
						end
					end
				end
				break
			end
		end

		table.sort(elements, function(a, b)
			return a.label < b.label
		end)
		if PlayerData.job ~= nil and PlayerData.job.name == 'mechanic' then
			if GetPedInVehicleSeat(vehicle, 0) == playerPed then
				if not IsVehicleSeatFree(vehicle, -1) then
					OpenLSMenu2(elements, menuName, menuTitle, parent)
				else
					ESX.ShowNotification("Vlasnik vozila mora biti na vozacevom mjestu!")
				end
			elseif GetPedInVehicleSeat(vehicle, -1) == playerPed then
				OpenLSMenu(elements, menuName, menuTitle, parent)
			end
		else
			OpenLSMenu(elements, menuName, menuTitle, parent)
		end
	end
end

-- Blips
-- Citizen.CreateThread(function()
-- 	for k,v in pairs(Config.Zones) do
-- 		if v.PBlip == 1 then
-- 			local blip = AddBlipForCoord(v.Pos.x, v.Pos.y, v.Pos.z)
-- 			SetBlipSprite(blip, 72)
-- 			SetBlipScale(blip, 0.8)
-- 			SetBlipAsShortRange(blip, true)
-- 			BeginTextCommandSetBlipName("STRING")
-- 			AddTextComponentString(v.Name)
-- 			EndTextCommandSetBlipName(blip)
-- 		end
-- 	end
-- end)

-- Activate menu when player is inside marker
Citizen.CreateThread(function()
	local waitara = 500
	while true do
		Citizen.Wait(waitara)
		local naso = 0
		local playerPed = PlayerPedId()
		if IsPedInAnyVehicle(playerPed, false) then
			local coords      = GetEntityCoords(PlayerPedId())
			local vehicle = GetVehiclePedIsIn(playerPed, false)
			local currentZone = nil
			local zone 		  = nil
			local lastZone    = nil
			-- --if (PlayerData.job ~= nil and PlayerData.job.name == 'mechanic') or Config.IsMechanicJobOnly == false then
			-- 	for k,v in pairs(Config.Zones) do
			-- 		if (GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) and lsMenuIsShowed == false then
			-- 			if GetPedInVehicleSeat(vehicle, -1) == playerPed then
			-- 				naso = 1
			-- 				waitara = 0
			-- 				isInLSMarker  = true
			-- 				ESX.ShowHelpNotification(v.Hint)
			-- 			elseif GetPedInVehicleSeat(vehicle, 0) == playerPed then
			-- 				if PlayerData.job ~= nil and PlayerData.job.name == 'mechanic' then
			-- 					naso = 1
			-- 					waitara = 0
			-- 					isInLSMarker  = true
			-- 					ESX.ShowHelpNotification(v.Hint)
			-- 				end
			-- 			end
			-- 			break
			-- 		else
			-- 			isInLSMarker  = false
			-- 		end
			-- 	end
			-- --end

			if PlayerData.job ~= nil and PlayerData.job.name == 'mechanic' then
				for k,v in pairs(Config.Narudzbe) do
					if #(coords-v.Pos) < v.Size.x and lsMenuIsShowed == false then
						naso = 1
						waitara = 0
						TrenutniTune = v
						isInLSMarker2  = true
						ESX.ShowHelpNotification("Pritisnite ~INPUT_PICKUP~ da vidite opcije")
						break
					else
						isInLSMarker2  = false
					end
				end
			end

			if IsControlJustReleased(0, Keys['E']) and not lsMenuIsShowed then
				if isInLSMarker then
					if GetPedInVehicleSeat(vehicle, 0) == playerPed then
						if PlayerData.job ~= nil and PlayerData.job.name == 'mechanic' then
							if not IsVehicleSeatFree(vehicle, -1) then
								lsMenuIsShowed = true

								FreezeEntityPosition(vehicle, true)

								myCar = ESX.Game.GetVehicleProperties(vehicle)
								Narudzba = {}
								ESX.UI.Menu.CloseAll()
								GetAction({value = 'main'})
							else
								ESX.ShowNotification("Vlasnik vozila mora biti na vozacevom mjestu!")
							end
						end
					elseif GetPedInVehicleSeat(vehicle, -1) == playerPed then
						lsMenuIsShowed = true

						FreezeEntityPosition(vehicle, true)

						myCar = ESX.Game.GetVehicleProperties(vehicle)
						Narudzba = {}
						ESX.UI.Menu.CloseAll()
						GetAction({value = 'main'})
					end
				else
					FreezeEntityPosition(vehicle, false)
				end
				if isInLSMarker2 then
					--if GetPedInVehicleSeat(GetVehiclePedIsIn(playerPed, false), -1) == playerPed then
						lsMenuIsShowed = true
						myCar = ESX.Game.GetVehicleProperties(vehicle)
						ESX.UI.Menu.CloseAll()
						OpenIzborMenu()
						--OtvoriNarudzbu(myCar.plate)
					--end
				else
					FreezeEntityPosition(vehicle, false)
				end
			end

			if isInLSMarker and not hasAlreadyEnteredMarker then
				hasAlreadyEnteredMarker = true
			end

			if not isInLSMarker and hasAlreadyEnteredMarker then
				hasAlreadyEnteredMarker = false
			end

		end
		if naso == 0 then
			waitara = 500
		end
	end
end)

function OpenIzborMenu()
	local elems = {}
	table.insert(elems, {label = "Narucivanje dijelova", value = "narucivanje"})
	table.insert(elems, {label = "Ugradnja dijelova", value = "ugradnja"})
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), "menu_izbnar",
	{
		title    = "Izaberite opciju",
		align    = 'top-left',
		elements = elems
	}, function(data, menu)
		if data.current.value == "narucivanje" then
			isInLSMarker  = true
			local playerPed = PlayerPedId()
			local vehicle = GetVehiclePedIsIn(playerPed, false)
			if GetPedInVehicleSeat(vehicle, 0) == playerPed then
				if PlayerData.job ~= nil and PlayerData.job.name == 'mechanic' then
					if not IsVehicleSeatFree(vehicle, -1) then
						lsMenuIsShowed = true

						FreezeEntityPosition(vehicle, true)

						myCar = ESX.Game.GetVehicleProperties(vehicle)
						Narudzba = {}
						ESX.UI.Menu.CloseAll()
						GetAction({value = 'main'})
					else
						ESX.ShowNotification("Vlasnik vozila mora biti na vozacevom mjestu!")
					end
				end
			elseif GetPedInVehicleSeat(vehicle, -1) == playerPed then
				lsMenuIsShowed = true

				FreezeEntityPosition(vehicle, true)

				myCar = ESX.Game.GetVehicleProperties(vehicle)
				Narudzba = {}
				ESX.UI.Menu.CloseAll()
				GetAction({value = 'main'})
			end
		elseif data.current.value == "ugradnja" then
			isInLSMarker2 = true
			local playerPed = PlayerPedId()
			local vehicle = GetVehiclePedIsIn(playerPed, false)
			if GetPedInVehicleSeat(GetVehiclePedIsIn(playerPed, false), -1) == playerPed then
				lsMenuIsShowed = true
				myCar = ESX.Game.GetVehicleProperties(vehicle)
				ESX.UI.Menu.CloseAll()
				OtvoriNarudzbu(myCar.plate)
			else
				ESX.ShowNotification("Morate biti vozac!")
			end
		end
	end, function(data, menu)
		menu.close()
		lsMenuIsShowed = false
	end)
end

function OtvoriNarudzbu(tablica)
	ESX.TriggerServerCallback('meh:DohvatiNarudzbu',function(nar)
		if nar ~= 0 then
			local elems = {}
			if nar.min < 10 then
				table.insert(elems, {label = "Dijelovi dolaze za "..(10-nar.min).." minuta", value = "err"})
			else
				table.insert(elems, {label = "Izlistaj dijelove", value = "dijelovi"})
			end
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), "menu_nar2",
			{
				title    = "Narudzba",
				align    = 'top-left',
				elements = elems
			}, function(data, menu)
				if data.current.value == "dijelovi" then
					local dijelovi = json.decode(nar.narudzba)
					menu.close()
					local elems2 = {}
					for i=1, #dijelovi, 1 do
						table.insert(elems2, {label = dijelovi[i].label, modType = dijelovi[i].modType, modNum = dijelovi[i].modNum, wheelType = dijelovi[i].wheelType})
					end
					ESX.UI.Menu.Open('default', GetCurrentResourceName(), "menu_nar3",
					{
						title    = "Lista dijelova",
						align    = 'top-left',
						elements = elems2
					}, function(data2, menu2)
						--lsMenuIsShowed = false
						menu2.close()
						UpdateMods2(nar, data2.current)
						--TriggerServerEvent("narudzbe:MakniDio", nar, data2.current.modType)
					end, function(data2, menu2)
						menu2.close()
						lsMenuIsShowed = false
					end)
				else
					lsMenuIsShowed = false
					menu.close()
				end
			end, function(data, menu)
				menu.close()
				lsMenuIsShowed = false
			end)
		else
			lsMenuIsShowed = false
			ESX.ShowNotification("Ovo vozilo nema narudzbu.")
		end
	end, tablica)
end

RegisterNetEvent('baseevents:enteredVehicle')
AddEventHandler('baseevents:enteredVehicle', function(currentVehicle, currentSeat, modelName, netId)
	local globalplate  = ESX.Math.Trim(GetVehicleNumberPlateText(currentVehicle))
	if currentSeat == -1 then
		if globalplate ~= nil or globalplate ~= "" or globalplate ~= " " then
			ESX.TriggerServerCallback('stage:ProvjeriVozilo',function(st)
				gDragCoef = GetVehicleHandlingFloat(currentVehicle, 'CHandlingData', 'fInitialDragCoeff')
				gFlatVel = GetVehicleHandlingFloat(currentVehicle, 'CHandlingData', 'fInitialDriveMaxFlatVel')
				if st ~= 0 then
					local drag = 8
					local speed = 0.4
					if st.stage == 1 then
						drag = 8-2
						speed = 0.3
					elseif st.stage == 2 then
						drag = 8-4
						speed = 0.2
					elseif st.stage == 3 then
						drag = 8-6
						speed = 0.1
					elseif st.stage == 4 then
						drag = 0
						speed = 0.0
					end
					local br = gDragCoef+drag
					local br2 = gFlatVel-(gFlatVel*speed)
					print(GetVehicleHandlingFloat(currentVehicle, 'CHandlingData', 'fInitialDragCoeff'))
					--SetVehicleHandlingFloat(GetVehiclePedIsIn(PlayerPedId(), false), 'CHandlingData', 'fInitialDriveMaxFlatVel',139.20) --stage 3 -20.0
					--SetVehicleHandlingFloat(GetVehiclePedIsIn(PlayerPedId(), false), 'CHandlingData', 'fInitialDriveMaxFlatVel',129.20) --stage 2 -10.0
					--SetVehicleHandlingFloat(GetVehiclePedIsIn(PlayerPedId(), false), 'CHandlingData', 'fInitialDriveMaxFlatVel', 119.20) --stage 1 -10.0
					SetVehicleHandlingFloat(currentVehicle, 'CHandlingData', 'fInitialDragCoeff', br) --stage 0 -10.0
					SetVehicleHandlingFloat(currentVehicle, 'CHandlingData', 'fInitialDriveMaxFlatVel', br2)
					--SetVehicleHandlingFloat(GetVehiclePedIsIn(PlayerPedId(), false), 'CHandlingData', 'fInitialDriveForce', 0.24) --stage 0 -10.0
					ModifyVehicleTopSpeed(currentVehicle, 16.11)
					print(GetVehicleHandlingFloat(currentVehicle, 'CHandlingData', 'fInitialDragCoeff'))
					if st.motor ~= nil then
						ForceVehicleEngineAudio(currentVehicle, st.motor)
						Citizen.Wait(200)
						if currentradio ~= 255 then
							SetRadioToStationIndex(currentradio)
						else
							SetRadioToStationName("OFF")
						end
						local netid = VehToNet(currentVehicle)
						TriggerServerEvent("vozila:PromjeniZvuk", GetPlayerServerId(PlayerId()), netid, st.motor)
						local DragCoef = GetVehicleHandlingFloat(currentVehicle, 'CHandlingData', 'fInitialDragCoeff')
						local FlatVel = GetVehicleHandlingFloat(currentVehicle, 'CHandlingData', 'fInitialDriveMaxFlatVel')
						if DragCoef >= 20.0 then
							drag = DragCoef*0.7
							speed = 1.4
						end
						if DragCoef < 20.0 and DragCoef > 10.0 then
							drag = DragCoef*0.3
							speed = 0.4
						end
						if DragCoef <= 10.0 and DragCoef > 6.0 then
							drag = DragCoef*0.1
							speed = 0.1
						end
						if DragCoef <= 6.0 then
							drag = DragCoef*0.02
							speed = 0.02
						end
						br = DragCoef-drag
						br2 = FlatVel+(FlatVel*speed)
						--print(GetVehicleHandlingFloat(currentVehicle, 'CHandlingData', 'fInitialDragCoeff'))
						--print(GetVehicleHandlingFloat(currentVehicle, 'CHandlingData', 'fInitialDriveMaxFlatVel'))
						SetVehicleHandlingFloat(currentVehicle, 'CHandlingData', 'fInitialDragCoeff', br)
						SetVehicleHandlingFloat(currentVehicle, 'CHandlingData', 'fInitialDriveMaxFlatVel', br2)
						ModifyVehicleTopSpeed(currentVehicle, 16.11)
						--print(GetVehicleHandlingFloat(currentVehicle, 'CHandlingData', 'fInitialDragCoeff'))
						--print(GetVehicleHandlingFloat(currentVehicle, 'CHandlingData', 'fInitialDriveMaxFlatVel'))
					end
				end
			end, globalplate)
		end
	end
end)

RegisterNetEvent('vozila:NoviZvuk')
AddEventHandler('vozila:NoviZvuk', function(id, netid, zvuk)
	if GetPlayerServerId(PlayerId()) ~= id then
		Wait(500)
		if NetworkDoesEntityExistWithNetworkId(netid) then
			local vehicle = NetToVeh(netid)
			ForceVehicleEngineAudio(vehicle, zvuk)
		end
	end
end)

RegisterNetEvent('baseevents:leftVehicle')
AddEventHandler('baseevents:leftVehicle', function(currentVehicle, currentSeat, modelName, netId)
	if currentSeat == -1 then
		--print(GetVehicleHandlingFloat(currentVehicle, 'CHandlingData', 'fInitialDragCoeff'))
		--SetVehicleHandlingFloat(GetVehiclePedIsIn(PlayerPedId(), false), 'CHandlingData', 'fInitialDriveMaxFlatVel',139.20) --stage 3 -20.0
		--SetVehicleHandlingFloat(GetVehiclePedIsIn(PlayerPedId(), false), 'CHandlingData', 'fInitialDriveMaxFlatVel',129.20) --stage 2 -10.0
		--SetVehicleHandlingFloat(GetVehiclePedIsIn(PlayerPedId(), false), 'CHandlingData', 'fInitialDriveMaxFlatVel', 119.20) --stage 1 -10.0
		SetVehicleHandlingFloat(currentVehicle, 'CHandlingData', 'fInitialDragCoeff', gDragCoef) --stage 0 -10.0
		SetVehicleHandlingFloat(currentVehicle, 'CHandlingData', 'fInitialDriveMaxFlatVel', gFlatVel)
		--SetVehicleHandlingFloat(GetVehiclePedIsIn(PlayerPedId(), false), 'CHandlingData', 'fInitialDriveForce', 0.24) --stage 0 -10.0
		ModifyVehicleTopSpeed(currentVehicle, 16.11)
		--print(GetVehicleHandlingFloat(currentVehicle, 'CHandlingData', 'fInitialDragCoeff'))
		gDragCoef = 0
		gFlatVel = 0
	end
end)

-- Prevent Free Tunning Bug
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if lsMenuIsShowed then
			DisableControlAction(2, Keys['F1'], true)
			DisableControlAction(2, Keys['F2'], true)
			DisableControlAction(2, Keys['F3'], true)
			DisableControlAction(2, Keys['F6'], true)
			DisableControlAction(2, Keys['F7'], true)
			DisableControlAction(2, Keys['F'], true)
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle
		else
			Citizen.Wait(500)
		end
	end
end)
