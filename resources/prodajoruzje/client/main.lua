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

local Oruzje					= nil
local Cijena 					= 0
local Prodavac					= nil
local Metci 					= 0
local GUI                       = {}
GUI.Time                        = 0

local CijenaDroge 				= 0
local Kolicina 					= 0
local Prodavac2 				= nil
local perm 						= 0

local HasAlreadyEnteredMarker   = false
local LastStation               = nil
local LastPart                  = nil
local LastPartNum               = nil
local CurrentAction             = nil
local CurrentActionMsg          = ''
local CurrentActionData         = {}
local aduty 					= false

local defaultScale = 0.5 -- Text scale
local color = { r = 230, g = 230, b = 230, a = 255 } -- Text color
local font = 0 -- Text font
local displayTime = 5000 -- Duration to display the text (in ms)
local distToDraw = 250 -- Min. distance to draw 
local pedDisplaying = {}

local disabled            = false
local UVozilu 			  = false
local Sjedalo 			  = nil
local Vozilo = nil

local PlayerData                = {}
local lastVehicle = nil
local lastOpen = false
local vehiclePlate = {}
local arrayWeight = {}
local CloseToVehicle = false
local entityWorld = nil
local globalplate = nil
local GPSID 	  = 1
local inTrunk = false

local dan, mjesec, god, sat, min = nil

ESX                             = nil

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
  while ESX.GetPlayerData().job == nil do
	Citizen.Wait(100)
  end
  ProvjeriPosao()
end)

RegisterNetEvent('esx:SjelaPlaca')
AddEventHandler('esx:SjelaPlaca', function()
	local porez = 0
	--kuca
	ESX.TriggerServerCallback('loaf_housing:ImalKucu', function(br)
		if br then
			porez = porez+1
		end
	end)
	--trgovine
	ESX.TriggerServerCallback('esx_firme:DajBrojTrgovina', function(br)
		porez = porez+br
	end)
	--Gunshopovi
	ESX.TriggerServerCallback('esx_gun:DajBrojTrgovina', function(br)
		porez = porez+br
	end)
	--Pumpe
	ESX.TriggerServerCallback('pumpe:DajBrojPumpi', function(br)
		porez = porez+br
	end)
	--Praone
	ESX.TriggerServerCallback('praone:DajBrojPraona', function(br)
		porez = porez+br
	end)
	--Vozila
	ESX.TriggerServerCallback('garaza:DajBrojVozila', function(br)
		porez = porez+br
	end)
	Citizen.Wait(2000)
	if porez > 0 then
		TriggerServerEvent("prodajoruzje:PlatiPorez", porez)
	end
end)

local radioname = "RADIO_22_DLC_BATTLE_MIX1_RADIO" -- radio to replace with your own | pastebin.com/Kj9t38KF <-- full list of radio names
local volume = GetProfileSetting(306) / 100
local previousVolume = volume

local count = 0
-- Key controls
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
	if CloseToVehicle then
		local pos = GetEntityCoords(GetPlayerPed(-1))
		local vehicle = GetClosestVehicle(pos['x'], pos['y'], pos['z'], 2.0, 0, 70)
		if DoesEntityExist(vehicle) then
			CloseToVehicle = true
		else
			TriggerServerEvent('gepeke:RemoveVehicleList', globalplate)
			CloseToVehicle = false
			lastOpen = false
			ESX.UI.Menu.CloseAll()
			--SetVehicleDoorShut(lastVehicle, 5, false)
		end
	end
	if inTrunk then
        local vehicle = GetEntityAttachedTo(PlayerPedId())
        if DoesEntityExist(vehicle) or not IsPedDeadOrDying(PlayerPedId()) or not IsPedFatallyInjured(PlayerPedId()) then
            local coords = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, 'boot'))
            SetEntityCollision(PlayerPedId(), false, false)

            if GetVehicleDoorAngleRatio(vehicle, 5) < 0.9 then
				SetEntityVisible(PlayerPedId(), false, false)
            else
                if not IsEntityPlayingAnim(PlayerPedId(), 'timetable@floyd@cryingonbed@base', 3) then
                    loadDict('timetable@floyd@cryingonbed@base')
                    TaskPlayAnim(PlayerPedId(), 'timetable@floyd@cryingonbed@base', 'base', 8.0, -8.0, -1, 1, 0, false, false, false)

                    SetEntityVisible(PlayerPedId(), true, false)
                end
            end
            if IsControlJustReleased(0, 38) and inTrunk then
                SetCarBootOpen(vehicle)
                SetEntityCollision(PlayerPedId(), true, true)
                Wait(750)
                inTrunk = false
                DetachEntity(PlayerPedId(), true, true)
                SetEntityVisible(PlayerPedId(), true, false)
                ClearPedTasks(PlayerPedId())
                SetEntityCoords(PlayerPedId(), GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, -0.5, -0.75))
                Wait(250)
                SetVehicleDoorShut(vehicle, 5)
            end
        else
            SetEntityCollision(PlayerPedId(), true, true)
            DetachEntity(PlayerPedId(), true, true)
            SetEntityVisible(PlayerPedId(), true, false)
            ClearPedTasks(PlayerPedId())
            SetEntityCoords(PlayerPedId(), GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, -0.5, -0.75))
        end
    end
    if lastOpen and IsControlPressed(0, Keys["BACKSPACE"]) and (GetGameTimer() - GUI.Time) > 150 then
	  CloseToVehicle = false
      lastOpen = false
      if lastVehicle > 0 then
      	--SetVehicleDoorShut(lastVehicle, 5, false)
		local lastvehicleplatetext = GetVehicleNumberPlateText(lastVehicle)
		TriggerServerEvent('gepeke:RemoveVehicleList', lastvehicleplatetext)
      	lastVehicle = 0
      end
      GUI.Time  = GetGameTimer()
    end
  end
end)

RegisterNetEvent('baseevents:enteredVehicle')
AddEventHandler('baseevents:enteredVehicle', function(currentVehicle, currentSeat, modelName, netId)
	UVozilu = true
	Sjedalo = currentSeat
	Vozilo = currentVehicle
	ESX.TriggerServerCallback('bomba:ProvjeriVozilo', function(ima)
		if ima then
			while not IsVehicleEngineStarting(currentVehicle) do
				Wait(100)
			end
			DetonateVehicle(currentVehicle)
			TriggerServerEvent("bomba:MakniVozilo", GetVehicleNumberPlateText(currentVehicle))
		end
	end, GetVehicleNumberPlateText(currentVehicle))
	if Sjedalo == 0 then
		Citizen.CreateThread(function ()
			while UVozilu do
				Citizen.Wait(0)
				if not disabled then
					local veh = Vozilo
					if Sjedalo == 0 then
						local ped = PlayerPedId()
						if not GetIsTaskActive(ped, 164) and GetIsTaskActive(ped, 165) then
							local veh = Vozilo
							local angle = GetVehicleDoorAngleRatio(veh, 1)
							if angle ~= 0.0 then
								SetVehicleDoorControl(veh, 1, 1, 0.0)
							end
							SetPedIntoVehicle(PlayerPedId(), veh, 0)
						end
					end
				end
			end
		end)
	end
	Citizen.CreateThread(function ()
		while UVozilu do
			Citizen.Wait(100)
			SetRadioTrack(radioname, 255)
			if IsPlayerVehicleRadioEnabled() and GetPlayerRadioStationName()==radioname and not wasenabled then
				SendNuiMessage(json.encode({type="enable",state=true}))
				SendNuiMessage(json.encode({type="volume",volume=volume}))
				SetAudioFlag("FrontendRadioDisabled", true)
			elseif (not IsPlayerVehicleRadioEnabled() or GetPlayerRadioStationName()~=radioname) and wasenabled then
				SendNuiMessage(json.encode({type="enable",state=false}))
				SetAudioFlag("FrontendRadioDisabled", false)
			end
			local volume = GetProfileSetting(306)/100
			if previousVolume ~= volume then
				SendNuiMessage(json.encode({type="volume",volume=volume}))
				previousVolume = volume
			end
			wasenabled = IsPlayerVehicleRadioEnabled() and GetPlayerRadioStationName()==radioname
		end
	end)
	if GetVehicleClass(Vozilo) == 18 then
		ModifyVehicleTopSpeed(GetVehiclePedIsIn(Vozilo, false), 70.0)
	end
end)

RegisterNetEvent('baseevents:leftVehicle')
AddEventHandler('baseevents:leftVehicle', function(currentVehicle, currentSeat, modelName, netId)
	UVozilu = false
	Sjedalo = nil
	Vozilo = nil
end)

function RunTimer(veh)
    timer = Config.TimeUntilDetonation
    while timer > 0 do
        timer = timer - 1
        Citizen.Wait(1000)
        if timer == 0 then
            DetonateVehicle(veh)
        end
    end
end

function DetonateVehicle(veh)
    if DoesEntityExist(veh) then
		NetworkExplodeVehicle(veh, true, false, false)
    end
end

function ShowNotification( text )
    SetNotificationTextEntry( "STRING" )
    AddTextComponentString( text )
    DrawNotification( false, false )
end

function FastMythticProg(message, time)
    exports['mythic_progbar']:Progress({
		name = "tint",
		duration = time,
		label = message,
		useWhileDead = false,
		canCancel = false,
		controlDisables = {
			disableMovement = true,
			disableCarMovement = true,
			disableMouse = false,
			disableCombat = true,
		},
	}, function(cancelled)
        if not cancelled then
            
		else
			Citizen.Wait(1000)
		end
	end)
end

exports.qtarget:AddTargetModel({-206690185, 1511880420, 682791951}, {
	options = {
		{
			event = "kontenjer:Pretrazi",
			icon = "fas fa-box-circle-check",
			label = "Pretrazi kontenjer"
		}
	},
	distance = 1
})

AddEventHandler('kontenjer:Pretrazi', function(data)
	local koord = GetEntityCoords(data.entity)
	ESX.TriggerServerCallback('prodajoruzje:ProvjeriKontenjer',function(morel)
		if morel == true then
			TriggerServerEvent("prodajoruzje:DajKontenjer", koord)
			FreezeEntityPosition(PlayerPedId(), true)
			ESX.Streaming.RequestAnimDict("anim@amb@clubhouse@tutorial@bkr_tut_ig3@", function()
				TaskPlayAnim(PlayerPedId(),"anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 8.0, 8.0, -1, 50)
			end)
			Wait(5000)
			ClearPedTasksImmediately(PlayerPedId())
			FreezeEntityPosition(PlayerPedId(), false)
			--ESX.ShowNotification("Pronasli ste kurac")
			TriggerServerEvent("kont:DajItema")
		elseif morel == false then
			ESX.ShowNotification("Ovaj kontenjer je prazan!")
		else
			ESX.ShowNotification("Nemate sarafciger!")
		end
	end, koord)
end)

RegisterCommand("auredi", function(source, args, raw)
	if perm == 1 then
		local elements = {}
		table.insert(elements, {label = 'Uredi kuce', value = "kuce"})
		table.insert(elements, {label = 'Uredi firme', value = "firme"})
		table.insert(elements, {label = 'Uredi droge', value = "droge"})
		table.insert(elements, {label = 'Uredi safe zone', value = "szone"})
		table.insert(elements, {label = 'Uredi mafija zone', value = "mzone"})
		table.insert(elements, {label = 'Uredi kljucanje vrata', value = "kvrata"})
		table.insert(elements, {label = 'Uredi rent', value = "urent"})
		table.insert(elements, {label = 'Uredi pumpe', value = "pumpe"})
		table.insert(elements, {label = 'Uredi mafije', value = "mafije"})
		table.insert(elements, {label = 'Uredi biznise', value = "biznisi"})
		table.insert(elements, {label = 'Uredi praone', value = "praone"})
		table.insert(elements, {label = 'Uredi bankomate', value = "atm"})

		ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'auredi',
		{
			title    = "Izaberite uredjivanje",
			align    = 'top-left',
			elements = elements,
		},
		function(data, menu)
			menu.close()
			if data.current.value == "kuce" then
				ExecuteCommand("uredikuce")
			elseif data.current.value == "firme" then
				ExecuteCommand("uredifirmu")
			elseif data.current.value == "droge" then
				ExecuteCommand("uredidroge")
			elseif data.current.value == "szone" then
				ExecuteCommand("uredisafezonu")
			elseif data.current.value == "mzone" then
				ExecuteCommand("uredizone")
			elseif data.current.value == "kvrata" then
				ExecuteCommand("uredivrata")
			elseif data.current.value == "urent" then
				ExecuteCommand("uredirent")
			elseif data.current.value == "pumpe" then
				ExecuteCommand("uredipumpe")
			elseif data.current.value == "mafije" then
				ExecuteCommand("uredimafiju")
			elseif data.current.value == "biznisi" then
				ExecuteCommand("uredibiznise")
			elseif data.current.value == "praone" then
				ExecuteCommand("uredipraone")
			elseif data.current.value == "atm" then
				ExecuteCommand("urediatm")
			end
		end,
		function(data, menu)
			menu.close()
		end
		)
	else
		ESX.ShowNotification("Niste admin!")
	end
end)

function GetPedVehicleSeat(ped)
    local vehicle = GetVehiclePedIsIn(ped, false)
    for i=-2,GetVehicleMaxNumberOfPassengers(vehicle) do
        if(GetPedInVehicleSeat(vehicle, i) == ped) then return i end
    end
    return -2
end

RegisterNetEvent('vozila:NoviZvuk')
AddEventHandler('vozila:NoviZvuk', function(id, netid, zvuk)
	if GetPlayerServerId(PlayerId()) ~= id then
		Wait(500)
		if NetworkDoesEntityExistWithNetworkId(netid) then
			print("postojim")
			local vehicle = NetToVeh(netid)
			ForceVehicleEngineAudio(vehicle, zvuk)
		end
	end
end)

RegisterCommand("prebaci", function()
    Citizen.CreateThread(function()
        disabled = true
        Wait(3000)
        disabled = false
		Sjedalo = GetPedVehicleSeat(PlayerPedId())
		if Sjedalo == -1 then
			TriggerEvent("gameEventTriggered", "CEventNetworkPlayerEnteredVehicle", {128, GetVehiclePedIsIn(PlayerPedId(), false)})
			local globalplate  = GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId(), false))
			if globalplate ~= nil or globalplate ~= "" or globalplate ~= " " then
				ESX.TriggerServerCallback('mjenjac:ProvjeriVozilo',function(mj)
					TriggerEvent("EoTiIzSalona", mj)
				end, globalplate)
			end
			UVozilu = false
			Wait(200)
			UVozilu = true
		end
    end)
end)

TriggerEvent('chat:addSuggestion', '/prebaci', 'Koristite da se prebacite na vozacevo mjesto!')

local islandVec = vector3(4840.571, -5174.425, 2.0)
Citizen.CreateThread(function()
    while true do
		local pCoords = GetEntityCoords(GetPlayerPed(-1))		
		local distance1 = #(pCoords - islandVec)
		if distance1 < 2000.0 then
			SetIslandHopperEnabled("HeistIsland", true)  -- load the map and removes the city
			SetToggleMinimapHeistIsland(true) -- load the minimap/pause map and removes the city minimap/pause map
		else
			SetIslandHopperEnabled("HeistIsland", false)
			SetToggleMinimapHeistIsland(false)
		end
		Citizen.Wait(5000)
    end
end)

