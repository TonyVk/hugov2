ESX                             = nil
local Vrata                     = {}
local spawno                    = false
local perm 						= 0

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

function ProvjeriPosao()
	ESX.PlayerData = ESX.GetPlayerData()
	ESX.TriggerServerCallback('esx-races:DohvatiPermisiju', function(br)
		perm = br
	end)
    ESX.TriggerServerCallback('vrata:DohvatiVrata', function(vr)
		Vrata = vr
	end)
end

RegisterNetEvent('vrata:VratiVrata')
AddEventHandler('vrata:VratiVrata', function(vr)
	Vrata = vr
    for i = 1, #Vrata do
        if IsDoorRegisteredWithSystem(Vrata[i].ime) then
            DoorSystemSetDoorState(Vrata[i].ime, Vrata[i].lock, true, true)
        end
	end
end)

RegisterNetEvent('vrata:ObrisiVrata')
AddEventHandler('vrata:ObrisiVrata', function(ime, vr)
    if IsDoorRegisteredWithSystem(ime) then
        DoorSystemSetDoorState(ime, 0, true, true)
    end
	Vrata = vr
    for i = 1, #Vrata do
        if IsDoorRegisteredWithSystem(Vrata[i].ime) then
            DoorSystemSetDoorState(Vrata[i].ime, Vrata[i].lock, true, true)
        end
	end
end)

RegisterCommand("uredivrata", function(source, args, raw)
    if perm == 1 then
        local elements = {}
        
        for i=1, #Vrata, 1 do
            if Vrata[i] ~= nil then
                table.insert(elements, {label = Vrata[i].ime, value = Vrata[i].ime})
            end
        end

        ESX.UI.Menu.Open(
            'default', GetCurrentResourceName(), 'uvrat',
            {
                title    = "Izaberite vrata",
                align    = 'top-left',
                elements = elements,
            },
            function(data, menu)
                local ime = data.current.value
                local id
                for i = 1, #Vrata do
                    if Vrata[i].ime == ime then
                        id = i
                        break
                    end
                end
                elements = {}
                table.insert(elements, {label = "Promjeni posao", value = "posao"})
                table.insert(elements, {label = "Portaj se", value = "port"})
                table.insert(elements, {label = "Promjeni distancu", value = "dist"})
                table.insert(elements, {label = "Vrata banke (da/ne)", value = "banka"})
                table.insert(elements, {label = "Obrisi vrata", value = "obrisi"})
                ESX.UI.Menu.Open(
                    'default', GetCurrentResourceName(), 'uvrata',
                    {
                        title    = "Izaberite opciju",
                        align    = 'top-left',
                        elements = elements,
                    },
                    function(data2, menu2)
                        if data2.current.value == "posao" then
                            ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'pimevrata', {
                                title = "Upisite id posla (0 ako zelite maknuti posao)",
                            }, function (datari, menuri)
                                local pID = tonumber(datari.value)				
                                if pID == nil or pID < 0 then
                                    ESX.ShowNotification('Greska.')
                                else
                                    menuri.close()
                                    if pID == 0 then
                                        pID = nil
                                    end
                                    TriggerServerEvent("vrata:UrediPosao", ime, pID)
                                end
                            end, function (datari, menuri)
                                menuri.close()
                            end)
                        elseif data2.current.value == "port" then
                            SetEntityCoords(PlayerPedId(), Vrata[id].koord)
                        elseif data2.current.value == "dist" then
                            ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'pdistvrata', {
                                title = "Upisite distancu vrata (npr 3.0)",
                            }, function (datari, menuri)
                                local pDist = tonumber(datari.value)				
                                if pDist == nil or pDist < 1 then
                                    ESX.ShowNotification('Greska.')
                                else
                                    menuri.close()
                                    TriggerServerEvent("vrata:UrediDist", ime, pDist)
                                end
                            end, function (datari, menuri)
                                menuri.close()
                            end)
                        elseif data2.current.value == "obrisi" then
                            TriggerServerEvent("vrata:ObrisiVrata", ime)
                        elseif data2.current.value == "banka" then
                            TriggerServerEvent("vrata:VrataBanke", ime)
                        end
                    end,
                    function(data2, menu2)
                        
                        menu2.close()
                    end
                )
            end,
            function(data, menu)
                menu.close()
            end
        )
    else
        ESX.ShowNotification("Niste admin!")
    end
