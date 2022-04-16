--Zavrsi uzimanje vozila, kupovinu renta, dodaj blipove na mapu, kupovina vozila od strane vlasnika i postavljanje cijene???

ESX                             = nil
local perm 						= 0
local Rent                      = {}
local Cpovi 					= {}
local CurrentAction             = nil
local GUI                       = {}
GUI.Time                        = 0
local HasAlreadyEnteredMarker   = false
local LastZone                  = nil
local CurrentActionMsg          = ''
local CurrentActionData         = {}


Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
    ProvjeriPosao()
end)

function ProvjeriPosao()
	ESX.PlayerData = ESX.GetPlayerData()
	ESX.TriggerServerCallback('esx-races:DohvatiPermisiju', function(br)
		perm = br
	end)
    ESX.TriggerServerCallback('rent:DohvatiRent', function(vr)
		Rent = vr
        SpawnCpove()
	end)
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
	for i=1, #Rent, 1 do
		table.insert(Cpovi, {ID = check, Koord = Rent[i].koord, Spawnan = false, rID = Rent[i].ID})
	end
end

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

RegisterCommand("uredirent", function(source, args, raw)
    if perm == 1 then
        local elements = {}

        table.insert(elements, {label = "Novi rent", value = "novi"})
        
        for i=1, #Rent, 1 do
            if Rent[i] ~= nil then
                table.insert(elements, {label = Rent[i].ime, value = Rent[i].ID})
            end
        end

        ESX.UI.Menu.Open(
            'default', GetCurrentResourceName(), 'urent',
            {
                title    = "Izaberite rent",
                align    = 'top-left',
                elements = elements,
            },
            function(data, menu)
                if data.current.value == "novi" then
                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'cijrent', {
                        title = "Upisite cijenu firme",
                    }, function (datar, menur)
                        local cij = tonumber(datar.value)
                        if cij == nil then
                            ESX.ShowNotification('Greska.')
                        else
                            menur.close()
                            local ime = "Rent "..#Rent+1
                            ESX.ShowNotification("Napravili ste "..ime)
                            local koord = GetEntityCoords(PlayerPedId())
                            TriggerServerEvent("rent:NapraviRent", ime, koord, cij)
                            menu.close()
                            Wait(500)
                            ExecuteCommand("uredirent")
                        end
                    end, function (datar, menur)
                        menur.close()
                    end)
                else
                    local rID = data.current.value
                    local id
                    for i = 1, #Rent do
                        if Rent[i].ID == rID then
                            id = i
                            break
                        end
                    end
                    menu.close()
                    elements = {}
                    table.insert(elements, {label = "Uredi koordinatu", value = "koord"})
                    table.insert(elements, {label = "Promijeni cijenu", value = "cijena"})
                    table.insert(elements, {label = "Makni vlasnika", value = "vlasnik"})
                    table.insert(elements, {label = "Sef", value = "sef"})
                    table.insert(elements, {label = "Portaj se", value = "port"})
                    table.insert(elements, {label = "Obrisi rent", value = "obrisi"})
                    ESX.UI.Menu.Open(
                        'default', GetCurrentResourceName(), 'urent2',
                        {
                            title    = "Izaberite opciju",
                            align    = 'top-left',
                            elements = elements,
                        },
                        function(data2, menu2)
                            if data2.current.value == "koord" then
                                local koord = GetEntityCoords(PlayerPedId())
                                TriggerServerEvent("rent:UrediKoord", rID, koord)
                                ESX.ShowNotification("Promijenili ste koordinate renta")
                            elseif data2.current.value == "cijena" then
                                ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'cijrent', {
                                    title = "Upisite cijenu firme",
                                }, function (datar, menur)
                                    local cij = tonumber(datar.value)
                                    if cij == nil then
                                        ESX.ShowNotification('Greska.')
                                    else
                                        menur.close()
                                        TriggerServerEvent("rent:PrCijenu", rID, cij)
                                        ESX.ShowNotification("Promijenili ste cijenu firme")
                                    end
                                end, function (datar, menur)
                                    menur.close()
                                end)
                            elseif data2.current.value == "vlasnik" then
                                TriggerServerEvent("rent:MakniVlasnika", rID)
                                ESX.ShowNotification("Maknuli ste vlasnika renta")
                            elseif data2.current.value == "sef" then
                                --menu2.close()
                                elements = {}
                                table.insert(elements, {label = "Stanje sefa", value = "stanje"})
                                table.insert(elements, {label = "Uzmi iz sefa", value = "uzmi"})
                                table.insert(elements, {label = "Ostavi u sef", value = "ostavi"})
                                ESX.UI.Menu.Open(
                                    'default', GetCurrentResourceName(), 'urent3',
                                    {
                                        title    = "Izaberite opciju",
                                        align    = 'top-left',
                                        elements = elements,
                                    },
                                    function(data3, menu3)
                                        if data3.current.value == "stanje" then
                                            ESX.ShowNotification("U sefu se nalazi $"..Rent[id].sef)
                                        elseif data3.current.value == "uzmi" then
                                            ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'cijrent2', {
                                                title = "Upisite kolicinu",
                                            }, function (datar, menur)
                                                local cij = tonumber(datar.value)
                                                if cij == nil then
                                                    ESX.ShowNotification('Greska.')
                                                else
                                                    menur.close()
                                                    TriggerServerEvent("rent:UzmiIzSefaAdm", rID, cij)
                                                end
                                            end, function (datar, menur)
                                                menur.close()
                                            end)
                                        elseif data3.current.value == "ostavi" then
                                            ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'cijrent2', {
                                                title = "Upisite kolicinu",
                                            }, function (datar, menur)
                                                local cij = tonumber(datar.value)
                                                if cij == nil then
                                                    ESX.ShowNotification('Greska.')
                                                else
                                                    menur.close()
                                                    TriggerServerEvent("rent:OstaviUSefAdm", rID, cij)
                                                end
                                            end, function (datar, menur)
                                                menur.close()
                                            end)
                                        end
                                    end,
                                    function(data3, menu3)
                                        menu3.close()
                                        --ExecuteCommand("uredirent")
                                    end
                                )
                            elseif data2.current.value == "port" then
                                SetEntityCoords(PlayerPedId(), Rent[id].koord)
                                ESX.ShowNotification("Portali ste se do "..Rent[id].ime)
                                menu2.close()
                            elseif data2.current.value == "obrisi" then
                                TriggerServerEvent("rent:ObrisiRent", rID)
                                ESX.ShowNotification("Obrisali ste rent")
                                menu2.close()
                                Wait(500)
                                ExecuteCommand("uredirent")
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