Citizen.CreateThread(function()
	local waitara = 500
	local id = PlayerId()
	local prikazo = false
    while true do
		if IsPlayerFreeAiming(id) then
			waitara = 1
			HideHudComponentThisFrame(1)  -- Wanted Stars
			HideHudComponentThisFrame(2)
			HideHudComponentThisFrame(3)  -- Cash
			HideHudComponentThisFrame(4)  -- MP Cash
			HideHudComponentThisFrame(6)  -- Vehicle Name
			HideHudComponentThisFrame(7)  -- Area Name
			HideHudComponentThisFrame(8)  -- Vehicle Class
			HideHudComponentThisFrame(9)  -- Street Name
			HideHudComponentThisFrame(13) -- Cash Change
			HideHudComponentThisFrame(17) -- Save Game
			HideHudComponentThisFrame(20) -- Weapon State
			if not prikazo then
				prikazo = true
				DisplayHud(true)
			end
		else
			waitara = 500
			if prikazo then
				prikazo = false
				DisplayHud(false)
			end
		end
		Citizen.Wait(waitara)
    end
end)

-- OBJ : draw text in 3d
-- PARAMETERS :
--      - coords : world coordinates to where you want to draw the text
--      - text : the text to display
local function DrawText3D2(coords, text)
    local camCoords = GetGameplayCamCoord()
    local dist = #(coords - camCoords)
    
    -- Experimental math to scale the text down
    local scale = 200 / (GetGameplayCamFov() * dist)

    --if onScreen then

        -- Format the text
        SetTextColour(color.r, color.g, color.b, color.a)
        SetTextScale(0.0, defaultScale * scale)
        SetTextDropshadow(0, 0, 0, 0, 55)
        SetTextDropShadow()
        SetTextCentre(true)

        -- Diplay the text
        BeginTextCommandDisplayText("STRING")
        AddTextComponentSubstringPlayerName(text)
        SetDrawOrigin(coords, 0)
        EndTextCommandDisplayText(0.0, 0.0)
        ClearDrawOrigin()

    --end
end

-- OBJ : handle the drawing of text above a ped head
-- PARAMETERS :
--      - coords : world coordinates to where you want to draw the text
--      - text : the text to display
local function Display(ped, text, koord)

    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local dist = #(playerCoords - koord)

    if dist <= distToDraw then

        pedDisplaying[ped] = (pedDisplaying[ped] or 1) + 1

        -- Timer
        local display = true

        Citizen.CreateThread(function()
            Wait(displayTime)
            display = false
        end)

        -- Display
        local offset = 0.8 + pedDisplaying[ped] * 0.1
        while display do
            if HasEntityClearLosToEntity(playerPed, ped, 17 ) then
                local x, y, z = table.unpack(GetEntityCoords(ped))
                z = z + offset
                DrawText3D2(vector3(x, y, z), text)
            end
            Wait(0)
        end

        pedDisplaying[ped] = pedDisplaying[ped] - 1

    end
end

-- --------------------------------------------
-- Event
-- --------------------------------------------

RegisterNetEvent('3dme:shareDisplay')
AddEventHandler('3dme:shareDisplay', function(text, serverId, koord)
    local ped = GetPlayerPed(GetPlayerFromServerId(serverId))
    Display(ped, text, koord)
end)

function ShowInfo(text)
	ESX.ShowNotification(text, 5000)
end

exports.qtarget:AddTargetBone({'boot'},{
	options = {
		{
			event = "gepek:Akcija",
			icon = "fas fa-truck-loading",
			label = "Otvori/zatvori gepek"
		},
	},
	distance = 2
})

RegisterNetEvent('gepek:Akcija')
AddEventHandler('gepek:Akcija', function(data)
	ExecuteCommand("gepek")
end)

RegisterCommand("gepek", function(source, args, raw)
    local ped = GetPlayerPed(-1)
    local veh = GetVehiclePedIsUsing(ped)
	local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
	local closecar = GetClosestVehicle(x, y, z, 4.0, 0, 71)
	local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(ped), GetEntityCoords(closecar), 1)
    local door = 5

    if IsPedInAnyVehicle(ped, false) then
        if GetVehicleDoorAngleRatio(veh, door) > 0 then
            SetVehicleDoorShut(veh, door, false)
        else	
            SetVehicleDoorOpen(veh, door, false, false)
        end
    else
        if closecar ~= nil and GetPedInVehicleSeat(closecar, -1) ~= GetPlayerPed(-1) and distanceToVeh <= 4.0 then
			local locked = GetVehicleDoorsLockedForPlayer(closecar, PlayerId())
            if GetVehicleDoorAngleRatio(closecar, door) > 0 then
                SetVehicleDoorShut(closecar, door, false)
            else
				if not locked then
					SetVehicleDoorOpen(closecar, door, false, false)
					TriggerEvent("gepeke:OtvoriGa", closecar)
				else
					ShowInfo("Vozilo je zakljucano.")
				end
            end
        else
            ShowInfo("Previse ste udaljeni od vozila.")
        end
    end
end)

RegisterNetEvent('gepeke:OtvoriGa')
AddEventHandler('gepeke:OtvoriGa', function(vehid)
    openmenuvehicle(vehid)
end)

function openmenuvehicle(vehid)
	local playerPed = GetPlayerPed(-1)
	local coords    = GetEntityCoords(playerPed)
	globalplate  = GetVehicleNumberPlateText(vehid)
	if globalplate ~= nil or globalplate ~= "" or globalplate ~= " " then
		local waitara = math.random(200, 800)
		Wait(waitara)
		ESX.TriggerServerCallback('esx_truck:checkvehicle',function(valid)
			if (not valid) then
				-- CloseToVehicle = true
				-- TriggerServerEvent('gepeke:AddVehicleList', globalplate)
				local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
				local closecar = vehid
				if closecar ~= nil and GetPedInVehicleSeat(closecar, -1) ~= GetPlayerPed(-1) then
					lastVehicle = closecar
					local model = GetDisplayNameFromVehicleModel(GetEntityModel(closecar))
					local locked = GetVehicleDoorsLockedForPlayer(closecar, PlayerId())
					local class = GetVehicleClass(closecar)
					ESX.UI.Menu.CloseAll()
					if ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'inventory') then
						--SetVehicleDoorShut(closecar, 5, false)
					else
						if not locked or class == 15 or class == 16 or class == 14 then
							SetVehicleDoorOpen(closecar, 5, false, false)
							CloseToVehicle = true
							TriggerServerEvent('gepeke:AddVehicleList', globalplate)
							TriggerServerEvent("gepeke:getInventory", GetVehicleNumberPlateText(closecar))
						else
							ESX.ShowNotification('Gepek je zakljucan!')
						end
					end
				else
					ESX.ShowNotification('Nema vozila u blizini!')
				end
				lastOpen = true
				GUI.Time  = GetGameTimer()
			else
				TriggerEvent('esx:showNotification', "Netko vec gleda gepek tog vozila!")
			end
		end, globalplate)
	end
end

function getItemyWeight(item)
	local weight = 0
	local itemWeight = 0

	if item ~= nil then
		itemWeight = Config.DefaultWeight
		for i = 1, #arrayWeight, 1 do
			if arrayWeight[i].Item == item and arrayWeight[i].Tezina > 0 then
				itemWeight = arrayWeight[i].Tezina
			end
		end
	end
	return itemWeight
end

RegisterNetEvent('gepeke:getInventoryLoaded')
AddEventHandler('gepeke:getInventoryLoaded', function(inventory,weight)
	LuaJeRetardirana(inventory,weight)
end)

loadDict = function(dict)
    while not HasAnimDictLoaded(dict) do Wait(0) RequestAnimDict(dict) end
end

function DajTezinu(veh)
	local model = GetEntityModel(veh)
	local klasa = GetVehicleClass(veh)
	if IsThisModelABike(model) or IsThisModelAQuadbike(model) then
		return Config.VehicleLimit[8]
	else
		return Config.VehicleLimit[klasa]
	end
end

function BogaIsusa(data3, weight)
	ESX.UI.Menu.Open(
		'dialog', GetCurrentResourceName(), 'inventory_item_count_give',
		{
		title = 'Kolicina'
		},
		function(data4, menu4)
		local quantity = tonumber(data4.value)
		local Itemweight =tonumber(getItemyWeight(data3.current.value)) * quantity
		local totalweight = tonumber(weight) + Itemweight
		vehFront = VehicleInFront()
		if totalweight > DajTezinu(vehFront) then
			max = true
		else
			max = false
		end

		ownedV = 0
		while vehiclePlate == '' do
			Wait(1000)
		end
		for i=1, #vehiclePlate do
			if vehiclePlate[i].plate == GetVehicleNumberPlateText(vehFront) then
			ownedV = 1
			break
			else
			ownedV = 0
			end
		end

		--fin test
		if quantity > 0 and quantity <= tonumber(data3.current.count) and vehFront > 0  then
			local MaxVh =(tonumber(DajTezinu(vehFront))/1000)
			local Kgweight =  totalweight/1000
			if not max then
			local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
					local closecar = GetClosestVehicle(x, y, z, 4.0, 0, 71)
					local tablica = GetVehicleNumberPlateText(closecar)

			--  VehicleMaxSpeed(closecar,totalweight,Config.VehicleLimit[GetVehicleClass(closecar)])
			if tablica ~= nil then
				TriggerServerEvent('gepeke:addInventoryItem', GetVehicleClass(closecar), GetDisplayNameFromVehicleModel(GetEntityModel(closecar)), tablica, data3.current.value, quantity, data3.current.name, data3.current.type, ownedV)
				ESX.ShowNotification('Tezina gepeka : ~g~'.. Kgweight .. ' Kg / '..MaxVh..' Kg')
				ESX.UI.Menu.CloseAll()
				RequestAnimDict("mini@repair")
				while not HasAnimDictLoaded( "mini@repair") do
					Citizen.Wait(1)
				end

				TaskPlayAnim(GetPlayerPed(-1), "mini@repair" ,"fixing_a_ped" ,8.0, -8.0, -1, 0, 0, false, false, false )
				Citizen.Wait(4000)
				ClearPedTasksImmediately(GetPlayerPed(-1))
				Citizen.Wait(500)
				TriggerServerEvent("gepeke:getInventory", GetVehicleNumberPlateText(closecar))
			else
				ESX.ShowNotification('Dogodila se greska!')
			end
			else
			ESX.ShowNotification('Dosegli ste ogranicenje od ~r~ '..MaxVh..' Kg')
			end
		else
			ESX.ShowNotification('~r~ Krivi iznos')
		end

		ESX.UI.Menu.CloseAll()
		local vehFront = VehicleInFront()
		if vehFront > 0 and max then
			ESX.SetTimeout(500, function()
				TriggerServerEvent("gepeke:getInventory", GetVehicleNumberPlateText(vehFront))
			end)
		else
			--SetVehicleDoorShut(vehFrontBack, 5, false)
		end
		end,
		function(data4, menu4)
		--SetVehicleDoorShut(vehFrontBack, 5, false)
		ESX.UI.Menu.CloseAll()
		local lastvehicleplatetext = GetVehicleNumberPlateText(vehFrontBack)
		TriggerServerEvent('gepeke:RemoveVehicleList', lastvehicleplatetext)
		end
	)
end