end, false)

RegisterCommand("dodajvrata", function(source, args, rawCommandString)
    if perm == 1 then
        args[1] = tonumber(args[1])
        if args[1] then
            local posao = nil
            if args[2] then
                posao = tonumber(args[2])
            end
            local nasoih = true
            local prosliobj = nil
            while nasoih do
                if IsPlayerFreeAiming(PlayerId()) then
                    local retval, entity = GetEntityPlayerIsFreeAimingAt(PlayerId())
                    if retval then
                        if entity ~= prosliobj then
                            if prosliobj ~= nil then
                                SetEntityDrawOutline(prosliobj, false)
                                prosliobj = nil
                            end
                            SetEntityDrawOutline(entity, true)
                            prosliobj = entity
                        end
                    end
                end
                if IsControlJustReleased(0, 38) then
                    if prosliobj ~= nil then
                        nasoih = false
                        SetEntityDrawOutline(prosliobj, false)
                        local ime = "vrata_"..#Vrata
                        local koords = GetEntityCoords(prosliobj)
                        TriggerServerEvent("vrata:DodajVrata", ime, koords, posao, args[1], GetEntityModel(prosliobj))
                        ESX.ShowNotification("Uspjesno dodana vrata!")
                    end
                end
                if IsControlJustReleased(0, 73) then
                    nasoih = false
                    if prosliobj ~= nil then
                        SetEntityDrawOutline(prosliobj, false)
                        prosliobj = nil
                        ESX.ShowNotification("Odustali ste od postavljanja vrata!")
                    end
                end
                Wait(0)
            end
        else
            TriggerEvent('chat:addMessage', {
                color = { 255, 0, 0},
                multiline = true,
                args = {"[Komande] ", "/dodajvrata [distanca (5.0)][ID posla (nije obavezno)]"}
            })
            TriggerEvent('chat:addMessage', {
                color = { 255, 0, 0},
                multiline = true,
                args = {"[Komande] ", "ID posla mozete vidjeti kada ukucate /setmafija [Vas ID][0][0]"}
            })
        end
    else
        ESX.ShowNotification("Niste admin!")
    end
end, false)

RegisterCommand('-lockvrata', function()
	local koord = GetEntityCoords(PlayerPedId())
    local lock = 0
	for i = 1, #Vrata do
		if #(koord-Vrata[i].koord) <= Vrata[i].dist then
            if Vrata[i].posao == nil or Vrata[i].posao == ESX.PlayerData.job.id then
                if IsDoorRegisteredWithSystem(Vrata[i].ime) then
                    local state = DoorSystemGetDoorState(Vrata[i].ime)
                    if state == 4 then
                        --DoorSystemSetDoorState(Vrata[i].ime, 0, true, true)
                        TriggerServerEvent("vrata:PromjeniLock", Vrata[i].ime, 0)
                        lock = 1
                    else
                        --DoorSystemSetDoorState(Vrata[i].ime, 4, true, true)
                        TriggerServerEvent("vrata:PromjeniLock", Vrata[i].ime, 4)
                        lock = 2
                    end
                else
                    ESX.ShowNotification("Vrata nisu u sustavu!")
                end
            end
		end
	end
    if lock == 1 then
        ESX.ShowNotification("Okljucana vrata");
    elseif lock == 2 then
        ESX.ShowNotification("Zakljucana vrata");
    end
end, false)

RegisterKeyMapping('-lockvrata', 'Otkljucaj/zakljucaj vrata', 'keyboard', 'e')

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

