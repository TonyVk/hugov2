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

ESX = nil
local Praone = {}
local Blipovi = {}
local Cpovi = {}
local perm 						= 0
local HasAlreadyEnteredMarker = false
local LastZone                = nil
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while ESX.GetPlayerData().job == nil do
        Citizen.Wait(100)
    end
	Wait(500)
	ESX.TriggerServerCallback('esx-races:DohvatiPermisiju', function(br)
		perm = br
	end)
    ESX.TriggerServerCallback('praone:DohvatiPraone', function(vr)
		Praone = vr
		SpawnCpove()
		SpawnBlipove()
	end)
end)

AddEventHandler("playerSpawned", function()
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
	for i=1, #Praone, 1 do
		if Praone[i].pranje then
			table.insert(Cpovi, {pID = Praone[i].ID, Ime = "pranje", ID = check, Koord = Praone[i].pranje, Spawnan = false, r = 0, g = 157, b = 0})
		end
		if Praone[i].koord then
			table.insert(Cpovi, {pID = Praone[i].ID, Ime = "vlasnik", ID = check, Koord = Praone[i].koord, Spawnan = false, r = 0, g = 102, b = 255})
		end
	end
end

function SpawnBlipove()
	for i=1, #Blipovi, 1 do
		RemoveBlip(Blipovi[i].blip)
	end
	Blipovi = {}
	for i=1, #Praone, 1 do
		if Praone[i] ~= nil then
			if Praone[i].pranje then
				ESX.TriggerServerCallback('praone:JesilVlasnik', function(br, kuplj)
					if br then
						local blip = AddBlipForCoord(Praone[i].pranje)
						SetBlipSprite(blip, 100)
						SetBlipColour(blip, 3)
						SetBlipAsShortRange(blip, true)
						BeginTextCommandSetBlipName('STRING')
						AddTextComponentString('Vasa praonica auta')
						EndTextCommandSetBlipName(blip)
						table.insert(Blipovi, {ID = Praone[i].ID, blip = blip})
					else
						local blip = AddBlipForCoord(Praone[i].pranje)
						SetBlipSprite(blip, 100)
						SetBlipAsShortRange(blip, true)
						BeginTextCommandSetBlipName('STRING')
						AddTextComponentString(_U('blip_carwash'))
						EndTextCommandSetBlipName(blip)
						table.insert(Blipovi, {ID = Praone[i].ID, blip = blip})
					end
				end, Praone[i].ID)
			end
		end
	end
end

RegisterNetEvent('praone:VratiPraone')
AddEventHandler('praone:VratiPraone', function(pr)
	Praone = pr
	SpawnCpove()
	SpawnBlipove()
end)

RegisterCommand("uredipraone", function(source, args, raw)
    if perm == 1 then
        local elements = {}
        
		table.insert(elements, {label = "Dodaj praonu", value = "nova"})
        for i=1, #Praone, 1 do
            if Praone[i] ~= nil then
                table.insert(elements, {label = "Praona "..Praone[i].ID, value = Praone[i].ID})
            end
        end

        ESX.UI.Menu.Open(
            'default', GetCurrentResourceName(), 'upra',
            {
                title    = "Izaberite praonu",
                align    = 'top-left',
                elements = elements,
            },
            function(data, menu)
				if data.current.value == "nova" then
					ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'pkcij', {
						title = "Upisite cijenu praone",
					}, function (datari, menuri)
						local pCijena = tonumber(datari.value)				
						if pCijena == nil or pCijena <= 0 then
							ESX.ShowNotification('Greska.')
						else
							menu.close()
							menuri.close()
							local coord = GetEntityCoords(PlayerPedId())
							coord = coord-vector3(0.0, 0.0, 1.0)
							TriggerServerEvent("praone:DodajNovu", coord, pCijena)
							Wait(500)
							ExecuteCommand("uredipraone")
						end
					end, function (datari, menuri)
						menuri.close()
					end)
				else
					local pID = data.current.value
					menu.close()
					local id
					for i = 1, #Praone do
						if Praone[i].ID == pID then
							id = i
							break
						end
					end
					elements = {}
					table.insert(elements, {label = "Postavi koordinate pranja", value = "pranje"})
					table.insert(elements, {label = "Postavi koordinate vlasnik menua", value = "vlmenu"})
					table.insert(elements, {label = "Portaj se", value = "port"})
					table.insert(elements, {label = "Makni vlasnika", value = "vlasnik"})
					table.insert(elements, {label = "Promjeni cijenu pranja", value = "cijena"})
					table.insert(elements, {label = "Promjeni cijenu firme", value = "kcijena"})
					table.insert(elements, {label = "Obrisi praonu", value = "obrisi"})
					ESX.UI.Menu.Open(
						'default', GetCurrentResourceName(), 'upraonu',
						{
							title    = "Izaberite opciju",
							align    = 'top-left',
							elements = elements,
						},
						function(data2, menu2)
							if data2.current.value == "cijena" then
								ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'pcij', {
									title = "Upisite novu cijenu pranja",
								}, function (datari, menuri)
									local pCijena = tonumber(datari.value)				
									if pCijena == nil or pCijena <= 0 then
										ESX.ShowNotification('Greska.')
									else
										menuri.close()
										TriggerServerEvent("praone:UrediCijenu", pID, pCijena)
									end
								end, function (datari, menuri)
									menuri.close()
								end)
							elseif data2.current.value == "port" then
								SetEntityCoords(PlayerPedId(), Praone[id].koord)
							elseif data2.current.value == "pranje" then
								local kord = GetEntityCoords(PlayerPedId())
								kord = kord-vector3(0.0, 0.0, 1.0)
								TriggerServerEvent("praone:SpremiPranje", pID, kord)
							elseif data2.current.value == "vlasnik" then
								TriggerServerEvent("praone:MakniVlasnika", pID)
							elseif data2.current.value == "obrisi" then
								for i=1, #Blipovi, 1 do
									if Blipovi[i].ID == pID then
										RemoveBlip(Blipovi[i].blip)
										break
									end
								end
								TriggerServerEvent("praone:ObrisiPraone", pID)
								menu2.close()
								Wait(500)
								ExecuteCommand("uredipraone")
							elseif data2.current.value == "kcijena" then
									ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'pcij2', {
										title = "Upisite novu cijenu praone",
									}, function (datari, menuri)
										local pCijena = tonumber(datari.value)				
										if pCijena == nil or pCijena <= 0 then
											ESX.ShowNotification('Greska.')
										else
											menuri.close()
											TriggerServerEvent("praone:UrediCijenuPraone", pID, pCijena)
										end
									end, function (datari, menuri)
										menuri.close()
									end)
							elseif data2.current.value == "vlmenu" then
								local kord = GetEntityCoords(PlayerPedId())
								kord = kord-vector3(0.0, 0.0, 1.0)
								TriggerServerEvent("praone:SpremiVlMenu", pID, kord)
							end
						end,
						function(data2, menu2)
							
							menu2.close()
						end
					)
				end
            end,
            function(data, menu)
                menu.close()
            end
        )
    else
        ESX.ShowNotification("Niste admin!")
    end