function LuaJeRetardirana(inventory,weightara)
	local weight = weightara
	local elements = {}
	local vehFrontBack = VehicleInFront()
  TriggerServerEvent("gepeke:getOwnedVehicule")

	table.insert(elements, {
      label     = 'Ostavi u gepek',
      count     = 0,
      value     = 'deposit',
    })
	
	table.insert(elements, {
      label     = 'Sakrij se u gepek',
      count     = 0,
      value     = 'skrivanje',
    })

	if inventory ~= nil and #inventory > 0 then
		for i=1, #inventory, 1 do
		if inventory[i].type == 'item_standard' then
		      table.insert(elements, {
		        label     = inventory[i].label .. ' x' .. inventory[i].count,
		        count     = inventory[i].count,
		        value     = inventory[i].name,
				type	  = inventory[i].type
		      })			
			elseif inventory[i].type == 'item_weapon' then
			  table.insert(elements, {
				label     = inventory[i].label .. ' | metci: ' .. inventory[i].count,
				count     = inventory[i].count,
				value     = inventory[i].name,
				type	  = inventory[i].type
			  })	
			elseif inventory[i].type == 'item_account' then
			  table.insert(elements, {
				label     = inventory[i].label .. ' [ $' .. inventory[i].count..' ]',
				count     = inventory[i].count,
				value     = inventory[i].name,
				type	  = inventory[i].type
			  })	
			end
		end
	end
	
	
	SetCurrentPedWeapon(PlayerPedId(), GetHashKey("WEAPON_UNARMED"), true)
	ESX.UI.Menu.Open(
	  'default', GetCurrentResourceName(), 'inventory_deposit',
	  {
	    title    = 'Sadrzaj gepeka',
	    align    = 'top-left',
	    elements = elements,
	  },
	  function(data, menu)
		if data.current.value == 'skrivanje' then
			local player = ESX.Game.GetClosestPlayer()
            local playerPed = GetPlayerPed(player)
			if DoesEntityExist(playerPed) then
				if not IsEntityAttached(playerPed) or GetDistanceBetweenCoords(GetEntityCoords(playerPed), GetEntityCoords(PlayerPedId()), true) >= 5.0 then
					if GetVehicleClass(vehFrontBack) ~= 8 and GetVehicleClass(vehFrontBack) ~= 13 and GetVehicleClass(vehFrontBack) ~= 14 and GetVehicleClass(vehFrontBack) ~= 15 and GetVehicleClass(vehFrontBack) ~= 16 and GetVehicleClass(vehFrontBack) ~= 20 and GetVehicleClass(vehFrontBack) ~= 21 then
						menu.close()
						SetCarBootOpen(vehFrontBack)
						Wait(350)
						AttachEntityToEntity(PlayerPedId(), vehFrontBack, -1, 0.0, -2.2, 0.5, 0.0, 0.0, 0.0, false, false, false, false, 20, true)	
						loadDict('timetable@floyd@cryingonbed@base')
						TaskPlayAnim(PlayerPedId(), 'timetable@floyd@cryingonbed@base', 'base', 8.0, -8.0, -1, 1, 0, false, false, false)
						Wait(50)
						inTrunk = true
						Wait(1500)
						SetVehicleDoorShut(vehFrontBack, 5)
						ESX.ShowNotification("Pritisnite E kako bih ste izasli iz gepeka!")
					else
						ESX.ShowNotification("Ne mozete se sakriti u ovom vozilu!")
					end
				else
					ESX.ShowNotification('Netko je vec u gepeku vozila!')
				end
			end
	  	elseif data.current.value == 'deposit' then
	  		local elem = {}
			-- xPlayer.getAccount('black_money').money
			-- table.insert(elements, {label = 'Argent sale: ' .. inventory.blackMoney, type = 'item_account', value = 'black_money'})
			
	  		PlayerData = ESX.GetPlayerData()
			for i=1, #PlayerData.accounts, 1 do
				if PlayerData.accounts[i].name == 'black_money' then
				  -- if PlayerData.accounts[i].money > 0 then
				    table.insert(elem, {
				      label     = PlayerData.accounts[i].label .. ' [ $'.. math.floor(PlayerData.accounts[i].money+0.5) ..' ]',
				      count     = PlayerData.accounts[i].money,
				      value     = PlayerData.accounts[i].name,
				      name      = PlayerData.accounts[i].label,
					  limit     = PlayerData.accounts[i].limit,
					  type		= 'item_account',
				    })
				  -- end
				end
			end
			
			for i=1, #PlayerData.inventory, 1 do
				if PlayerData.inventory[i].count > 0 then
				    table.insert(elem, {
				      label     = PlayerData.inventory[i].label .. ' x' .. PlayerData.inventory[i].count,
				      count     = PlayerData.inventory[i].count,
				      value     = PlayerData.inventory[i].name,
				      name      = PlayerData.inventory[i].label,
					  limit     = PlayerData.inventory[i].limit,
					  type		= 'item_standard',
				    })
				end
			end
			
		local playerPed  = GetPlayerPed(-1)
		local weaponList = ESX.GetWeaponList()

		if PlayerData.job.name ~= "police" and PlayerData.job.name ~= "sipa" and PlayerData.job.name ~= "zastitar" and PlayerData.job.name ~= "Gradonacelnik" then
			for i=1, #weaponList, 1 do

			  local weaponHash = GetHashKey(weaponList[i].name)
			  

			  if HasPedGotWeapon(playerPed,  weaponHash,  false) and weaponList[i].name ~= 'WEAPON_UNARMED' then
				local ammo = GetAmmoInPedWeapon(playerPed, weaponHash)
				table.insert(elem, {label = weaponList[i].label .. ' [' .. ammo .. ']',name = weaponList[i].label, type = 'item_weapon', value = weaponList[i].name, count = ammo})
			  end

			end
		end
			ESX.UI.Menu.Open(
			  'default', GetCurrentResourceName(), 'inventory_player',
			  {
			    title    = 'Sadrzaj kod vas',
			    align    = 'top-left',
			    elements = elem,
			  },function(data3, menu3)
			  if data3.current.type ~= "item_weapon" then
					BogaIsusa(data3, weightara)
			  else
					local Itemweight =tonumber(getItemyWeight(data3.current.value)) * data3.current.count
					local totalweight = tonumber(weight) + Itemweight
					vehFront = VehicleInFront()

					if totalweight > DajTezinu(vehFront) then
					  max = true
					else
					  max = false
					end

					ownedV = 0
					while vehiclePlate == '' do
					  Wait(1000)
					end
					for i=1, #vehiclePlate do
					  if vehiclePlate[i].plate == GetVehicleNumberPlateText(vehFront) then
						ownedV = 1
						break
					  else
						ownedV = 0
					  end
					end

					--fin test

					if vehFront > 3 then
					  local MaxVh =(tonumber(DajTezinu(vehFront))/1000)
					  local Kgweight =  totalweight/1000
					  if not max then
						local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
						local closecar = GetClosestVehicle(x, y, z, 4.0, 0, 71)
						local tablica = GetVehicleNumberPlateText(closecar)
					  --  VehicleMaxSpeed(closecar,totalweight,Config.VehicleLimit[GetVehicleClass(closecar)])
						if tablica ~= nil then
							TriggerServerEvent('gepeke:addInventoryItem', GetVehicleClass(closecar), GetDisplayNameFromVehicleModel(GetEntityModel(closecar)), tablica, data3.current.value, data3.current.count, data3.current.name, data3.current.type, ownedV)
							ESX.ShowNotification('Tezina gepeka : ~g~'.. Kgweight .. ' Kg / '..MaxVh..' Kg')
							menu.close()
							menu3.close()
							RequestAnimDict("mini@repair")
							while not HasAnimDictLoaded( "mini@repair") do
								Citizen.Wait(1)
							end

							TaskPlayAnim(GetPlayerPed(-1), "mini@repair" ,"fixing_a_ped" ,8.0, -8.0, -1, 0, 0, false, false, false )
							Citizen.Wait(4000)
							ClearPedTasksImmediately(GetPlayerPed(-1))
							Citizen.Wait(500)
							TriggerServerEvent("gepeke:getInventory", GetVehicleNumberPlateText(closecar))
						else
							ESX.ShowNotification('Dogodila se greska!')
						end
					  else
						ESX.ShowNotification('Dosegli ste ogranicenje od ~r~ '..MaxVh..' Kg')
					  end
					else
						ESX.ShowNotification('~r~ Krivi iznos')
					end

				    ESX.UI.Menu.CloseAll()
					local vehFront = VehicleInFront()
					if vehFront > 0 then
						ESX.SetTimeout(500, function()
							TriggerServerEvent("gepeke:getInventory", GetVehicleNumberPlateText(vehFront))
						end)
					else
					  --SetVehicleDoorShut(vehFrontBack, 5, false)
					end
				end
			end,
				function(data, menu)
					menu.close()
				end)
		elseif data.current.type == 'cancel' then
			menu.close()
	  	else
			if data.current.type ~= "item_weapon" then
			ESX.UI.Menu.Open(
			  'dialog', GetCurrentResourceName(), 'inventory_item_count_give',
			  {
			    title = 'Kolicina'
			  },
			  function(data2, menu2)

			    local quantity = tonumber(data2.value)
				PlayerData = ESX.GetPlayerData()
			    vehFront = VehicleInFront()

				--test
				local Itemweight =tonumber(getItemyWeight(data.current.value)) * quantity
				local poid = weight - Itemweight


			
				for i=1, #PlayerData.inventory, 1 do
			
					if PlayerData.inventory[i].name == data.current.value then
						local torba = 0
						TriggerEvent('skinchanger:getSkin', function(skin)
							torba = skin['bags_1']
						end)
						if torba == 40 or torba == 41 or torba == 44 or torba == 45 then
							if tonumber(PlayerData.inventory[i].limit)*2 < tonumber(PlayerData.inventory[i].count) + quantity and PlayerData.inventory[i].limit ~= -1 then
								max = true
							else
								max = false
							end
						else
							if tonumber(PlayerData.inventory[i].limit) < tonumber(PlayerData.inventory[i].count) + quantity and PlayerData.inventory[i].limit ~= -1 then
								max = true
							else
								max = false
							end
						end
					end
				end

				--fin test


				if quantity > 0 and quantity <= tonumber(data.current.count) and vehFront > 0 then
					if not max then
						local waitara = math.random(200,800)
						Wait(waitara)
						TriggerServerEvent('gepeke:removeInventoryItem', GetVehicleNumberPlateText(vehFront), data.current.value, data.current.type, quantity)
						menu.close()
						menu2.close()
						local MaxVh =(tonumber(DajTezinu(vehFront))/1000)
						local Itemweight =tonumber(getItemyWeight(data.current.value)) * quantity
						local totalweight = tonumber(weight) - Itemweight
						local Kgweight =  totalweight/1000
						ESX.ShowNotification('Vasa tezina : ~g~'.. Kgweight .. ' Kg / '..MaxVh..' Kg')
						RequestAnimDict("mini@repair")
						while not HasAnimDictLoaded( "mini@repair") do
							Citizen.Wait(1)
						end

						TaskPlayAnim(GetPlayerPed(-1), "mini@repair" ,"fixing_a_ped" ,8.0, -8.0, -1, 0, 0, false, false, false )
						Citizen.Wait(4000)
						ClearPedTasksImmediately(GetPlayerPed(-1))
					else
						ESX.ShowNotification('~r~ Vec nosite previse stvari!')
					end
			    else
					ESX.ShowNotification('~r~ Kriva kolicina')
			    end

			    ESX.UI.Menu.CloseAll()

	        	local vehFront = VehicleInFront()
	          	if vehFront > 0 then
	          		ESX.SetTimeout(500, function()
	              		TriggerServerEvent("gepeke:getInventory", GetVehicleNumberPlateText(vehFront))
	          		end)
	            else
	              --SetVehicleDoorShut(vehFrontBack, 5, false)
	            end
			  end,
			  function(data2, menu2)
                        --SetVehicleDoorShut(vehFrontBack, 5, false)
                        ESX.UI.Menu.CloseAll()
                        local lastvehicleplatetext = GetVehicleNumberPlateText(vehFrontBack)
                        TriggerServerEvent('gepeke:RemoveVehicleList', lastvehicleplatetext)
                    end
                )
				else
						local quantity = tonumber(data.current.count)
							PlayerData = ESX.GetPlayerData()
							vehFront = VehicleInFront()

						  --test
						  local Itemweight =tonumber(getItemyWeight(data.current.value)) * quantity
						  local poid = weight - Itemweight


							
						  for i=1, #PlayerData.inventory, 1 do
							
							if PlayerData.inventory[i].name == data.current.value then
							  if tonumber(PlayerData.inventory[i].limit) < tonumber(PlayerData.inventory[i].count) + quantity and PlayerData.inventory[i].limit ~= -1 then
								max = true
							  else
								max = false
							  end
							end
						  end

						  --fin test


							if quantity >= 0 and quantity <= tonumber(data.current.count) and vehFront > 0 then
							if not max then
								local waitara = math.random(200,800)
								Wait(waitara)
								TriggerServerEvent('gepeke:removeInventoryItem', GetVehicleNumberPlateText(vehFront), data.current.value, data.current.type, quantity)
								menu.close()
								local MaxVh =(tonumber(DajTezinu(vehFront))/1000)
								local Itemweight =tonumber(getItemyWeight(data.current.value)) * quantity
								local totalweight = tonumber(weight) - Itemweight
								local Kgweight =  totalweight/1000
								ESX.ShowNotification('Vasa tezina : ~g~'.. Kgweight .. ' Kg / '..MaxVh..' Kg')
								RequestAnimDict("mini@repair")
								while not HasAnimDictLoaded( "mini@repair") do
									Citizen.Wait(1)
								end

								TaskPlayAnim(GetPlayerPed(-1), "mini@repair" ,"fixing_a_ped" ,8.0, -8.0, -1, 0, 0, false, false, false )
								Citizen.Wait(4000)
								ClearPedTasksImmediately(GetPlayerPed(-1))
							else
							  ESX.ShowNotification('~r~ Vec nosite previse stvari!')
							end
								else
								  ESX.ShowNotification('~r~ Kriva kolicina')
								end

								ESX.UI.Menu.CloseAll()

								local vehFront = VehicleInFront()
								if vehFront > 0 then
									ESX.SetTimeout(500, function()
										TriggerServerEvent("gepeke:getInventory", GetVehicleNumberPlateText(vehFront))
									end)
								else
								  --SetVehicleDoorShut(vehFrontBack, 5, false)
								end
				end
            end
        end,
		function(data, menu)
			local vehFront = VehicleInFront()
			SetVehicleDoorShut(vehFront, 5, false)
			menu.close()
		end
	)
end

RegisterCommand("hauba", function(source, args, raw)
    local ped = GetPlayerPed(-1)
    local veh = GetVehiclePedIsUsing(ped)
    local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
	local closecar = GetClosestVehicle(x, y, z, 4.0, 0, 71)
	local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(ped), GetEntityCoords(closecar), 1)
    local door = 4

    if IsPedInAnyVehicle(ped, false) then
        if GetVehicleDoorAngleRatio(veh, door) > 0 then
            SetVehicleDoorShut(veh, door, false)
        else	
            SetVehicleDoorOpen(veh, door, false, false)
        end
    else
        if closecar ~= nil and GetPedInVehicleSeat(closecar, -1) ~= GetPlayerPed(-1) and distanceToVeh <= 4.0 then
            if GetVehicleDoorAngleRatio(closecar, door) > 0 then
                SetVehicleDoorShut(closecar, door, false)
            else	
                SetVehicleDoorOpen(closecar, door, false, false)
            end
        else
            ShowInfo("Previse ste udaljeni od vozila.")
        end
    end
end)

RegisterCommand("vrata", function(source, args, raw)
    local ped = GetPlayerPed(-1)
    local veh = GetVehiclePedIsUsing(ped)
	local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
	local closecar = GetClosestVehicle(x, y, z, 4.0, 0, 71)
	local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(ped), GetEntityCoords(closecar), 1)
    
    if args[1] == "1" then -- Front Left Door
        door = 0
    elseif args[1] == "2" then -- Front Right Door
        door = 1
    elseif args[1] == "3" then -- Back Left Door
        door = 2
    elseif args[1] == "4" then -- Back Right Door
        door = 3
    else
        door = nil
        ShowInfo("Koristite: ~n~~b~/vrata [broj]")
        ShowInfo("1(Prednja ljeva), 2(Prednja desna)")
        ShowInfo("3(Straznja ljeva), 4(Straznja desna)")
    end

    if door ~= nil then
        if IsPedInAnyVehicle(ped, false) then
            if GetVehicleDoorAngleRatio(veh, door) > 0 then
                SetVehicleDoorShut(veh, door, false)
            else	
                SetVehicleDoorOpen(veh, door, false, false)
            end
        else
            if closecar ~= nil and GetPedInVehicleSeat(closecar, -1) ~= GetPlayerPed(-1) and distanceToVeh <= 4.0 then
                if GetVehicleDoorAngleRatio(closecar, door) > 0 then
                    SetVehicleDoorShut(closecar, door, false)
                else	
                    SetVehicleDoorOpen(closecar, door, false, false)
                end
            else
                ShowInfo("Previse ste udaljeni od vozila.")
            end
        end
    end
end)

RegisterCommand("prozor", function(source, args, raw)
    local ped = GetPlayerPed(-1)
    local veh = GetVehiclePedIsUsing(ped)
    
    if args[1] == "1" then -- Front Left Door
        door = 0
    elseif args[1] == "2" then -- Front Right Door
        door = 1
    elseif args[1] == "3" then -- Back Left Door
        door = 2
    elseif args[1] == "4" then -- Back Right Door
        door = 3
    else
        door = nil
        ShowInfo("Koristite: ~n~~b~/prozor [broj]")
        ShowInfo("1(Prednji lijevi), 2(Prednji desni)")
        ShowInfo("3(Straznji lijevi), 4(Straznji desni)")
    end

    if door ~= nil then
        if IsPedInAnyVehicle(ped, false) then
            if IsVehicleWindowIntact(veh, door) then
				RollDownWindow(veh, door)
            else	
                RollUpWindow(veh, door)
            end
        end
    end
end)

--Voda
function IsFacingWater()
  local ped = PlayerPedId()
  local headPos = GetPedBoneCoords(ped, 31086, 0.0, 0.0, 0.0)
  local offsetPos = GetOffsetFromEntityInWorldCoords(ped, 0.0, 50.0, -25.0)
  local hit, hitPos = TestProbeAgainstWater(headPos.x, headPos.y, headPos.z, offsetPos.x, offsetPos.y, offsetPos.z)
  return hit, hitPos
end

function ProvjeriPosao()
	ESX.PlayerData = ESX.GetPlayerData()
	local model = GetHashKey("a_m_m_beach_01")
    RequestModel(model)
	
    while not HasModelLoaded(model) do
        Wait(1)
    end
	local npc = CreatePed(4, model, 94.828460693359, 3756.8435058594, 39.770915985107, 160.21, false, true)
	SetModelAsNoLongerNeeded(model)
			
	SetEntityHeading(npc, 160.21)
	FreezeEntityPosition(npc, true)
	SetEntityInvincible(npc, true)
	SetBlockingOfNonTemporaryEvents(npc, true)
	SetPlayerCanDoDriveBy(PlayerId(), false)
	
	ESX.TriggerServerCallback('esx-races:DohvatiPermisiju', function(br)
		perm = br
	end)