RegisterNetEvent("Otkljucaj")
AddEventHandler("Otkljucaj", function()
    local koord = GetEntityCoords(PlayerPedId())
    for i = 1, #Vrata do
        if #(koord-Vrata[i].koord) <= Vrata[i].dist then
            if IsDoorRegisteredWithSystem(Vrata[i].ime) then
                local state = DoorSystemGetDoorState(Vrata[i].ime)
                if state == 4 then
                    TriggerServerEvent("vrata:PromjeniLock", Vrata[i].ime, 0)
                end
            end
        end
    end
end)

RegisterNetEvent("Zakljucaj")
AddEventHandler("Zakljucaj", function()
    for i = 1, #Vrata do
        if Vrata[i].banka then
            if IsDoorRegisteredWithSystem(Vrata[i].ime) then
                TriggerServerEvent("vrata:PromjeniLock", Vrata[i].ime, 4)
            end
        end
    end
end)

RegisterNetEvent('vrata:VratiLock')
AddEventHandler('vrata:VratiLock', function(ime, lock)
    for i = 1, #Vrata do
		if Vrata[i].ime == ime then
            Vrata[i].lock = lock
            break
        end
	end
    if IsDoorRegisteredWithSystem(ime) then
        DoorSystemSetDoorState(ime, lock, true, true)
    end
end)

AddEventHandler("playerSpawned", function()
	ESX.TriggerServerCallback('esx-races:DohvatiPermisiju', function(br)
		perm = br
	end)
    Wait(1500)
    spawno = true
end)

RegisterNetEvent('es_admin:setPerm')
AddEventHandler('es_admin:setPerm', function()
	ESX.TriggerServerCallback('esx-races:DohvatiPermisiju', function(br)
		perm = br
	end)
end)

local prikazo = false
local cekaj = 5
Citizen.CreateThread(function()
	while true do
        if not prikazo then
            local koord = GetEntityCoords(PlayerPedId())
            for i = 1, #Vrata do
                if #(koord-Vrata[i].koord) <= Vrata[i].dist then
                    if Vrata[i].posao == nil or Vrata[i].posao == ESX.PlayerData.job.id then
                        ESX.ShowNotification("Pritisnite tipku E da otkljucate/zakljucate vrata", 5000)
                        prikazo = true
                        cekaj = 5
                        break
                    end
                end
            end
        else
            cekaj = cekaj-1
            if cekaj <= 0 then
                prikazo = false
            end
        end
        Citizen.Wait(1000)
	end
end)

Citizen.CreateThread(function()
	while true do
        if spawno then
            local koord = GetEntityCoords(PlayerPedId())
            for i = 1, #Vrata do
                if #(koord-Vrata[i].koord) <= 50 then
                    if Vrata[i].objekt == nil then
                        Vrata[i].objekt = GetClosestObjectOfType(Vrata[i].koord.x, Vrata[i].koord.y, Vrata[i].koord.z, 3.0, Vrata[i].model, false, false, false)
                        if Vrata[i].objekt then
                            if not IsDoorRegisteredWithSystem(Vrata[i].ime) then
                                AddDoorToSystem(Vrata[i].ime, GetEntityModel(Vrata[i].objekt), Vrata[i].koord.x, Vrata[i].koord.y, Vrata[i].koord.z,
                                    false,
                                    true, -- Force closed when locked?
                                    true
                                )
                                local zastita = 0
                                while not DoorSystemGetIsPhysicsLoaded(Vrata[i].ime) and zastita < 50 do
                                    zastita = zastita+1
                                    Wait(10)
                                end
                                DoorSystemSetDoorState(Vrata[i].ime, Vrata[i].lock, true, true)
                            end
                        end
                    end
                else
                    if Vrata[i].objekt ~= nil then
                        RemoveDoorFromSystem(Vrata[i].ime)
                        Vrata[i].objekt = nil
                    end
                end
            end
        end
        Citizen.Wait(1000)
	end
end)