end, false)

Citizen.CreateThread(function()
	local waitara = 500
	while true do
		Citizen.Wait(waitara)
		local nasosta = 0
		local coords      = GetEntityCoords(PlayerPedId())
		local isInMarker  = false
		local currentZone = nil
		local prID = nil

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
						local range = 3.0
						if Cpovi[i].Ime == "vlasnik" then
							range = 1.5
						end
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
						if Cpovi[i].Ime == "pranje" then
							isInMarker  = true
							currentZone = "pranje_menu"
							LastZone    = i
							prID = Cpovi[i].pID
							break
						elseif Cpovi[i].Ime == "vlasnik" then
							isInMarker  = true
							currentZone = "vl_menu"
							LastZone    = i
							prID = Cpovi[i].pID
							break
						end
					end
				end
			end
		end
		if isInMarker and not HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = true
			TriggerEvent('praone:hasEnteredMarker', currentZone, prID)
		end
		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('praone:hasExitedMarker', LastZone)
		end
		
		if nasosta == 0 then
			waitara = 500
		end
	end
end)

AddEventHandler('praone:hasEnteredMarker', function(zone, id)
	CurrentAction = zone
	if zone == "pranje_menu" then
		CurrentActionMsg  = "Pritisnite ~INPUT_CONTEXT~ da oprerete vozilo"
	elseif zone == "vl_menu" then
		CurrentActionMsg  = "Pritisnite ~INPUT_CONTEXT~ da otvorite vlasnik menu"
	end
	CurrentActionData = {zone = zone, id = id}
end)