end

RegisterCommand("hash", function(source, args, raw)
    print(GetHashKey(args[1]))
end)

AddEventHandler("playerSpawned", function()
	SetPedComponentVariation(PlayerPedId(), 1, 0 ,0, 2)
	--StatSetInt(GetHashKey('MP0_STAMINA'), 20, true)
	local coords = GetEntityCoords(PlayerPedId())
	if GetDistanceBetweenCoords(coords, 0, 0, 0, true) <= 10.0 then
		SetEntityCoords(PlayerPedId(), -825.510, -440.8749, 35.6722)
	end
	ESX.TriggerServerCallback('esx-races:DohvatiPermisiju', function(br)
		perm = br
	end)
end)

RegisterNetEvent('es_admin:setPerm')
AddEventHandler('es_admin:setPerm', function()
	ESX.TriggerServerCallback('esx-races:DohvatiPermisiju', function(br)
		perm = br
	end)
end)

RegisterNetEvent('loto:IzaberiBroj')
AddEventHandler('loto:IzaberiBroj', function()
	TriggerEvent("esx_invh:closeinv")
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'vrloto', {
		title = "Upisite broj za loto (1-120)",
	}, function (datari69, menuri69)
		local br = datari69.value
		if br == nil or tonumber(br) <= 0 then
			ESX.ShowNotification('Krivi iznos!')
		else
			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'vrloto2', {
				title = "Upisite koliku uplatu hocete (1-15000$)",
			}, function (datari70, menuri70)
				local br2 = datari70.value
				if br2 == nil or tonumber(br2) <= 0 or tonumber(br2) > 15000 then
					ESX.ShowNotification('Krivi iznos!')
				else
					TriggerServerEvent("loto:UplatiBroj", br, br2)
					menuri70.close()
				end
			end, function (datari70, menuri70)
				menuri70.close()
			end)
			menuri69.close()
		end
	end, function (datari69, menuri69)
		menuri69.close()
	end)
end)

--[[AddEventHandler("gameEventTriggered", function(name, data)
	print(name)
	--(targetId, playerId, nezz, jelUmro, hashOruzja, nezz(mijenja se kada se sudaris autom), nezz(mijenja se kada se sudaris autom), nezz, nezz(mijenja se kada headas peda), nezz, mijenja se ovisno o tome koji dio vozila pucas)
	print(json.encode(data))
end)]]

RegisterNetEvent('VratiTamoSkin')
AddEventHandler('VratiTamoSkin', function(pid)
	local retval = NetworkGetNetworkIdFromEntity(PlayerPedId())
	TriggerServerEvent("EoTiSkinara", retval, GetEntityModel(PlayerPedId()), pid)
end)

local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
    return coroutine.wrap(function()
        local iter, id = initFunc()
        if not id or id == 0 then
            disposeFunc(iter)
            return
        end
      
        local enum = {handle = iter, destructor = disposeFunc}
        setmetatable(enum, entityEnumerator)
      
        local next = true
        repeat
            coroutine.yield(id)
            next, id = moveFunc(iter)
        until not next
      
        enum.destructor, enum.handle = nil, nil
        disposeFunc(iter)
    end)
end

function EnumerateVehicles()
    return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

local currentGear = {
    mask = 0,
    tank = 0,
    enabled = false
}

function GearAnim()
    loadAnimDict("clothingshirt")    	
	TaskPlayAnim(GetPlayerPed(-1), "clothingshirt", "try_shirt_positive_d", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
end

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 0 )
    end
end

function DeleteGear()
	if currentGear.mask ~= 0 then
        DetachEntity(currentGear.mask, 0, 1)
        ESX.Game.DeleteObject(currentGear.mask)
		currentGear.mask = 0
    end
    
	if currentGear.tank ~= 0 then
        DetachEntity(currentGear.tank, 0, 1)
        ESX.Game.DeleteObject(currentGear.tank)
		currentGear.tank = 0
	end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(300000)
		TriggerServerEvent("minute:SpremiIh")
	end
end)

-- exports.qtarget:Player({
-- 	options = {
-- 		{
-- 			icon = "fa fa-users",
-- 			label = "Upoznaj",
-- 			action = function(entity)
-- 				TriggerServerEvent("prodajoruzje:Upoznaj1", GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity)))
--             end
-- 		}
-- 	},
-- 	distance = 2
-- })

-- RegisterCommand("upoznaj", function(source, args, rawCommandString)
-- 	local players      = ESX.Game.GetPlayersInArea(GetEntityCoords(PlayerPedId()), 3.0)
-- 	local foundPlayers = false

-- 	for i=1, #players, 1 do
-- 		if players[i] ~= PlayerId() then
-- 			foundPlayers = true
-- 		end
-- 	end

-- 	if not foundPlayers then
-- 		ESX.ShowNotification("Nema igraca u blizini!")
-- 		return
-- 	end

-- 	foundPlayers = false

-- 	TriggerServerEvent("prodajoruzje:Upoznaj1", GetPlayerServerId(players[1]))
-- end, false)

RegisterNetEvent('ronjenje:PocniRonit')
AddEventHandler('ronjenje:PocniRonit', function()
    if currentGear.enabled == false then
		GearAnim()
		DeleteGear()
		Wait(2000)
		local maskModel = GetHashKey("p_d_scuba_mask_s")
		local tankModel = GetHashKey("p_s_scuba_tank_s")
		
		RequestModel(tankModel)
		while not HasModelLoaded(tankModel) do
			Citizen.Wait(1)
		end
		TankObject = CreateObject(tankModel, 1.0, 1.0, 1.0, 1, 1, 0)
		local bone1 = GetPedBoneIndex(GetPlayerPed(-1), 24818)
		AttachEntityToEntity(TankObject, GetPlayerPed(-1), bone1, -0.25, -0.25, 0.0, 180.0, 90.0, 0.0, 1, 1, 0, 0, 2, 1)
		currentGear.tank = TankObject
		
		RequestModel(maskModel)
		while not HasModelLoaded(maskModel) do
			Citizen.Wait(1)
		end
				
		MaskObject = CreateObject(maskModel, 1.0, 1.0, 1.0, 1, 1, 0)
		local bone2 = GetPedBoneIndex(GetPlayerPed(-1), 12844)
		AttachEntityToEntity(MaskObject, GetPlayerPed(-1), bone2, 0.0, 0.0, 0.0, 180.0, 90.0, 0.0, 1, 1, 0, 0, 2, 1)
		currentGear.mask = MaskObject
		
		SetEnableScuba(GetPlayerPed(-1), true)
		SetPedMaxTimeUnderwater(GetPlayerPed(-1), 2000.00)
		currentGear.enabled = true
		ClearPedTasks(GetPlayerPed(-1))
		ESX.ShowNotification("Obukli ste opremu za ronjenje!")
	else
		GearAnim()
		Wait(2000)
        DeleteGear()
        SetEnableScuba(GetPlayerPed(-1), false)
        SetPedMaxTimeUnderwater(GetPlayerPed(-1), 10.0)
        currentGear.enabled = false
        ClearPedTasks(GetPlayerPed(-1))
		ESX.ShowNotification("Skinuli ste opremu za ronjenje!")
	end
end)

local Upaljeno = false

RegisterNetEvent('prodajoruzje:grebalica')
AddEventHandler('prodajoruzje:grebalica', function()
	SendNUIMessage({
		prikazi = true
	})
	SetNuiFocus(true, true)
	Upaljeno = true
	Citizen.CreateThread(function()
		while Upaljeno do
			Citizen.Wait(0)
			DisableAllControlActions(0)
		end
	end)
end)

RegisterNUICallback(
    "kraj",
    function(data, cb)
		SetNuiFocus(false)
		TriggerServerEvent("prodajoruzje:KoiKuracJeOvo", data.broj)
    end
)

RegisterNUICallback(
    "vratik",
    function(data, cb)
		Upaljeno = false
    end
)

RegisterNetEvent('prodajoruzje:petarde')
AddEventHandler('prodajoruzje:petarde', function()
			local modele = "prop_cs_dildo_01"
			ESX.Streaming.RequestModel(modele)
			local playerPed = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(playerPed))
			local prop = CreateObject(GetHashKey(modele), x, y, z + 0.2, true, true, true)
			local boneIndex = GetPedBoneIndex(playerPed, 57005)
			AttachEntityToEntity(prop, playerPed, boneIndex, 0.12, 0.028, 0.001, 10.0, 145.0, 0.0, true, true, false, true, 1, true)
			local forceTypes = {
				MinForce = 0,
				MaxForceRot = 1,
				MinForce2 = 2,
				MaxForceRot2 = 3,
				ForceNoRot = 4,
				ForceRotPlusForce = 5
			}

			local forceType = forceTypes.MaxForceRot2
			local cor = GetEntityCoords(PlayerPedId())
			local cordsa = GetOffsetFromEntityInWorldCoords(PlayerPedId(), -8.0, 1.0 , -7.0)
			local direction = vector3(cordsa.x-cor.x, cordsa.y-cor.y, cordsa.z-cor.z)
			local rotation = vector3(0.0, 0.0, 0.0)
			RequestAnimDict("weapons@projectile@")
			while not HasAnimDictLoaded("weapons@projectile@") do
				Citizen.Wait(1000)
			end
			Wait(500)
			TaskPlayAnim(PlayerPedId(),"weapons@projectile@", "throw_m_fb_stand", 8.0, -8, -1, 2, 0, 0, 0, 0)
			Wait(400)
			ClearPedTasks(PlayerPedId())
			DetachEntity(prop, true, false)
			ApplyForceToEntity(
				prop,
				forceType,
				direction,
				rotation,
				0,
				false,
				true,
				true,
				false,
				true
			)
			Wait(3000)
			cordsa = GetEntityCoords(prop)
			AddExplosion(
				cordsa.x, 
				cordsa.y, 
				cordsa.z, 
				18, 
				0.0, 
				true, 
				false, 
				false,
				false
			)
			DeleteEntity(prop)
end)

local bomba = vector3(-484.06744384766, 198.82972717286, 83.157684326172)

Citizen.CreateThread(function()
	local waitara = 500
	while true do
		Citizen.Wait(waitara)
		local naso = 0
		local playerPed = GetPlayerPed(-1)
		local isInMarker     = false
		local currentStation = nil
		local currentPart    = nil
		local currentPartNum = nil
		local hasExited = false
		if CurrentAction ~= nil then
			waitara = 0
			naso = 1
	  
			SetTextComponentFormat('STRING')
			AddTextComponentString(CurrentActionMsg)
			DisplayHelpTextFromStringLabel(0, 0, 1, -1)

			if IsControlPressed(0, Keys['E']) and (GetGameTimer() - GUI.Time) > 150 then
				if CurrentAction == 'bomba' then
					local coords = GetEntityCoords(PlayerPedId())
					if(GetDistanceBetweenCoords(coords, -484.06744384766, 198.82972717286, 83.157684326172, true) < 2) then
						local torba = 0
						TriggerEvent('skinchanger:getSkin', function(skin)
							torba = skin['bags_1']
						end)
						if torba == 40 or torba == 41 or torba == 44 or torba == 45 then
							TriggerServerEvent('bomba:KupiBombu', true)
						else
							TriggerServerEvent('bomba:KupiBombu', false)
						end
					else
						TriggerEvent('prodajoruzje:hasExitedMarker', lastStation, lastPart, lastPartNum)
					end
				end
				GUI.Time = GetGameTimer()
				CurrentAction = nil
			end
		end
		local coords    = GetEntityCoords(playerPed)

		if #(coords-bomba) < 100.0 then
			waitara = 0
			naso = 1
			DrawMarker(0, bomba, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 2.0, 1.0, 0, 0, 0, 100, false, true, 2, false, false, false, false)
		end

		if #(coords-bomba) < 2 then
			isInMarker  = true
			currentStation = 1
			currentPart = "bomba"
			currentPartNum = 1
		end
		
		if isInMarker and not HasAlreadyEnteredMarker or (isInMarker and (LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum) ) then
			waitara = 0
			naso = 1
			if
				(LastStation ~= nil and LastPart ~= nil and LastPartNum ~= nil) and
				(LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum)
			then
				TriggerEvent('prodajoruzje:hasExitedMarker', LastStation, LastPart, LastPartNum)
				hasExited = true
			end

			HasAlreadyEnteredMarker = true
			LastStation             = currentStation
			LastPart                = currentPart
			LastPartNum             = currentPartNum

			TriggerEvent('prodajoruzje:hasEnteredMarker', currentStation, currentPart, currentPartNum)
		end

		if not hasExited and not isInMarker and HasAlreadyEnteredMarker then
			waitara = 0
			naso = 1
			HasAlreadyEnteredMarker = false

			TriggerEvent('prodajoruzje:hasExitedMarker', LastStation, LastPart, LastPartNum)
		end
	
		if naso == 0 then
			waitara = 500
		end
	end
end)

AddEventHandler('prodajoruzje:hasEnteredMarker', function(station, part, partNum)
	if part == 'bomba' then
		CurrentAction     = "bomba"
		CurrentActionMsg  = "Pritisnite E da kupite auto bombu za $200000"
		CurrentActionData = {}
	end
end)

AddEventHandler('prodajoruzje:hasExitedMarker', function(station, part, partNum)
	ESX.UI.Menu.CloseAll()
	CurrentAction = nil
end)

RegisterNetEvent('RNG_CarBomb:CheckIfRequirementsAreMet')
AddEventHandler('RNG_CarBomb:CheckIfRequirementsAreMet', function()
    local ped = GetPlayerPed(-1)
    local coords = GetEntityCoords(ped)
    local veh = GetClosestVehicle(coords.x, coords.y, coords.z, 3.000, 0, 70)
    local vCoords = GetEntityCoords(veh)
    local dist = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, vCoords.x, vCoords.y, vCoords.z, false)
    local animDict = "anim@amb@business@weed@weed_inspecting_lo_med_hi@"
    local anim = "weed_spraybottle_crouch_base_inspector"

    if not IsPedInAnyVehicle(ped, false) then
        if veh and (dist < 3.0) then
            loadAnimDict(animDict)
            Citizen.Wait(1000)
            TaskPlayAnim(ped, animDict, anim, 3.0, 1.0, -1, 0, 1, 0, 0, 0)
			FreezeEntityPosition(ped, true)
            if Config.ProgressBarType == 0 then
                --return
            elseif Config.ProgressBarType == 1 then
				ESX.ShowPBar('Postavljanje bombe', Config.TimeTakenToArm * 1000)
            elseif Config.ProgressBarType == 2 then
                FastMythticProg('Postavljanje bombe', Config.TimeTakenToArm * 1000)
            end
            Citizen.Wait(Config.TimeTakenToArm * 1000)
            ClearPedTasksImmediately(ped)
			FreezeEntityPosition(ped, false)
			TriggerServerEvent('RNG_CarBomb:RemoveBombFromInv')
			TriggerServerEvent("bomba:SpremiVozilo", GetVehicleNumberPlateText(veh))
            if Config.DetonationType == 0 then
                if Config.UsingMythicNotifications then
                    TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = 'The device will explode in '..Config.TimeUntilDetonation..' seconds', length = 5500})
                else
					ESX.ShowNotification('The device will explode in '..Config.TimeUntilDetonation..' seconds')
                end
                RunTimer(veh)
            elseif Config.DetonationType == 1 then
                if Config.UsingMythicNotifications then
                    TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = 'The device will explode at the speed of '..Config.maxSpeed..' '..Config.Speed, length = 5500})
                else
					ESX.ShowNotification('The device will explode at the speed of '..Config.maxSpeed..' '..Config.Speed)
                end
            elseif Config.DetonationType == 2 then
                if Config.UsingMythicNotifications then
                    TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = 'Detonate the device by pressing G', length = 5500})
                else
					ESX.ShowNotification('Detonate the device by pressing G')
                end
            elseif Config.DetonationType == 3 then
                if Config.UsingMythicNotifications then
                    TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = 'The device will detonate '..Config.TimeUntilDetonation..' seconds after someone enters the vehicle', length = 5500})
                else
					ESX.ShowNotification('The device will detonate '..Config.TimeUntilDetonation..' seconds after someone enters the vehicle')
                end 
            elseif Config.DetonationType == 4 then
                if Config.UsingMythicNotifications then
                    TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = 'Bomba ce eksplodirati cim vozac upali motor vozila', length = 5500})
                else
					ESX.ShowNotification('Bomba ce eksplodirati cim vozac upali motor vozila')
                end 
            end 
        else
            if Config.UsingMythicNotifications then
                TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = 'Nema vozila u blizini', length = 5500})
            else
				ESX.ShowNotification('Nema vozila u blizini')  
            end 
        end 
    else
        if Config.UsingMythicNotifications then
            TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = 'Ne mozete to uraditi kada ste u vozilu!', length = 5500})
        else
			ESX.ShowNotification('Ne mozete to uraditi kada ste u vozilu!')  
        end 
    end