RegisterNetEvent('rent:VratiRent')
AddEventHandler('rent:VratiRent', function(vr)
	Rent = vr
    SpawnCpove()
end)

-- Display markers 
Citizen.CreateThread(function()
	local waitara = 500
	while true do
		Citizen.Wait(waitara)	
		local nasosta = 0
		local coords = GetEntityCoords(GetPlayerPed(-1))	
		local isInMarker = false
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
							local check = CreateCheckpoint(47, kord.x, kord.y, kord.z-1.0, 0, 0, 0, range, 238, 167, 61, 100)
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
                        isInMarker  = true
                        currentZone = Cpovi[i].rID
                        break
					end
				end
			end
		end

		if isInMarker and not hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = true
			LastZone                = currentZone
			TriggerEvent('rent:hasEnteredMarker', currentZone)
		end

		if not isInMarker and hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = false
			TriggerEvent('rent:hasExitedMarker', LastZone)
		end
		
		if CurrentAction ~= nil then
			waitara = 0
			nasosta = 1
			SetTextComponentFormat('STRING')
			AddTextComponentString(CurrentActionMsg)
			DisplayHelpTextFromStringLabel(0, 0, 1, -1)

			if IsControlPressed(0,  38) and (GetGameTimer() - GUI.Time) > 150 then
                OpenRentMenu(CurrentActionData.rID)
				CurrentAction = nil
				GUI.Time      = GetGameTimer()
			end
		end
		
		if nasosta == 0 then
			waitara = 500
		end
	end
end)

AddEventHandler('rent:hasEnteredMarker', function(zone)
    CurrentAction     = 'rent'
    CurrentActionMsg  = "Pritisnite E da otvorite rent menu"
    CurrentActionData = {rID = zone}
end)

AddEventHandler('rent:hasExitedMarker', function(zone)
	ESX.UI.Menu.CloseAll()
	CurrentAction = nil
end)

function OpenRentMenu(rid)
    local id
    for i = 1, #Rent do
        if Rent[i].ID == rid then
            id = i
            break
        end
    end
    local elements = {}

    table.insert(elements, {label = "Izaberite vozilo", value = "vozilo"})
    if Rent[id].vlasnik == nil then
        table.insert(elements, {label = "Kupite firmu", value = "kupi"})
    end

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'menrent',
        {
            title    = "Izaberite opciju",
            align    = 'top-left',
            elements = elements,
        },
        function(data, menu)
            if data.current.value == "vozilo" then

            elseif data.current.value == "kupi" then

            end
        end,
        function(data, menu)
            menu.close()
        end
    )
end