AddEventHandler('praone:hasExitedMarker', function(zone)
	CurrentAction = nil
	CurrentTip = nil
	ESX.UI.Menu.CloseAll()
end)

-- Key Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if CurrentAction ~= nil then
			ESX.ShowHelpNotification(CurrentActionMsg)
			if IsControlJustReleased(0, Keys['E']) then
				if CurrentAction == 'pranje_menu' then
					OtvoriPranje(CurrentActionData.id)
				elseif CurrentAction == 'vl_menu' then
					OtvoriVlasnik(CurrentActionData.id)
				end
				CurrentAction = nil
			end
		else
			Citizen.Wait(500)
		end
	end
end)

function OtvoriPranje(id)
	ESX.TriggerServerCallback('praone:DajCijenu', function(cijena)
		TriggerEvent("upit:OtvoriPitanje", GetCurrentResourceName(), "Pranje auta", "Zelite li oprati auto za $"..cijena.."?", {id = id})
	end, id)
end

RegisterNUICallback(
    "zatvoriupit",
    function(data, cb)
		local br = data.br
		local args = data.args
		if br == 1 then
			if args.kupi then
				TriggerServerEvent("praone:KupiPraonu", args.id)
				HasAlreadyEnteredMarker = false
			else
				if args.cijena then
					TriggerServerEvent("praone:PrihvatiPonudu", args.orgIgr, args.id, args.cijena)
				else
					if CanWashVehicle() then
						local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
						if GetVehicleDirtLevel(vehicle) > 2 then
							WashVehicle(args.id)
						else
							ESX.ShowNotification(_U('wash_failed_clean'))
						end
					end
				end
			end
		else
			if args.cijena then
				TriggerServerEvent("praone:OdbijPonudu", args.orgIgr)
			end
		end
    end
)