end)

function OpenPreradaMenu()
    local elements = {}
    table.insert(elements, {label = 'Kundak za assault rifle (5 zeljeza)', value = "kkundak"})
	table.insert(elements, {label = 'Kundak za carbine rifle (10 zeljeza)', value = "ckundak"})
	table.insert(elements, {label = 'Kundak za special carbine (15 zeljeza)', value = "skundak"})
	table.insert(elements, {label = 'Kundak za SMG (4 zeljeza)', value = "smkundak"})

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'kraft_prerada',
      {
        title    = "Izaberite koji kundak zelite",
        align    = 'top-left',
        elements = elements,
      },
      function(data, menu)
		ESX.TriggerServerCallback('kraft:ProvjeriKolicinu', function(imal)
			  if imal then
					local itemic = data.current.value
					menu.close()
					ESX.ShowNotification("Zapoceli ste preradu zeljeza u kundak!")
					RequestAnimDict("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")
					while not HasAnimDictLoaded("anim@amb@clubhouse@tutorial@bkr_tut_ig3@") do
						Wait(100)
					end
					TaskPlayAnim(PlayerPedId(), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0, 1.0, -1, 17, 1.0, 0, 0, 0)
					local vrime = GetGameTimer()
					while GetGameTimer()-vrime < 15000 do
						Wait(1)
						DisableAllControlActions()
					end
					ClearPedTasksImmediately(PlayerPedId())
					local kordic = GetEntityCoords(PlayerPedId())
					if not IsEntityDead(PlayerPedId()) and #(kordic-cprerada) <= 5.0 then
						TriggerServerEvent("kraft:DajKundak", itemic)
						ESX.ShowNotification("Zavrsili ste preradu zeljeza u kundak!")
					end
					HasAlreadyEnteredMarker = false
			  else
					ESX.ShowNotification("Nemate dovoljno zeljeza ili nemate mjesta u inventoryju za kundak!")
			  end
		end, data.current.value)
      end,
      function(data, menu)
        menu.close()
		CurrentAction     = 'menu_prerada'
		CurrentActionMsg  = "Pritisnite E da otvorite menu prerade!"
		CurrentActionData = {}
      end
    )
end

function OpenCijevMenu()
    local elements = {}
    table.insert(elements, {label = 'Cijev za assault rifle ($5000)', value = "kcijev"})
	table.insert(elements, {label = 'Cijev za carbine rifle ($6000)', value = "ccijev"})
	table.insert(elements, {label = 'Cijev za special carbine ($7000)', value = "scijev"})
	table.insert(elements, {label = 'Cijev za smg ($4000)', value = "smcijev"})

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'kraft_cijev',
      {
        title    = "Izaberite koju cijev zelite",
        align    = 'top-left',
        elements = elements,
      },
      function(data, menu)
		ESX.TriggerServerCallback('kraft:ProvjeriKolicinu2', function(imal)
			  if imal then
					menu.close()
					CurrentAction     = 'menu_cijev'
					CurrentActionMsg  = "Pritisnite E da otvorite menu!"
					CurrentActionData = {}
					ESX.ShowNotification("Kupili ste cijev!")
			  else
					ESX.ShowNotification("Nemate dovoljno novca ili nemate mjesta u inventoryju za cijev!")
			  end
		end, data.current.value)
      end,
      function(data, menu)
        menu.close()
		CurrentAction     = 'menu_cijev'
		CurrentActionMsg  = "Pritisnite E da otvorite menu!"
		CurrentActionData = {}
      end
    )
end

RegisterNetEvent('prodajoruzje:SloziOruzje')
AddEventHandler('prodajoruzje:SloziOruzje', function(br)
	SendNUIMessage({
		prikazi2 = true,
		broj = br,
		ktijelo = true,
		kkundak = true,
		clip = true,
		kcijev = true
	})
	SetNuiFocus(true, true)
end)

RegisterNetEvent('prodajoruzje:AdminChat')
AddEventHandler('prodajoruzje:AdminChat', function(naslov, tekst)
	if perm == 1 then
		TriggerEvent('chat:addMessage', { args = { naslov, tekst } })
	end
end)

RegisterNetEvent('prodajoruzje:SetajChameSkin')
AddEventHandler('prodajoruzje:SetajChameSkin', function(sk, br)
	if br then
		if sk == 1 then
			local modelHash = GetHashKey("a_m_y_downtown_01")
			ESX.Streaming.RequestModel(modelHash, function()
				SetPlayerModel(PlayerId(), modelHash)
				SetModelAsNoLongerNeeded(modelHash)
				TriggerEvent('esx:restoreLoadout')
			end)
		else
			local modelHash = GetHashKey("csb_sol")
			ESX.Streaming.RequestModel(modelHash, function()
				SetPlayerModel(PlayerId(), modelHash)
				SetModelAsNoLongerNeeded(modelHash)
				TriggerEvent('esx:restoreLoadout')
			end)
		end
	else
		ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
			local isMale = skin.sex == 0
			TriggerEvent('skinchanger:loadDefaultModel', isMale, function()
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
					TriggerEvent('skinchanger:loadSkin', skin)
					TriggerEvent('esx:restoreLoadout')
				end)
			end)
		end)
	end
end)

RegisterNUICallback(
    "slozi",
    function(data, cb)
		SendNUIMessage({
			prikazi2 = true,
			broj = data.broj
		})
		SetNuiFocus(false)
		TriggerServerEvent("prodajoruzje:KoiKuracJeOvo2", data.broj)
    end
)

-- RegisterNUICallback(
--     "zatvoriupit",
--     function(data, cb)
-- 		local br = data.br
-- 		if br == 1 then
-- 			TriggerServerEvent("prodajoruzje:Upoznaj", data.args)
-- 		end
--     end
-- )

local rope = nil
local kurac = nil
local prop = nil
local attObj = nil
local soundID = GetSoundId()
local soundID2 = GetSoundId()
local soundID3 = GetSoundId()
local AMBIENT_AUDIO_BANK = "Crane"
local SCRIPT_AUDIO_BANK = "Container_Lifter"
local AUDIO_SCENE = "DOCKS_HEIST_USING_CRANE"
RequestAmbientAudioBank(AMBIENT_AUDIO_BANK, false)
RequestScriptAudioBank(SCRIPT_AUDIO_BANK, false)

if not IsAudioSceneActive(AUDIO_SCENE) then
	StartAudioScene(AUDIO_SCENE)
end

RegisterCommand("testrope", function(source, args, rawCommandString)
	local ped = GetPlayerPed(PlayerId())
	local pedPos = GetEntityCoords(ped, false)
	RopeLoadTextures()
	rope = AddRope(pedPos.x, pedPos.y, pedPos.z, 0.0, 0.0, 0.0, 100.0, 2, 10.0, 1.0, 0, 0, 0, 0, 0, 0, 0)
	CreateModelHide(128.0898, -347.8978, 97.47646, 50.0, GetHashKey("prop_towercrane_02d"), true)
	local modele = "prop_dock_crane_02_hook"
	ESX.Streaming.RequestModel(modele)
	local x,y,z = table.unpack(GetEntityCoords(ped))
	prop = CreateObject(GetHashKey(modele), x, y, z+5.2, true, true, true)
	local modele2 = "prop_towercrane_03d"
	ESX.Streaming.RequestModel(modele2)
	kurac = CreateObjectNoOffset(GetHashKey(modele2), 128.0898, -347.8978, 97.47646, true, true, true)
	FreezeEntityPosition(kurac, true)
	local x2,y2,z2 = table.unpack(GetEntityCoords(kurac))
	x,y,z = table.unpack(GetEntityCoords(prop))
	local rot = GetEntityRotation(prop, 2)
	y2 = y2-8.0
	local head = GetEntityHeading(kurac)
	AttachEntitiesToRope(
		rope, 
		kurac, 
		prop, 
		x2, 
		y2, 
		z2+4.0, 
		x, 
		y, 
		z+0.8,
		100
	)
	Wait(1500)
	local len = 10.0
	StopRopeUnwindingFront(rope)
	StartRopeWinding(rope)
	RopeForceLength(rope, len)
	local koric = -8.0

	local modele3 = "prop_woodpile_02a"
	ESX.Streaming.RequestModel(modele3)
	local x3,y3,z3 = table.unpack(GetEntityCoords(ped))
	attObj = CreateObject(GetHashKey(modele3), x, y, z+5.2, true, true, true)
	AttachEntityToEntity(attObj, prop, 0, 0.0, 0.0, -1.5, 0.0, 0.0, 0.0, false, false, true, false, 20, false)
	SetEntityVisible(PlayerPedId(), false, 0)
	FreezeEntityPosition(PlayerPedId(), true)
	AttachEntityToEntity(PlayerPedId(), kurac, 0, -2.0, -2.0, 1.7, 0.0, 0.0, 200.0, false, false, true, false, 2, false)
	Citizen.CreateThread(function()
		while rope ~= nil do
			if IsControlPressed(0, 10) then 
				if (len-0.1) > 2.2 then
					len = len-0.1
					StopRopeUnwindingFront(rope)
					StartRopeWinding(rope)
					RopeForceLength(rope, len)
					SetEntityRotation(prop, rot, 2)
					if HasSoundFinished(soundID2) then
						PlaySoundFromEntity(soundID2, "Move_U_D", kurac, "CRANE_SOUNDS", 0, 0)
						Citizen.CreateThread(function()
							while IsControlPressed(0, 10) do
								--cekam
								Wait(10)
							end
							StopSound(soundID2)
						end)
					end
				end
			end
			if IsControlPressed(0, 11) then 
				len = len+0.1
				x,y,z = table.unpack(GetEntityCoords(prop))
				StopRopeUnwindingFront(rope)
				StartRopeWinding(rope)
				RopeForceLength(rope, len)
				SetEntityRotation(prop, rot, 2)
				SetEntityCoords(prop, x, y, z-0.1)
				if HasSoundFinished(soundID2) then
					PlaySoundFromEntity(soundID2, "Move_U_D", kurac, "CRANE_SOUNDS", 0, 0)
					Citizen.CreateThread(function()
						while IsControlPressed(0, 11) do
							--cekam
							Wait(10)
						end
						StopSound(soundID2)
					end)
				end
				Wait(5)
			end
			if IsControlPressed(0, 21) then 
				if (koric-0.1) > -59.60 then
					koric = koric-0.1
					local kor = GetOffsetFromEntityInWorldCoords(kurac, 0.0, koric, 0.0)
					x,y,z = table.unpack(GetEntityCoords(prop))
					SetEntityRotation(prop, rot, 2)
					AttachEntitiesToRope(
						rope,
						kurac,
						prop,
						kor.x,
						kor.y,
						kor.z+4.0,
						x,
						y,
						z+0.8,
						100
					)
					if HasSoundFinished(soundID3) then
						PlaySoundFromEntity(soundID3, "Move_Base", kurac, "CRANE_SOUNDS", 0, 0)
						Citizen.CreateThread(function()
							while IsControlPressed(0, 21) do
								--cekam
								Wait(10)
							end
							StopSound(soundID3)
						end)
					end
					Wait(10)
					StopRopeUnwindingFront(rope)
					StartRopeWinding(rope)
					RopeForceLength(rope, len)
				end
			end
			if IsControlPressed(0, 36) then 
				if (koric+0.1) < -2.8 then
					koric = koric+0.1
					local kor = GetOffsetFromEntityInWorldCoords(kurac, 0.0, koric, 0.0)
					x,y,z = table.unpack(GetEntityCoords(prop))
					SetEntityRotation(prop, rot, 2)
					AttachEntitiesToRope(
						rope,
						kurac,
						prop,
						kor.x,
						kor.y,
						kor.z+4.0,
						x,
						y,
						z+0.8,
						100
					)
					if HasSoundFinished(soundID3) then
						PlaySoundFromEntity(soundID3, "Move_Base", kurac, "CRANE_SOUNDS", 0, 0)
						Citizen.CreateThread(function()
							while IsControlPressed(0, 36) do
								--cekam
								Wait(10)
							end
							StopSound(soundID3)
						end)
					end
					Wait(10)
					StopRopeUnwindingFront(rope)
					StartRopeWinding(rope)
					RopeForceLength(rope, len)
				end
			end
			if IsControlPressed(0, 46) then --E
				head = GetEntityHeading(kurac)
				SetEntityHeading(kurac, head-0.1)
				x2,y2,z2 = table.unpack(GetEntityCoords(kurac))
				if HasSoundFinished(soundID) then
					PlaySoundFromEntity(soundID, "Move_L_R", kurac, "CRANE_SOUNDS", 0, 0)
					Citizen.CreateThread(function()
						while IsControlPressed(0, 46) do
							--cekam
							Wait(10)
						end
						StopSound(soundID)
					end)
				end
			end
			if IsControlPressed(0, 52) then --Q
				head = GetEntityHeading(kurac)
				SetEntityHeading(kurac, head+0.1)
				x2,y2,z2 = table.unpack(GetEntityCoords(kurac))
				if HasSoundFinished(soundID) then
					PlaySoundFromEntity(soundID, "Move_L_R", kurac, "CRANE_SOUNDS", 0, 0)
					Citizen.CreateThread(function()
						while IsControlPressed(0, 52) do
							--cekam
							Wait(10)
						end
						StopSound(soundID)
					end)
				end
			end
			Citizen.Wait(0)
		end
	end)
end, false)

RegisterCommand("testrope2", function(source, args, rawCommandString)
	RopeUnloadTextures()
	DeleteRope(rope)
	DeleteObject(kurac)
	DeleteObject(prop)
	DeleteObject(attObj)
	RemoveModelHide(128.0898, -347.8978, 97.47646, 50.0, GetHashKey("prop_towercrane_02d"), false)
	SetEntityVisible(PlayerPedId(), true, 0)
	FreezeEntityPosition(PlayerPedId(), false)
	StopSound(soundID)
    ReleaseSoundId(soundID)
	rope = nil
end, false)

RegisterCommand("lc", function(source, args, rawCommandString)
	if IsPedInAnyVehicle(PlayerPedId(), false) then
		local deri = true
		local veha = GetVehiclePedIsIn(PlayerPedId(), false)
		SetVehicleHandbrake(veha, true)
		while deri do
			if IsControlJustPressed(0, 71) then
				SetVehicleHandbrake(veha, false)
				deri = false
			end
			SetVehicleCurrentRpm(veha, 0.8)
			Wait(1)
		end
	else
		ESX.ShowNotification("Morate biti u vozilu!")
	end
end, false)

RegisterCommand("aduty", function(source, args, rawCommandString)
	--ESX.TriggerServerCallback('esx-races:DohvatiPermisiju', function(br)
		if perm == 1 then
			if not aduty then
				aduty = true
				ESX.ShowNotification("Otisli ste na admin duznost!")
			else
				aduty = false
				ESX.ShowNotification("Otisli ste s admin duznosti!")
			end
			TriggerEvent("duznost:Saljem", aduty)
			TriggerServerEvent("tagovi:staffTag", aduty)
		else
			ESX.ShowNotification("Nemate pristup ovoj komandi!")
		end
	--end)
end, false)

RegisterCommand("psate", function(source, args, rawCommandString)
	--ESX.TriggerServerCallback('esx-races:DohvatiPermisiju', function(br)
		if perm == 1 then
			ESX.TriggerServerCallback('minute:DohvatiSate', function(elem)
				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'sati_list', {
					title    = "Sati igraca",
					align    = 'top-left',
					elements = elem
				}, function(data, menu)
					menu.close()	
				end, function(data, menu)
					menu.close()
				end)
			end)
		else
			ESX.ShowNotification("Nemate pristup ovoj komandi!")
		end
	--end)
end, false)

RegisterCommand("ndv", function(source, args, rawCommandString)
	--ESX.TriggerServerCallback('esx-races:DohvatiPermisiju', function(br)
		if perm == 1 then
			TriggerEvent("esx:deleteVehicle2")
		else
			ESX.ShowNotification("Nemate pristup ovoj komandi!")
		end
	--end)
end, false)

RegisterNetEvent('esx:deleteVehicle2')
AddEventHandler('esx:deleteVehicle2', function()
    local vehicle   = ESX.Game.GetVehicleInDirection()
    local entity = vehicle
    carModel = GetEntityModel(entity)
    carName = GetDisplayNameFromVehicleModel(carModel)
    NetworkRequestControlOfEntity(entity)
    
    local timeout = 2000
    while timeout > 0 and not NetworkHasControlOfEntity(entity) do
        Wait(100)
        timeout = timeout - 100
    end

    SetEntityAsMissionEntity(entity, true, true)
    
    local timeout = 2000
    while timeout > 0 and not IsEntityAMissionEntity(entity) do
        Wait(100)
        timeout = timeout - 100
    end

    Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized( entity ) )
    
    if (DoesEntityExist(entity)) then 
        DeleteEntity(entity)
    end 
end)

RegisterCommand("obrisivatromet", function(source, args, rawCommandString)
	--ESX.TriggerServerCallback('esx-races:DohvatiPermisiju', function(br)
		if perm == 1 then
			local NewBin, NewBinDistance = ESX.Game.GetClosestObject("ind_prop_firework_03")
			if NewBinDistance <= 3 then
				ESX.Game.DeleteObject(NewBin)
				SetEntityCoords(NewBin, 0, 0, 0, 1, 0, 0, 1)
			end
		else
			ESX.ShowNotification("Nemate pristup ovoj komandi!")
		end
	--end)
end, false)

RegisterCommand("obrisikontenjer", function(source, args, rawCommandString)
	--ESX.TriggerServerCallback('esx-races:DohvatiPermisiju', function(br)
		if perm == 1 then
			local NewBin, NewBinDistance = ESX.Game.GetClosestObject("prop_contr_03b_ld")
			if NewBinDistance <= 3 then
				ESX.Game.DeleteObject(NewBin)
				DeleteEntity(NewBin)
				SetEntityCoords(NewBin, 0, 0, 0, 1, 0, 0, 1)
			end
		else
			ESX.ShowNotification("Nemate pristup ovoj komandi!")
		end
	--end)
end, false)

RegisterCommand("obrisikutiju", function(source, args, rawCommandString)
	--ESX.TriggerServerCallback('esx-races:DohvatiPermisiju', function(br)
		if perm == 1 then
			local NewBin, NewBinDistance = ESX.Game.GetClosestObject("prop_box_wood05a")
			if NewBinDistance <= 3 then
				ESX.Game.DeleteObject(NewBin)
				DeleteEntity(NewBin)
				SetEntityCoords(NewBin, 0, 0, 0, 1, 0, 0, 1)
				print(NewBin)
			end
		else
			ESX.ShowNotification("Nemate pristup ovoj komandi!")
		end
	--end)
end, false)

RegisterCommand("aodg", function(source, args, rawCommandString)
	--ESX.TriggerServerCallback('esx-races:DohvatiPermisiju', function(br)
		if perm == 1 then
			--local playerIdx = GetPlayerFromServerId(tonumber(args[1]))
			--if playerIdx ~= -1 then
				if args[1] ~= nil and args[2] ~= nil then
					local razlog = table.concat(args, " ", 2)
					TriggerServerEvent("prodajoruzje:PosaljiAdmOdgovor", args[1], razlog)
					local playerName = GetPlayerName(PlayerId())
					TriggerServerEvent("prodajoruzje:SaljiInfoSvima", razlog, playerName, args[1])
					local komando = "/aodg "..args[1].." "..razlog
					TriggerServerEvent("DiscordBot:RegCmd", GetPlayerServerId(PlayerId()), komando)
				else
					name = "Admin"..":"
					message = "/aodg [ID igraca][Odgovor]"
					TriggerEvent('chat:addMessage', { args = { name, message }, color = r,g,b })
				end	
			--else
				--ESX.ShowNotification("Igrac nije online!")
			--end
		else
			ESX.ShowNotification("Nemate pristup ovoj komandi!")
		end
	--end)
end, false)

RegisterCommand("mute", function(source, args, rawCommandString)
	--ESX.TriggerServerCallback('esx-races:DohvatiPermisiju', function(br)
		if perm == 1 then
			local id = 0
			local minu = 0
			id = tonumber(args[1])
			minu = tonumber(args[2])
			if id ~= 0 and id ~= nil and minu ~= 0 and minu ~= nil then
				TriggerServerEvent("esx_rpchat:MuteGa", id, minu)
			else
				name = "Admin"..": "
				message = "/mute [id][minute]"
				TriggerEvent('chat:addMessage', { args = { name, message }, color = r,g,b })
			end
		else
			name = "System"..":"
			message = " Nemate pristup ovoj komandi"
			TriggerEvent('chat:addMessage', { args = { name, message }, color = r,g,b })	
		end
	--end)
end, false)

RegisterCommand("unmute", function(source, args, rawCommandString)
	--ESX.TriggerServerCallback('esx-races:DohvatiPermisiju', function(br)
		if perm == 1 then
			local id = 0
			id = tonumber(args[1])
			if id ~= 0 and id ~= nil then
				TriggerServerEvent("esx_rpchat:UnmuteGa", id)
			else
				name = "Admin"..": "
				message = "/unmute [id]"
				TriggerEvent('chat:addMessage', { args = { name, message }, color = r,g,b })
			end
		else
			name = "System"..":"
			message = " Nemate pristup ovoj komandi"
			TriggerEvent('chat:addMessage', { args = { name, message }, color = r,g,b })	
		end
	--end)
end, false)

local Bijela = nil
local Kugle = {}
local Stap = nil
local cam = nil
local BiljarPoly = nil

function makeEntityFaceEntity( entity1, entity2 )
    local p1 = GetEntityCoords(entity1, true)
    local p2 = GetEntityCoords(entity2, true)

    local dx = p2.x - p1.x
    local dy = p2.y - p1.y

    local heading = GetHeadingFromVector_2d(dx, dy)
    SetEntityHeading( entity1, heading )
end

local Jacina = 1.0
function Kugla()
	FreezeEntityPosition(PlayerPedId(), true)
	if Bijela == nil then
		BiljarPoly = PolyZone:Create({
			vector2(-573.28985595703, 287.63095092773),
			vector2(-572.98474121094, 290.62420654297),
			vector2(-574.79876708984, 290.81140136719),
			vector2(-575.10961914062, 287.81188964844)
		}, {
			name="biljar",
			--minZ = 79.176658630371,
			--maxZ = 79.176658630371
		})
		ESX.Game.SpawnObject('prop_poolball_5', {
			x = -573.9778,
			y = 288.2987,
			z = 79.10798-0.04
		}, function(obj)
			table.insert(Kugle, obj)
		end)
		ESX.Game.SpawnObject('prop_poolball_10', {
			x = -574.0673,
			y = 288.3078,
			z = 79.10798-0.04
		}, function(obj)
			table.insert(Kugle, obj)
		end)
		ESX.Game.SpawnObject('prop_poolball_6', {
			x = -574.1579,
			y = 288.317,
			z = 79.10798-0.04
		}, function(obj)
			table.insert(Kugle, obj)
		end)
		ESX.Game.SpawnObject('prop_poolball_15', {
			x = -574.2495,
			y = 288.3264,
			z = 79.10798-0.04
		}, function(obj)
			table.insert(Kugle, obj)
		end)
		ESX.Game.SpawnObject('prop_poolball_12', {
			x = -574.3372,
			y = 288.3376,
			z = 79.10798-0.04
		}, function(obj)
			table.insert(Kugle, obj)
		end)
		ESX.Game.SpawnObject('prop_poolball_9', {
			x = -574.2853,
			y = 288.4154,
			z = 79.10798-0.04
		}, function(obj)
			table.insert(Kugle, obj)
		end)
		ESX.Game.SpawnObject('prop_poolball_7', {
			x = -574.1944,
			y = 288.4062,
			z = 79.10798-0.04
		}, function(obj)
			table.insert(Kugle, obj)
		end)
		ESX.Game.SpawnObject('prop_poolball_11', {
			x = -574.1035,
			y = 288.3969,
			z = 79.10798-0.04
		}, function(obj)
			table.insert(Kugle, obj)
		end)
		ESX.Game.SpawnObject('prop_poolball_4', {
			x = -574.0143,
			y = 288.3879,
			z = 79.10798-0.04
		}, function(obj)
			table.insert(Kugle, obj)
		end)
		ESX.Game.SpawnObject('prop_poolball_14', {
			x = -574.0536,
			y = 288.4738,
			z = 79.10798-0.04
		}, function(obj)
			table.insert(Kugle, obj)
		end)
		ESX.Game.SpawnObject('prop_poolball_8', {
			x = -574.1403,
			y = 288.4826,
			z = 79.10798-0.04
		}, function(obj)
			table.insert(Kugle, obj)
		end)
		ESX.Game.SpawnObject('prop_poolball_3', {
			x = -574.2297,
			y = 288.4917,
			z = 79.10798-0.04
		}, function(obj)
			table.insert(Kugle, obj)
		end)
		ESX.Game.SpawnObject('prop_poolball_13', {
			x = -574.1765,
			y = 288.5623,
			z = 79.10798-0.04
		}, function(obj)
			table.insert(Kugle, obj)
		end)
		ESX.Game.SpawnObject('prop_poolball_2', {
			x = -574.085,
			y = 288.553,
			z = 79.10798-0.04
		}, function(obj)
			table.insert(Kugle, obj)
		end)
		ESX.Game.SpawnObject('prop_poolball_1', {
			x = -574.1224,
			y = 288.6299,
			z = 79.10798-0.04
		}, function(obj)
			table.insert(Kugle, obj)
		end)
		ESX.Game.SpawnObject('prop_poolball_cue', {
			x = -573.934,
			y = 290.2414,
			z = 79.10798-0.04
		}, function(obj)
			Bijela = obj
		end)
		Wait(500)
		makeEntityFaceEntity(Bijela, Kugle[15])
	end
	ESX.Game.SpawnObject('prop_pool_cue', {
		x = -573.934,
		y = 291.2414,
		z = 79.10798-0.7
	}, function(obj)
		Stap = obj
	end)
	SetEntityVelocity(Bijela, 0.0, 0.0, 0.0)
	FreezeEntityPosition(Bijela, true)
	Wait(10)
	FreezeEntityPosition(Bijela, false)
	ActivatePhysics(Bijela)
	Wait(500)
	AttachEntityToEntity(Stap, Bijela, 0, 0.0, -0.8, 0.1, -97.0, 0.0, 0.0, 10000.0, false, false, false, 0, true)
	Wait(500)
	cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
	AttachCamToEntity(cam, Stap, 0.0, -0.2, 0.0, true)
	RenderScriptCams(true, false, 0, 1, 0)
	local head = GetEntityHeading(Bijela)
	SetEntityHeading(Bijela, head+0.00001)
	Wait(10)
	local rot = GetEntityRotation(Stap, 2)
	SetCamRot(cam, rot.x-90, rot.y, rot.z, 2)
	while Stap ~= nil do
		DisableAllControlActions(0)
		local head = GetEntityHeading(Bijela)
		if IsDisabledControlPressed(0, 34) then
			SetEntityHeading(Bijela, head+0.1)
			if IsDisabledControlPressed(0, 21) then
				SetEntityHeading(Bijela, head+0.3)
			end
			local rot = GetEntityRotation(Stap, 2)
			SetCamRot(cam, rot.x-90, rot.y, rot.z, 2)
		end
		if IsDisabledControlPressed(0, 35) then
			SetEntityHeading(Bijela, head-0.1)
			if IsDisabledControlPressed(0, 21) then
				SetEntityHeading(Bijela, head-0.3)
			end
			local rot = GetEntityRotation(Stap, 2)
			SetCamRot(cam, rot.x-90, rot.y, rot.z, 2)
		end
		if IsDisabledControlJustPressed(0, 172) then
			Jacina = Jacina+1.0
			ESX.ShowNotification(Jacina)
		end
		if IsDisabledControlJustPressed(0, 173) then
			Jacina = Jacina-1.0
			if Jacina < 1.0 then
				Jacina = 1.0
			end
			ESX.ShowNotification(Jacina)
		end
		if IsDisabledControlJustPressed(0, 24) then
			FreezeEntityPosition(Stap, true)
			DetachEntity(Stap)
			local cord1 = GetEntityCoords(Stap)
			local cordsa = GetOffsetFromEntityInWorldCoords(Stap, 0.0, 0.0, -0.2)
			while not SlideObject(Stap, cordsa.x, cordsa.y, cordsa.z, 0.004, 0.004, 0.004, false) do
				Wait(1)
			end
			while not SlideObject(Stap, cord1.x, cord1.y, cord1.z, 0.004, 0.004, 0.004, false) do
				Wait(1)
			end
			RenderScriptCams(false, false, 0, 1, 0)
			DestroyCam(cam)
			ESX.Game.DeleteObject(Stap)
			Stap = nil
			local forceTypes = {
				MinForce = 0,
				MaxForceRot = 1,
				MinForce2 = 2,
				MaxForceRot2 = 3,
				ForceNoRot = 4,
				ForceRotPlusForce = 5
			}
			local cor = GetEntityCoords(Bijela)
			cordsa = GetOffsetFromEntityInWorldCoords(Bijela, 0.0, Jacina, 0.0)
			local forceType = forceTypes.MaxForceRot2
			local direction = vector3(cordsa.x-cor.x, cordsa.y-cor.y, 0.0)
			local rotation = vector3(0.0, 0.0, 0.0)
			--ApplyForceToEntity(Bijela,forceType,direction,rotation,0,false,true,true,false,true)
			SetEntityVelocity(Bijela, direction)
			local prati = true
			local rupa1 = vector3(-573.4011, 287.7688, 79.09735)
			local rupa2 = vector3(-573.2142, 289.1327, 79.09735)
			local rupa3 = vector3(-573.1126, 290.5125, 79.09735)
			local rupa4 = vector3(-574.6966, 290.6721, 79.09735)
			local rupa5 = vector3(-574.8751, 289.3098, 79.09735)
			local rupa6 = vector3(-574.9837, 287.9344, 79.09735)
			Citizen.CreateThread(function()
				while prati do
					local bcor = GetEntityCoords(Bijela)
					if #(rupa1-bcor) <= 0.12 or #(rupa2-bcor) <= 0.12 or #(rupa3-bcor) <= 0.12 or #(rupa4-bcor) <= 0.12 or #(rupa5-bcor) <= 0.12 or #(rupa6-bcor) <= 0.12 then
						print("upala")
						FreezeEntityPosition(Bijela, true)
						SetEntityCoords(Bijela, -573.934, 290.2414, 79.10798)
						FreezeEntityPosition(Bijela, false)
					end
					for i = 1, #Kugle do
						local bcor = GetEntityCoords(Kugle[i])
						if #(rupa1-bcor) <= 0.12 or #(rupa2-bcor) <= 0.12 or #(rupa3-bcor) <= 0.12 or #(rupa4-bcor) <= 0.12 or #(rupa5-bcor) <= 0.12 or #(rupa6-bcor) <= 0.12 then
							print("upala obicna")
							ESX.Game.DeleteObject(Kugle[i])
							table.remove(Kugle, i)
						end
					end
					Wait(50)
				end
			end)
			Wait(2000)
			print("stade")
			SetEntityVelocity(Bijela, 0.0, 0.0, 0.0)
			FreezeEntityPosition(Bijela, true)
			Wait(10)
			FreezeEntityPosition(Bijela, false)
			ActivatePhysics(Bijela)
			for i = 1, #Kugle do
				SetEntityVelocity(Kugle[i], 0.0, 0.0, 0.0)
				FreezeEntityPosition(Kugle[i], true)
				Wait(10)
				FreezeEntityPosition(Kugle[i], false)
				ActivatePhysics(Kugle[i])
				if not BiljarPoly:isPointInside(GetEntityCoords(Kugle[i])) then
					print("Izasla")
					SetEntityCoords(Kugle[i], -573.934, 290.2414, 79.10798) --Promjeni na neke druge koord
				end
			end
			if not BiljarPoly:isPointInside(GetEntityCoords(Bijela)) then
				print("Izasla")
				SetEntityCoords(Bijela, -573.934, 290.2414, 79.10798)
			end
			prati = false
			Wait(1000)
			Kugla()
		end
		Wait(1)
	end
	--[[SetObjectPhysicsParams(Bijela,   0.2, 1.0, 0.7, 0.0, 0.2, 1.0, 0.0, 0.0, 0.0, 0.0)
	for i = 1, #Kugle do
		SetObjectPhysicsParams(Kugle[i], 0.2, 1.0, 0.7, 0.0, 0.2, 1.0, 0.0, 0.0, 0.0, 0.0)
	end]]