function OtvoriVlasnik(pid)
	ESX.TriggerServerCallback('praone:JesilVlasnik', function(br, kuplj)
		if br then
			local id
			for i = 1, #Praone do
				if Praone[i].ID == pid then
					id = i
					break
				end
			end
			local elements = {}

			table.insert(elements, {label = "Sef", value = "sef"})
			table.insert(elements, {label = "Prodaj drzavi ($"..math.ceil(Praone[id].kcijena/2)..")", value = "prodaj"})
			table.insert(elements, {label = "Prodaj igracu", value = "prodaj2"})

			ESX.UI.Menu.Open(
				'default', GetCurrentResourceName(), 'pvlmen',
				{
					title    = "Izaberite opciju",
					align    = 'top-left',
					elements = elements,
				},
				function(data, menu)
					if data.current.value == "sef" then
						elements = {}
						table.insert(elements, {label = "Stanje sefa", value = "stanje"})
						table.insert(elements, {label = "Uzmi iz sefa", value = "uzmi"})
						ESX.UI.Menu.Open(
							'default', GetCurrentResourceName(), 'uzmikurac1',
							{
								title    = "Izaberite opciju",
								align    = 'top-left',
								elements = elements,
							},
							function(data3, menu3)
								if data3.current.value == "stanje" then
									TriggerServerEvent("praone:StanjeSefa", pid)
								elseif data3.current.value == "uzmi" then
									ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'uzsefp', {
										title = "Upisite kolicinu",
									}, function (datar, menur)
										local cij = tonumber(datar.value)
										if cij == nil or cij <= 0 then
											ESX.ShowNotification('Greska.')
										else
											menur.close()
											TriggerServerEvent("praone:UzmiIzSefa", pid, cij)
										end
									end, function (datar, menur)
										menur.close()
									end)
								end
							end,
							function(data3, menu3)
								menu3.close()
							end
						)
					elseif data.current.value == "prodaj" then
						ESX.UI.Menu.CloseAll()
						TriggerServerEvent("praone:ProdajPraonu", pid)
					elseif data.current.value == "prodaj2" then
						ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'cijprp', {
							title = "Upisite cijenu",
						}, function (datar, menur)
							local cij = tonumber(datar.value)
							if cij == nil or cij <= 0 then
								ESX.ShowNotification('Greska.')
							else
								menur.close()
								local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
								if closestPlayer ~= -1 and closestDistance <= 3.0 then
									TriggerServerEvent("praone:PonudiIgracu", pid, cij, GetPlayerServerId(closestPlayer))
									ESX.UI.Menu.CloseAll()
								else
									ESX.ShowNotification("Nema igraca u blizini!")
								end
							end
						end, function (datar, menur)
							menur.close()
						end)
					end
				end,
				function(data, menu)
					menu.close()
				end
			) 
		else
			if not kuplj then
				ESX.TriggerServerCallback('praone:DajProdajnu', function(cij)
					TriggerEvent("upit:OtvoriPitanje", GetCurrentResourceName(), "Praona", "Zelite li kupiti praonicu auta za $"..cij.."?", {kupi = true, id = pid})
				end, pid)
			else
				ESX.ShowNotification("Praona je vec kupljena!")
			end
		end
	end, pid)
end

function CanWashVehicle()
	local playerPed = PlayerPedId()

	if IsPedSittingInAnyVehicle(playerPed) then
		local vehicle = GetVehiclePedIsIn(playerPed, false)

		if GetPedInVehicleSeat(vehicle, -1) == playerPed then
			return true
		end
	end

	return false
end

function WashVehicle(id)
	ESX.TriggerServerCallback('praone:OperiMe', function(canAfford, cijena)
		if canAfford then
			local ped = PlayerPedId()
			local vehicle = GetVehiclePedIsUsing(ped)
			local dirtLevel = GetVehicleDirtLevel(vehicle)
			local coords = GetEntityCoords(ped)
			FreezeEntityPosition(vehicle, true)
			if not HasNamedPtfxAssetLoaded("core") then
				RequestNamedPtfxAsset("core")
				while not HasNamedPtfxAssetLoaded("core") do
					Citizen.Wait(10)
				end
			end
			UseParticleFxAssetNextCall("core")
			local splashLeft = StartParticleFxLoopedAtCoord("ent_amb_waterfall_splash_p", coords.x, coords.y+0.5, coords.z, 0.0, 0.0, 90.0, 1.0, false, false, false, false)
			UseParticleFxAssetNextCall("core")
			local splashRight = StartParticleFxLoopedAtCoord("ent_amb_waterfall_splash_p", coords.x, coords.y + 2, coords.z, 0.0, 0.0, 90.0, 1.0, false, false, false, false)
			while dirtLevel > 0 do
				dirtLevel = dirtLevel - 0.5
				SetVehicleDirtLevel(vehicle, dirtLevel)
				Citizen.Wait(2000)
			end
			SetVehicleDirtLevel(vehicle, 0)
			WashDecalsFromVehicle(vehicle, 1.0)
			StopParticleFxLooped(splashLeft, 0)
			StopParticleFxLooped(splashRight, 0)
			FreezeEntityPosition(vehicle, false)
			ESX.ShowNotification(_U('wash_successful_paid', ESX.Math.GroupDigits(cijena)))
		else
			ESX.ShowNotification(_U('wash_failed'))
		end
	end, id)
end