end

-- RegisterCommand("kugla", function(source, args, rawCommandString)
-- 	Kugla()
-- end, false)

-- RegisterCommand("obrisi", function(source, args, rawCommandString)
-- 	FreezeEntityPosition(PlayerPedId(), false)
-- 	for i = 1, #Kugle do
-- 		ESX.Game.DeleteObject(Kugle[i])
-- 	end
-- 	Kugle = {}
-- 	ESX.Game.DeleteObject(Bijela)
-- 	ESX.Game.DeleteObject(Stap)
-- 	RenderScriptCams(false, false, 0, 1, 0)
-- 	DestroyCam(cam)
-- 	Stap = nil
-- 	Bijela = nil
-- end, false)

-- local FishRod = nil
-- RegisterCommand("teststap", function(source, args, rawCommandString)
-- 	--ESX.TriggerServerCallback('esx-races:DohvatiPermisiju', function(br)
-- 		if perm == 1 then
-- 			if FishRod == nil then
-- 				local model = GetHashKey("prop_fishing_rod_01")
-- 				RequestModel(model)
				
-- 				while not HasModelLoaded(model) do
-- 					Wait(1)
-- 				end
-- 				BoneID = GetPedBoneIndex(PlayerPedId(), 60309)
-- 				FishRod = CreateObject(model,  1729.73,  6403.90,  34.56,  true,  true,  true)
-- 				vX,vY,vZ = table.unpack(GetEntityCoords(PlayerPedId()))
-- 				xRot, yRot, zRot = table.unpack(GetEntityRotation(PlayerPedId(),2))
-- 				AttachEntityToEntity(FishRod,  PlayerPedId(),  BoneID, 0,0,0, 0,0,0,  false, false, false, false, 2, true)
-- 				SetModelAsNoLongerNeeded(model)
-- 				--FishRod = AttachEntityToPed('prop_fishing_rod_01',60309, 0,0,0, 0,0,0)
-- 			else
-- 				DeleteEntity(FishRod)
-- 				FishRod = nil
-- 			end
-- 		else
-- 			name = "System"..":"
-- 			message = " Nemate pristup ovoj komandi"
-- 			TriggerEvent('chat:addMessage', { args = { name, message }, color = r,g,b })	
-- 		end
-- 	--end)
-- end, false)

-- local trajeanim = false
-- Citizen.CreateThread(function()
-- 	while true do
-- 		Citizen.Wait(100)
-- 		if FishRod ~= nil then
-- 			if IsControlPressed(1, 24) then
-- 				if not trajeanim then
-- 					RequestAnimDict("amb@world_human_stand_fishing@idle_a")
-- 					while not HasAnimDictLoaded("amb@world_human_stand_fishing@idle_a") do
-- 						Citizen.Wait(1000)
-- 					end
-- 					TaskPlayAnim(PlayerPedId(),"amb@world_human_stand_fishing@idle_a","idle_b", 8.0, -8, -1, 2, 0, 0, 0, 0)
-- 					trajeanim = true
-- 				end
-- 			else
-- 				if trajeanim then
-- 					RequestAnimDict("amb@world_human_stand_fishing@base")
-- 					while not HasAnimDictLoaded("amb@world_human_stand_fishing@base") do
-- 						Citizen.Wait(1000)
-- 					end
-- 					TaskPlayAnim(PlayerPedId(),"amb@world_human_stand_fishing@base","base", 8.0, -8, -1, 2, 0, 0, 0, 0)
-- 					trajeanim = false
-- 				end
-- 			end
-- 		end
-- 	end
-- end)

RegisterCommand("testanim", function(source, args, rawCommandString)
	--ESX.TriggerServerCallback('esx-races:DohvatiPermisiju', function(br)
		if perm == 1 then
			RequestAnimDict(args[1])
			while not HasAnimDictLoaded(args[1]) do
				Citizen.Wait(1000)
			end
			TaskPlayAnim(PlayerPedId(),args[1],args[2], 8.0, -8, 1300, 2, 0, 0, 0, 0)
			--TaskPlayAnim(PlayerPedId(),args[1],args[2], 8.0, 8.0, -1, 50)
			--TaskStartScenarioInPlace(PlayerPedId(), args[1], 0, true)
		else
			name = "System"..":"
			message = " Nemate pristup ovoj komandi"
			TriggerEvent('chat:addMessage', { args = { name, message }, color = r,g,b })	
		end
	--end)
end, false)

RegisterCommand("testscenario", function(source, args, rawCommandString)
	--ESX.TriggerServerCallback('esx-races:DohvatiPermisiju', function(br)
		if perm == 1 then
			TaskStartScenarioInPlace(PlayerPedId(), args[1], 0, true)
		else
			name = "System"..":"
			message = " Nemate pristup ovoj komandi"
			TriggerEvent('chat:addMessage', { args = { name, message }, color = r,g,b })	
		end
	--end)
end, false)

RegisterCommand("setskin", function(source, args, rawCommandString)
	--ESX.TriggerServerCallback('esx-races:DohvatiPermisiju', function(br)
		if perm == 1 then
			local id = 0
			id = tonumber(args[1])
			if id ~= 0 and id ~= nil then
				TriggerServerEvent("prodajoruzje:DajSkin", id)
			else
				name = "Admin"..":"
				message = "/setskin [id]"
				TriggerEvent('chat:addMessage', { args = { name, message }, color = r,g,b })
			end
		else
			name = "System"..":"
			message = " Nemate pristup ovoj komandi"
			TriggerEvent('chat:addMessage', { args = { name, message }, color = r,g,b })	
		end
	--end)
end, false)

RegisterCommand("oduzmisociety", function(source, args, rawCommandString)
	--ESX.TriggerServerCallback('esx-races:DohvatiPermisiju', function(br)
		if perm == 1 then
			local ime = args[1]
			local broj = tonumber(args[2])
			if ime ~= nil and (args[2] ~= nil or args[2] ~= 0) then
				local soc = "society_"..ime
				TriggerServerEvent("ObrisiSociety", soc, broj)
			else
				name = "Admin"..":"
				message = "/oduzmisociety [Ime mafije][Iznos]"
				TriggerEvent('chat:addMessage', { args = { name, message }, color = r,g,b })
			end
		else
			name = "System"..":"
			message = " Nemate pristup ovoj komandi"
			TriggerClientEvent('chat:addMessage', { args = { name, message }, color = r,g,b })	
		end
	--end)
end, false)

RegisterCommand("a", function(source, args, rawCommandString)
	--ESX.TriggerServerCallback('esx-races:DohvatiPermisiju', function(br)
		if perm == 1 then
				if args[1] ~= nil then
					local playerName = GetPlayerName(PlayerId())
					TriggerServerEvent("prodajoruzje:PosaljiRadio2Server", table.concat(args, " "), playerName)
				else
					name = "System"..":"
					message = " /a [Poruka]"
					TriggerEvent('chat:addMessage', { args = { name, message }, color = r,g,b })
				end	
		else
			name = "System"..":"
			message = " Nemate pristup ovoj komandi"
			TriggerEvent('chat:addMessage', { args = { name, message }, color = r,g,b })	
		end
	--end)
end, false)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  ESX.PlayerData.job = job
  PlayerData.job = job
end) 

RegisterNetEvent('prodajoruzje:TestSkina')
AddEventHandler('prodajoruzje:TestSkina', function()
	SetPedComponentVariation(PlayerPedId(), 1, 0 ,0, 2)
end) 

RegisterNetEvent('prodajoruzje:EoTiSkinic')
AddEventHandler('prodajoruzje:EoTiSkinic', function()
	local model = "s_m_m_pilot_01"
	RequestModel(model)
    while not HasModelLoaded(model) do
        RequestModel(model)
        Citizen.Wait(1)
    end

    SetPlayerModel(PlayerId(), model)
    SetModelAsNoLongerNeeded(model)
end) 

function GetClosestPlayer()
    local players = GetPlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local ply = GetPlayerPed(-1)
    local plyCoords = GetEntityCoords(ply, 0)
    
    for index,value in ipairs(players) do
        local target = GetPlayerPed(value)
        if(target ~= ply) then
            local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
            local distance = Vdist(targetCoords["x"], targetCoords["y"], targetCoords["z"], plyCoords["x"], plyCoords["y"], plyCoords["z"])
            if(closestDistance == -1 or closestDistance > distance) then
                closestPlayer = value
                closestDistance = distance
            end
        end
    end
    
    return closestPlayer, closestDistance
end

function GetPlayers()
    local players = {}

    for i = 0, 255 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end

    return players
end

RegisterCommand("sjedi", function(source, args, rawCommandString)
	local ped = PlayerPedId()
	local cord = GetEntityCoords(ped)
	local head = GetEntityHeading(ped)
	--TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_SEAT_BENCH", 0, true)
	
	ESX.Streaming.RequestAnimDict("anim@heists@prison_heistunfinished_biztarget_idle", function()
		TaskPlayAnim(PlayerPedId(), "anim@heists@prison_heistunfinished_biztarget_idle", "target_idle", 8.0, -8.0, -1, 0, 0, false, false, false)
	end)
	
	ESX.ShowNotification("Pritisnite X da se ustanete")
end, false)

RegisterCommand("vtest", function(source, args, rawCommandString)
	--ESX.TriggerServerCallback('esx-races:DohvatiPermisiju', function(br)
		if perm == 1 then
			SetVehicleEnginePowerMultiplier(GetVehiclePedIsIn(PlayerPedId(), false) , 1000000000)
			print("doso tu ")
			Citizen.CreateThread(function()
				while true do
					SetVehicleEngineTorqueMultiplier(GetVehiclePedIsIn(PlayerPedId(), false), 500.0)
					Wait(0)
				end
			end)
		else
			ESX.ShowNotification("Nemate pristup ovoj komandi!")
		end
	--end)
end, false)

function DajImeOruzja(hash)
	local ime = "Nema"
	if hash == -102323637 then
		ime = "WEAPON_BOTTLE"
	elseif hash == -1813897027 then
		ime = "WEAPON_GRENADE"
	elseif hash == 741814745 then
		ime = "WEAPON_STICKYBOMB"
	elseif hash == -494615257 then
		ime = "WEAPON_ASSAULTSHOTGUN"
	elseif hash == -1654528753 then
		ime = "WEAPON_BULLPUPSHOTGUN"
	elseif hash == 2017895192 then
		ime = "WEAPON_SAWNOFFSHOTGUN"
	elseif hash == 487013001 then
		ime = "WEAPON_PUMPSHOTGUN"
	elseif hash == 205991906 then
		ime = "WEAPON_HEAVYSNIPER"
	elseif hash == 100416529 then
		ime = "WEAPON_SNIPERRIFLE"
	elseif hash == -1357824103 then
		ime = "WEAPON_ADVANCEDRIFLE"
	elseif hash == -2084633992 then
		ime = "WEAPON_CARBINERIFLE"
	elseif hash == 2144741730 then
		ime = "WEAPON_COMBATMG"
	elseif hash == -1660422300 then
		ime = "WEAPON_MG"
	elseif hash == -270015777 then
		ime = "WEAPON_ASSAULTSMG"
	elseif hash == 736523883 then
		ime = "WEAPON_SMG"
	elseif hash == 324215364 then
		ime = "WEAPON_MICROSMG"
	elseif hash == 911657153 then
		ime = "WEAPON_STUNGUN"
	elseif hash == 584646201 then
		ime = "WEAPON_APPISTOL"
	elseif hash == -1716589765 then
		ime = "WEAPON_PISTOL50"
	elseif hash == 1593441988 then
		ime = "WEAPON_COMBATPISTOL"
	elseif hash == 453432689 then
		ime = "WEAPON_PISTOL"
	elseif hash == -1076751822 then
		ime = "WEAPON_SNSPISTOL"
	elseif hash == -1045183535 then
		ime = "WEAPON_REVOLVER"   
	elseif hash == -538741184 then   
		ime = "WEAPON_SWITCHBLADE"   
	elseif hash == 317205821 then    
		ime = "WEAPON_AUTOSHOTGUN"   
	elseif hash == -853065399 then   
		ime = "WEAPON_BATTLEAXE"   
	elseif hash == 125959754 then    
		ime = "WEAPON_COMPACTLAUNCHER"  
	elseif hash == -1121678507 then   
		ime = "WEAPON_MINISMG"    
	elseif hash == -1169823560 then    
		ime = "WEAPON_PIPEBOMB"    
	elseif hash == -1810795771 then    
		ime = "WEAPON_POOLCUE"    
	elseif hash == 419712736 then    
		ime = "WEAPON_WRENCH"   
	elseif hash == -1420407917 then   
		ime = "WEAPON_PROXMINE"   
	elseif hash == 1672152130 then    
		ime = "WEAPON_HOMINGLAUNCHER"    
	elseif hash == 3219281620 then    
		ime = "WEAPON_PISTOL_MK2"    
	elseif hash == 2024373456 then    
		ime = "WEAPON_SMG_MK2"   
	elseif hash == 961495388 then   
		ime = "WEAPON_ASSAULTRIFLE_MK2"
	elseif hash == -1074790547 then
		ime = "WEAPON_ASSAULTRIFLE"
	elseif hash == 4208062921 then   
		ime = "WEAPON_CARBINERIFLE_MK2"    
	elseif hash == 3686625920 then    
		ime = "WEAPON_COMBATMG_MK2"   
	elseif hash == 177293209 then    
		ime = "WEAPON_HEAVYSNIPER_MK2"    
	elseif hash == -1951375401 then    
		ime = "WEAPON_FLASHLIGHT"   
	elseif hash == 1198879012 then    
		ime = "WEAPON_FLAREGUN"    
	elseif hash == -581044007 then    
		ime = "WEAPON_MACHETE"   
	elseif hash == -619010992 then    
		ime = "WEAPON_MACHINEPISTOL"   
	elseif hash == -275439685 then
		ime = "WEAPON_DBSHOTGUN" 
	elseif hash == 1649403952 then   
		ime = "WEAPON_COMPACTRIFLE"   
	elseif hash == 171789620 then   
		ime = "WEAPON_COMBATPDW"  
	elseif hash == -771403250 then   
		ime = "WEAPON_HEAVYPISTOL"   
	elseif hash == -1063057011 then  
		ime = "WEAPON_SPECIALCARBINE"   
	elseif hash == -656458692 then   
		ime = "WEAPON_KNUCKLE"   
	elseif hash == -598887786 then   
		ime = "WEAPON_MARKSMANPISTOL"    
	elseif hash == 2132975508 then    
		ime = "WEAPON_BULLPUPRIFLE"    
	elseif hash == -1834847097 then   
		ime = "WEAPON_DAGGER"   
	elseif hash == 137902532 then   
		ime = "WEAPON_VINTAGEPISTOL"   
	elseif hash == 2138347493 then    
		ime = "WEAPON_FIREWORK"   
	elseif hash == -1466123874 then   
		ime = "WEAPON_MUSKET"    
	elseif hash == 984333226 then    
		ime = "WEAPON_HEAVYSHOTGUN"  
	elseif hash == -952879014 then   
		ime = "WEAPON_MARKSMANRIFLE"   
	elseif hash == 1627465347 then 
		ime = "WEAPON_GUSENBERG"  
	elseif hash == -102973651 then   
		ime = "WEAPON_HATCHET" 
	elseif hash == 1834241177 then  
		ime = "WEAPON_RAILGUN"  
	elseif hash == 1119849093 then  
		ime = "WEAPON_MINIGUN"   
	elseif hash ==3415619887 then   
		ime = "WEAPON_REVOLVER_MK2"    
	elseif hash == 2548703416 then    
		ime = "WEAPON_DOUBLEACTION"  
	elseif hash ==2526821735 then   
		ime = "WEAPON_SPECIALCARBINE_MK2"    
	elseif hash == 2228681469 then   
		ime = "WEAPON_BULLPUPRIFLE_MK2"    
	elseif hash == 1432025498 then   
		ime = "WEAPON_PUMPSHOTGUN_MK2"
	elseif hash == 1785463520 then 
		ime = "WEAPON_MARKSMANRIFLE_MK2"
	end
	return ime
end

RegisterCommand('rpchat', function(source, args, rawCommand)
	--ESX.TriggerServerCallback('esx-races:DohvatiPermisiju', function(br)
		if perm == 1 then
			TriggerServerEvent("PromjeniGlobal")
		end
	--end)
end, false)
	
RegisterCommand("uauto", function(source, args, rawCommandString)
	--ESX.TriggerServerCallback('esx-races:DohvatiPermisiju', function(br)
		if perm == 1 then
			local closestVehicle, Distance = ESX.Game.GetClosestVehicle()
			if closestVehicle ~= nil then
				if Distance <= 8.0 then
					NetworkRequestControlOfEntity(closestVehicle)
					TaskWarpPedIntoVehicle(PlayerPedId(), closestVehicle, -1)	
				end
			end
		else
			ESX.ShowNotification("Nemate ovlasti!")
		end
	--end)
end, false)

RegisterCommand("dvi", function(source, args, rawCommandString)
	--ESX.TriggerServerCallback('esx-races:DohvatiPermisiju', function(br)
		if perm == 1 then
			ObrisiBlizu()
		else
			ESX.ShowNotification("Nemate ovlasti!")
		end
	--end)
end, false)

RegisterCommand("dvu", function(source, args, rawCommandString)
	--ESX.TriggerServerCallback('esx-races:DohvatiPermisiju', function(br)
		if perm == 1 then
			ObrisiUnisten()
		else
			ESX.ShowNotification("Nemate ovlasti!")
		end
	--end)
end, false)


RegisterCommand("brnace", function(source, args, rawCommandString)
	--ESX.TriggerServerCallback('esx-races:DohvatiPermisiju', function(br)
		if perm == 1 then
			ObrisiBrnace()
		end
	--end)
end, false)

function VehicleInFront()
    local pos = GetEntityCoords(GetPlayerPed(-1))
    local entityWorld = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 4.0, 0.0)
    local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, GetPlayerPed(-1), 0)
    local a, b, c, d, result = GetRaycastResult(rayHandle)
    return result
end

function ObrisiBlizu()
	local closestVehicle, Distance = ESX.Game.GetClosestVehicle()
	if closestVehicle ~= nil then
		if Distance <= 8.0 then
			local attempt = 0
			while not NetworkHasControlOfEntity(closestVehicle) and attempt < 100 and DoesEntityExist(closestVehicle) do
				Citizen.Wait(100)
				NetworkRequestControlOfEntity(closestVehicle)
				attempt = attempt + 1
			end

			if DoesEntityExist(closestVehicle) and NetworkHasControlOfEntity(closestVehicle) then
				ESX.TriggerServerCallback('mafije:DohvatiKamion', function(odg)
					if odg ~= false then
						NetworkRequestControlOfEntity(NetToObj(odg.Obj1))
						NetworkRequestControlOfEntity(NetToObj(odg.Obj2))
						NetworkRequestControlOfEntity(NetToObj(odg.Obj3))
						ESX.Game.DeleteObject(NetToObj(odg.Obj1))
						ESX.Game.DeleteObject(NetToObj(odg.Obj2))
						ESX.Game.DeleteObject(NetToObj(odg.Obj3))
						ESX.Game.DeleteVehicle(closestVehicle)
					else
						ESX.Game.DeleteVehicle(closestVehicle)
					end
				end, VehToNet(closestVehicle))
			end
		end
	end
end

function ObrisiUnisten()
	local closestVehicle, Distance = ESX.Game.GetClosestVehicle()
	NetworkRequestControlOfEntity(closestVehicle)
	if closestVehicle ~= nil then
		if Distance <= 8.0 then
			if GetEntityHealth(closestVehicle) == 0 then
				ESX.TriggerServerCallback('mafije:DohvatiKamion', function(odg)
					if odg ~= false then
						NetworkRequestControlOfEntity(NetToObj(odg.Obj1))
						NetworkRequestControlOfEntity(NetToObj(odg.Obj2))
						NetworkRequestControlOfEntity(NetToObj(odg.Obj3))
						ESX.Game.DeleteObject(NetToObj(odg.Obj1))
						ESX.Game.DeleteObject(NetToObj(odg.Obj2))
						ESX.Game.DeleteObject(NetToObj(odg.Obj3))
						SetEntityAsNoLongerNeeded(closestVehicle)
						ESX.Game.DeleteVehicle(closestVehicle)
					else
						SetEntityAsNoLongerNeeded(closestVehicle)
						ESX.Game.DeleteVehicle(closestVehicle)
					end
				end, VehToNet(closestVehicle))
            end				
		end
	end
end


function ObrisiBrnace()
    local ped = PlayerPedId()
    local coords = GetEntityCoords( ped )
	for veh in EnumerateVehicles() do
            if DoesEntityExist(veh) then
				local vcord = GetEntityCoords(veh)
				if GetDistanceBetweenCoords(coords, vcord, false) <= 5.0 then
					SetEntityAsNoLongerNeeded(veh)
					ESX.Game.DeleteVehicle(veh)
				end
			end
	end
end

local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
  return coroutine.wrap(function()
    local iter, id = initFunc()
    if not id or id == 0 then
      disposeFunc(iter)
      return
    end
    
    local enum = {handle = iter, destructor = disposeFunc}
    setmetatable(enum, entityEnumerator)
    
    local next = true
	local player
    repeat
	  player = false
      for i = 0, 255 do
          if (id == GetPlayerPed(i)) then
            player = true
          end
      end
	  if not player then
        coroutine.yield(id)
	  end
      next, id = moveFunc(iter)
    until not next
    
    enum.destructor, enum.handle = nil, nil
    disposeFunc(iter)
  end)
end

function EnumerateVehicles()
  return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end
		
RegisterNetEvent("prodajoruzje:PokaziClanove")
AddEventHandler('prodajoruzje:PokaziClanove', function(elem)
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'employee_list', {
		title    = "Online clanovi",
		align    = 'top-left',
		elements = elem
	}, function(data, menu)
		menu.close()	
	end, function(data, menu)
		menu.close()
	end)
end)

RegisterNetEvent("prodajoruzje:PokaziLidere")
AddEventHandler('prodajoruzje:PokaziLidere', function(elem)
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'employee_list', {
		title    = "Online lideri",
		align    = 'top-left',
		elements = elem
	}, function(data, menu)
		menu.close()	
	end, function(data, menu)
		menu.close()
	end)
end)

RegisterNetEvent("prodajoruzje:PokaziSveLidere")
AddEventHandler('prodajoruzje:PokaziSveLidere', function(elem)
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'employee_list', {
		title    = "Svi lideri",
		align    = 'top-left',
		elements = elem
	}, function(data, menu)
		menu.close()	
	end, function(data, menu)
		menu.close()
	end)
end)

RegisterNetEvent("prodajoruzje:PosaljiRadio")
AddEventHandler('prodajoruzje:PosaljiRadio', function(odg, ime, posao)
	if ESX ~= nil then
		if ESX.PlayerData.job ~= nil then
			if ESX.PlayerData.job.name == posao then
				if ESX.PlayerData.job.name == "police" then
					TriggerEvent('chat:addMessage', {
								template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 51, 204, 0.6); border-radius: 3px;"><i class="fas fa-info-circle"></i>[Policija] {0}:<br> {1}</div>',
								args = { ime, odg }
					})
				else
					TriggerEvent('chat:addMessage', {
								template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 51, 204, 0.6); border-radius: 3px;"><i class="fas fa-info-circle"></i>[Mehanicari] {0}:<br> {1}</div>',
								args = { ime, odg }
					})
				end
			end
		end
	end
end)

RegisterNetEvent("prodajoruzje:VratiInfoSvima")
AddEventHandler('prodajoruzje:VratiInfoSvima', function(odg, ime, ime2)
	while ESX == nil do
		Wait(0)
	end
	--ESX.TriggerServerCallback('esx-races:DohvatiPermisiju', function(br)
		if perm == 1 then
			TriggerEvent('chat:addMessage', {
						template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(226, 109, 17, 0.6); border-radius: 3px;"><i class="fas fa-info-circle"></i>[ADMIN ODGOVOR] {0} je odgovorio {1}: <br> {2}</div>',
						args = { ime, ime2, odg }
			})
		end
	--end)
end)

RegisterNetEvent("prodajoruzje:PosaljiRadio2")
AddEventHandler('prodajoruzje:PosaljiRadio2', function(odg, ime)
	--ESX.TriggerServerCallback('esx-races:DohvatiPermisiju', function(br)
		if perm == 1 then
			TriggerEvent('chat:addMessage', {
						template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(51, 153, 255, 0.6); border-radius: 3px;"><i class="fas fa-info-circle"></i>[ADMIN CHAT] {0}:<br> {1}</div>',
						args = { ime, odg }
			})
		end
	--end)
end)

RegisterNetEvent("prodajoruzje:VratiAdmOdgovor")
AddEventHandler('prodajoruzje:VratiAdmOdgovor', function(odg)
	TriggerEvent('chat:addMessage', {
					template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 255, 97, 0.6); border-radius: 3px;"><i class="fas fa-user-shield"></i> {0}:<br> {1}</div>',
					args = { "Odgovor admina", odg }
	})
end)

RegisterNetEvent("prodajoruzje:Saljem3")
AddEventHandler('prodajoruzje:Saljem3', function(cijena, kol, pid)
	CijenaDroge = cijena
	Kolicina = kol
	Prodavac2 = pid
	local str = "Ukoliko zelite kupiti "..kol.."g kokaina za "..cijena.."$ upisite /prihvatikokain"
	ESX.ShowNotification(str)
end)

RegisterNetEvent("prodajoruzje:Saljem2")
AddEventHandler('prodajoruzje:Saljem2', function(cijena, kol, pid)
	CijenaDroge = cijena
	Kolicina = kol
	Prodavac2 = pid
	local str = "Ukoliko zelite kupiti "..kol.."g marihuane za "..cijena.."$ upisite /prihvatidrogu"
	ESX.ShowNotification(str)
end)

RegisterNetEvent("prodajoruzje:Saljem")
AddEventHandler('prodajoruzje:Saljem', function(oruzje, cijena, ammo, pid)
    Oruzje = oruzje
	Cijena = cijena
	Metci = ammo
	Prodavac = pid
	local label = ESX.GetWeaponLabel(DajImeOruzja(oruzje))
	local str = "Ukoliko zelite kupiti "..label.." sa "..Metci.." metaka za "..cijena.."$ upisite /prihvatioruzje"
	ESX.ShowNotification(str)
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  	ESX.PlayerData = xPlayer
  	PlayerData = xPlayer
    TriggerServerEvent("gepeke:getOwnedVehicule")
	ESX.TriggerServerCallback('gepek:DohvatiTezine',function(tez)
		arrayWeight = tez
	end)
end)

RegisterNetEvent('gepek:EoTiTezine')
AddEventHandler('gepek:EoTiTezine', function(nest)
  	arrayWeight = nest
end)

RegisterNetEvent('gepeke:setOwnedVehicule')
AddEventHandler('gepeke:setOwnedVehicule', function(vehicle)
    vehiclePlate = vehicle
end)